import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'models/wise_exceptions.dart';

/// A [BeforeSendCallback] that analyzes, categorizes, and fingerprints events.
SentryEvent? wiseSentryBeforeSend(SentryEvent event, {Hint? hint, bool logInDebugMode = false}) {
  // 1. Type guard: ensure we're only processing SentryEvent, not SentryTransaction
  if (event.type == 'transaction') return event;

  // 2. Drop events in debug mode if not explicitly enabled
  if (!logInDebugMode && kDebugMode) {
    print('Sentry event dropped in debug mode: ${event.throwable}');
    return null;
  }

  // 3. FILTERING: Drop unnecessary network/connection errors
  if (_shouldFilterError(event.throwable)) {
    if (kDebugMode) print('Sentry event filtered (network/connection error): ${event.throwable}');
    return null;
  }

  // 4. ENRICHMENT: Convert raw TypeErrors and FormatExceptions to WiseExceptions
  final enrichedEvent = _enrichEventWithWiseException(event, hint);

  // 5. CATEGORIZATION: Determine error category and wise-type tag
  final throwable = enrichedEvent.throwable;
  final category = _getErrorCategory(throwable, enrichedEvent);
  final wiseType = _getWiseType(throwable);

  // 6. FINGERPRINT: Build a granular fingerprint for Sentry grouping
  final newFingerprint = _buildFingerprint(enrichedEvent, category);

  // 7. RETURN: Copy event with new fingerprint and tags
  return enrichedEvent.copyWith(
    fingerprint: newFingerprint,
    tags: {
      ...enrichedEvent.tags ?? {},
      'error-category': category,
      if (wiseType != null) 'wise-type': wiseType,
    },
  );
}

/// Enriches the event with a WiseException if possible.
SentryEvent _enrichEventWithWiseException(SentryEvent event, Hint? hint) {
  if (event.throwable != null && event.throwable is! WiseException) {
    try {
      final wiseException = _convertToWiseException(event.throwable!, event, hint);
      if (wiseException != null) {
        throw wiseException;
      }
    } catch (e) {
      if (e is WiseException) {
        return event.copyWith(throwable: e, message: SentryMessage(e.toString()));
      }
    }
  }
  return event;
}

/// Determines the high-level error category for Sentry grouping.
String _getErrorCategory(Object? throwable, SentryEvent event) {
  if (throwable is WiseException) {
    if (throwable is UIError) return 'ui';
    if (throwable is DTOError) return 'dto';
    if (throwable is MapperError || throwable is WiseTypeError) return 'mapper';
    if (throwable is BusinessLogicError) return 'business-logic';
    if (throwable is HttpError) return 'network';
  } else if (throwable is DioException) {
    return 'network';
  } else if (throwable is FlutterError) {
    return 'flutter';
  } else if (throwable is FormatException) {
    return 'dto';
  } else if (throwable is TypeError) {
    return 'dto';
  } else {
    // Fallback to stack trace analysis if no specific type matches.
    final stackTrace = event.threads?.lastOrNull?.stacktrace;
    if (stackTrace?.frames.isNotEmpty ?? false) {
      for (final frame in stackTrace!.frames.reversed) {
        final path = frame.absPath ?? frame.fileName ?? '';
        if (path.contains('_mapper.dart')) return 'mapper';
        if (path.contains('_repository.dart')) return 'repository';
        if (path.contains('_page.dart') || path.contains('_view.dart') || path.contains('_widget.dart') || path.contains('/ui/')) return 'ui';
      }
    }
  }
  return 'uncategorized';
}

/// Returns the WiseException subtype as a string for tagging.
String? _getWiseType(Object? throwable) {
  if (throwable is WiseException) {
    if (throwable is UIError) return 'UIError';
    if (throwable is DTOError) return 'DTOError';
    if (throwable is MapperError) return 'MapperError';
    if (throwable is WiseTypeError) return 'WiseTypeError';
    if (throwable is BusinessLogicError) return 'BusinessLogicError';
    if (throwable is HttpError) return 'HttpError';
    return 'WiseException';
  }
  return null;
}

/// Builds a granular fingerprint for Sentry event grouping.
List<String> _buildFingerprint(SentryEvent event, String category) {
  final throwable = event.throwable;
  final exceptionType = throwable.runtimeType.toString();
  final exceptionValue = event.message?.formatted ?? throwable.toString();

  // Find the first in-app frame for a more accurate location.
  var location = 'unknown_location';
  final exceptionStackFrames = event.exceptions?.lastOrNull?.stackTrace?.frames;
  final threadStackFrames = event.threads?.lastOrNull?.stacktrace?.frames;
  final Iterable<SentryStackFrame>? framesToSearch = exceptionStackFrames ?? threadStackFrames;
  if (framesToSearch?.isNotEmpty ?? false) {
    for (final frame in framesToSearch!) {
      if ((frame.inApp ?? false) && frame.fileName != null) {
        location = frame.fileName!;
        break;
      }
    }
  }
  return [category, location, exceptionType, exceptionValue];
}
}

/// Determines whether an error should be filtered out (not sent to Sentry).
/// Returns true for network/connection errors that are expected and not actionable.
bool _shouldFilterError(dynamic throwable) {
  if (throwable is DioException) {
    final method = throwable.requestOptions.method.toUpperCase();
    final statusCode = throwable.response?.statusCode;
    final hasUserParams = throwable.requestOptions.queryParameters?.isNotEmpty == true;

    // GET: Only log 400/422 with user params
    if (method == 'GET') {
      return !(hasUserParams && (statusCode == 400 || statusCode == 422));
    }

    // POST/PUT/PATCH/DELETE: filter server/network errors
    if (method == 'POST' || method == 'PUT' || method == 'PATCH' || method == 'DELETE') {
      if (statusCode != null && statusCode >= 500) return true;
      const filteredTypes = {
        DioExceptionType.connectionTimeout,
        DioExceptionType.sendTimeout,
        DioExceptionType.receiveTimeout,
        DioExceptionType.connectionError,
        DioExceptionType.cancel,
        DioExceptionType.badCertificate,
        DioExceptionType.unknown,
      };
      return filteredTypes.contains(throwable.type);
    }
    return true;
  }

  // NetworkExceptions: Filter all network-related errors
  if (throwable is SocketException || throwable is HandshakeException || throwable is HttpException) {
    return true;
  }

  if (throwable is OSError) {
    final message = throwable.message.toLowerCase();
    const patterns = [
      'connection refused',
      'connection reset',
      'connection closed',
      'connection aborted',
      'network is unreachable',
      'no route to host',
      'software caused connection abort',
    ];
    return patterns.any(message.contains);
  }

  // Provider errors (Riverpod): TODO: Add specific filtering for known non-breaking errors
  // Example: if (throwable is SomeProviderException && throwable.message.contains('Future is already completed')) return true;

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
