import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'models/wise_exceptions.dart';

/// A [BeforeSendCallback] that analyzes, categorizes, and fingerprints events.
SentryEvent? wiseSentryBeforeSend(SentryEvent event, {Hint? hint, bool logInDebugMode = false}) {
  // Type guard: ensure we're only processing SentryEvent, not SentryTransaction
  // In some cases, Sentry may pass other types through this callback
  if (event.type == 'transaction') {
    return event; // Pass through transactions unchanged
  }

  // Preserve existing logic: drop events in debug mode if not explicitly enabled.
  if (!logInDebugMode && kDebugMode) {
    // ignore: avoid_print
    print('Sentry event dropped in debug mode: ${event.throwable}');
    return null;
  }

  // --- FILTERING: Drop unnecessary network/connection errors ---
  if (_shouldFilterError(event.throwable)) {
    if (kDebugMode) {
      // ignore: avoid_print
      print('Sentry event filtered (network/connection error): ${event.throwable}');
    }
    return null;
  }

  // --- ENRICHMENT: Convert raw TypeErrors and FormatExceptions to WiseExceptions ---
  var enrichedEvent = event;

  // Only enrich if it's NOT already a WiseException (preserve user overrides)
  if (event.throwable != null && event.throwable is! WiseException) {
    try {
      final wiseException = _convertToWiseException(event.throwable!, event, hint);
      if (wiseException != null) {
        throw wiseException;
      }
    } catch (e) {
      // If it's a WiseException we just created, update the event with it
      if (e is WiseException) {
        enrichedEvent = event.copyWith(throwable: e, message: SentryMessage(e.toString()));
      }
      // If conversion fails for other reasons, continue with original event
    }
  }

  // --- Granular Fingerprinting Logic ---

  // 1. Determine the high-level category for the error.
  var category = 'uncategorized';
  final throwable = enrichedEvent.throwable;

  if (throwable is WiseException) {
    if (throwable is UIError) {
      category = 'ui';
    } else if (throwable is DTOError) {
      category = 'dto';
    } else if (throwable is MapperError || throwable is WiseTypeError) {
      category = 'mapper';
    } else if (throwable is BusinessLogicError) {
      category = 'business-logic';
    } else if (throwable is HttpError) {
      category = 'network';
    }
  } else if (throwable is DioException) {
    category = 'network';
  } else if (throwable is FlutterError) {
    category = 'flutter';
  } else if (throwable is FormatException) {
    category = 'dto';
  } else if (throwable is TypeError) {
    category = 'dto';
  } else {
    // Fallback to stack trace analysis if no specific type matches.
    final stackTrace = enrichedEvent.threads?.lastOrNull?.stacktrace;
    if (stackTrace?.frames.isNotEmpty ?? false) {
      for (final frame in stackTrace!.frames.reversed) {
        final path = frame.absPath ?? frame.fileName ?? '';
        if (path.contains('_mapper.dart')) {
          category = 'mapper';
          break;
        }
        if (path.contains('_repository.dart')) {
          category = 'repository';
          break;
        }
        if (path.contains('_page.dart') || path.contains('_view.dart') || path.contains('/ui/')) {
          category = 'ui';
          break;
        }
      }
    }
  }

  // 2. Extract additional details for a granular fingerprint.
  final exceptionType = throwable.runtimeType.toString();
  final exceptionValue = enrichedEvent.message?.formatted ?? throwable.toString();

  // Find the first in-app frame for a more accurate location.
  var location = 'unknown_location';
  // Prioritize exception's stack trace, then fall back to thread's stack trace.
  final exceptionStackFrames = enrichedEvent.exceptions?.lastOrNull?.stackTrace?.frames;
  final threadStackFrames = enrichedEvent.threads?.lastOrNull?.stacktrace?.frames;

  final Iterable<SentryStackFrame>? framesToSearch = exceptionStackFrames ?? threadStackFrames;

  if (framesToSearch?.isNotEmpty ?? false) {
    for (final frame in framesToSearch!) {
      // Check if the frame is in-app and has a file name.
      if ((frame.inApp ?? false) && frame.fileName != null) {
        location = frame.fileName!;
        break;
      }
    }
  }

  // 3. Construct the new fingerprint.
  final newFingerprint = [
    category,
    location,
    exceptionType,
    exceptionValue,
  ];

  return enrichedEvent.copyWith(
    fingerprint: newFingerprint,
    tags: {
      ...enrichedEvent.tags ?? {},
      'error-category': category,
    },
  );
}

/// Determines whether an error should be filtered out (not sent to Sentry).
/// Returns true for network/connection errors that are expected and not actionable.
bool _shouldFilterError(dynamic throwable) {
  // Filter Dio connection/network errors
  if (throwable is DioException) {
    // Filter client errors (4xx) for GET requests only
    // POST/PUT/PATCH/DELETE errors are kept for tracking (may indicate data issues)
    if (throwable.type == DioExceptionType.badResponse) {
      final statusCode = throwable.response?.statusCode;
      final method = throwable.requestOptions.method.toUpperCase();

      // Filter all server errors (5xx)
      if (statusCode != null && statusCode >= 500) {
        return true;
      }

      // Filter GET client errors (4xx)
      if (statusCode != null && statusCode >= 400 && statusCode < 500 && method == 'GET') {
        return true;
      }

      // Check underlying error for non-filtered responses
      return _shouldFilterError(throwable.error);
    }

    switch (throwable.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return true; // Filter these out
      default:
        return false;
    }
  }

  // Filter SocketException (network unreachable, host lookup failed, etc.)
  if (throwable is SocketException) {
    return true;
  }

  // Filter SSL/TLS handshake failures
  if (throwable is HandshakeException) {
    return true;
  }

  // Filter HttpException (generic HTTP connection issues)
  if (throwable is HttpException) {
    return true;
  }

  // Filter OSError with connection-related messages
  if (throwable is OSError) {
    final message = throwable.message.toLowerCase();
    if (message.contains('connection refused') ||
        message.contains('connection reset') ||
        message.contains('connection closed') ||
        message.contains('connection aborted') ||
        message.contains('network is unreachable') ||
        message.contains('no route to host') ||
        message.contains('software caused connection abort')) {
      return true;
    }
  }

  return false;
}

/// Converts raw TypeErrors and FormatExceptions to WiseExceptions.
WiseException? _convertToWiseException(Object throwable, SentryEvent event, Hint? hint) {
  if (throwable is TypeError) {
    final errorMessage = throwable.toString();
    final expectedType = _extractExpectedType(errorMessage);
    final problematicLine = _extractProblematicLine(event);
    final jsonContext = hint?.get('json');

    return DTOError(
      'Type error during DTO deserialization: $errorMessage',
      originalError: throwable,
      stackTrace: hint?.get('stackTrace') as StackTrace?,
      extras: {
        if (expectedType != null) 'expected_type': expectedType,
        if (problematicLine != null) 'problematic_line': problematicLine,
        if (jsonContext != null) 'json': jsonContext,
      },
    );
  } else if (throwable is FormatException) {
    final jsonContext = hint?.get('json');

    return DTOError(
      'Format error during DTO deserialization: ${throwable.message}',
      originalError: throwable,
      stackTrace: hint?.get('stackTrace') as StackTrace?,
      extras: {
        if (throwable.offset != null) 'offset': throwable.offset,
        if (jsonContext != null) 'json': jsonContext,
      },
    );
  }

  return null;
}

/// Extracts the expected type from a TypeError message.
String? _extractExpectedType(String errorMessage) {
  if (!errorMessage.contains('is not a subtype of')) return null;

  final parts = errorMessage.split('is not a subtype of');
  if (parts.length <= 1) return null;

  return parts[1].split(' in type cast').first.trim();
}

/// Extracts the problematic line of code from the stack trace.
String? _extractProblematicLine(SentryEvent event) {
  if (kIsWeb) return null;

  try {
    final frames = event.exceptions?.lastOrNull?.stackTrace?.frames ?? event.threads?.lastOrNull?.stacktrace?.frames;

    if (frames == null || frames.isEmpty) return null;

    for (final frame in frames) {
      if (!(frame.inApp ?? false)) continue;

      final absPath = frame.absPath;
      final lineNo = frame.lineNo;

      if (absPath == null || lineNo == null) continue;

      final uri = Uri.tryParse(absPath);
      if (uri?.scheme != 'file') continue;

      final file = File.fromUri(uri!);
      if (!file.existsSync()) continue;

      final lines = file.readAsLinesSync();
      if (lineNo > 0 && lineNo <= lines.length) {
        return lines[lineNo - 1].trim();
      }
    }
  } catch (_) {
    // Silently fail - this is best-effort enrichment
  }

  return null;
}
