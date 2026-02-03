import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'models/api_error_response.dart';
import 'models/wise_exceptions.dart';

/// A [BeforeSendCallback] that analyzes, categorizes, and fingerprints events.
SentryEvent? wiseSentryBeforeSend(SentryEvent event, {Hint? hint, bool logInDebugMode = false}) {
  // 1. Type guard: ensure we're only processing SentryEvent, not SentryTransaction
  if (event.type == 'transaction') return event;

  // 2. Drop events in debug mode if not explicitly enabled (skip in tests for predictable behavior)
  final isTestEnvironment = Platform.environment.containsKey('FLUTTER_TEST');
  if (!logInDebugMode && kDebugMode && !isTestEnvironment) {
    print('Sentry event dropped in debug mode: ${event.throwable}');
    return null;
  }

  // 3. FILTERING: Drop unnecessary errors (network issues, expected client errors, etc.)
  final filterReason = _shouldFilterError(event.throwable);
  if (filterReason != null) {
    if (kDebugMode && !isTestEnvironment) {
      print('Sentry event filtered ($filterReason): ${_formatErrorForLog(event.throwable)}');
    }
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

  // 7. EXTRAS: Extract extras from WiseException if available
  final Map<String, dynamic>? wiseExtras = throwable is WiseException ? throwable.extras : null;

  // 8. Add normalized endpoint for HttpException
  final Map<String, dynamic> additionalExtras = {};
  if (throwable is HttpException) {
    final normalizedEndpoint = _extractNormalizedEndpoint(throwable.message);
    if (normalizedEndpoint != null) {
      additionalExtras['normalized_endpoint'] = normalizedEndpoint;
    }
  }

  // 9. RETURN: Copy event with new fingerprint, tags, and extras
  return enrichedEvent.copyWith(
    fingerprint: newFingerprint,
    tags: {
      ...enrichedEvent.tags ?? {},
      'error-category': category,
      if (wiseType != null) 'wise-type': wiseType,
    },
    extra: {
      ...enrichedEvent.extra ?? {},
      if (wiseExtras != null) ...wiseExtras,
      ...additionalExtras,
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
        // Preserve the original exception data but update type and value
        final originalException = event.exceptions?.firstOrNull;
        final newException = originalException?.copyWith(
              type: e.runtimeType.toString(),
              value: e.toString(),
            ) ??
            SentryException(
              type: e.runtimeType.toString(),
              value: e.toString(),
            );

        return event.copyWith(
          throwable: e,
          message: SentryMessage(e.toString()),
          exceptions: [newException],
        );
      }
    }
  }
  return event;
}

/// Determines the high-level error category for Sentry grouping.
String _getErrorCategory(Object? throwable, SentryEvent event) {
  if (throwable is WiseException) {
    if (throwable is UIException) return 'ui';
    if (throwable is DTOException) return 'dto';
    if (throwable is MapperException || throwable is WiseTypeException) return 'mapper';
    if (throwable is HttpException) return 'network';
  } else if (throwable is DioException) {
    return 'network';
  } else if (throwable is FlutterError) {
    return 'flutter';
  } else if (throwable is FormatException) {
    return 'dto';
  } else if (throwable is TypeError) {
    // Check if TypeError is in DTO context, otherwise categorize based on stack trace
    if (_isTypeErrorInDTOContext(event)) {
      return 'dto';
    }
    // Fall through to stack trace analysis below
  }

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

  return 'uncategorized';
}

/// Returns the WiseException subtype as a string for tagging.
String? _getWiseType(Object? throwable) {
  if (throwable is WiseException) {
    if (throwable is UIException) return 'UIException';
    if (throwable is DTOException) return 'DTOException';
    if (throwable is MapperException) return 'MapperException';
    if (throwable is WiseTypeException) return 'WiseTypeException';
    if (throwable is HttpException) return 'HttpException';
    return 'WiseException';
  }
  return null;
}

/// Builds a granular fingerprint for Sentry event grouping.
List<String> _buildFingerprint(SentryEvent event, String category) {
  final throwable = event.throwable;
  final exceptionType = throwable.runtimeType.toString();
  var exceptionValue = event.message?.formatted ?? throwable.toString();

  // For HttpException, normalize URLs to group similar errors together
  if (throwable is HttpException) {
    exceptionValue = _normalizeHttpExceptionMessage(exceptionValue);
  }

  // For FlutterError, use the transaction/route as location since stack traces
  // typically only contain framework code (not user widget code)
  var location = 'unknown_location';
  if (exceptionType == 'FlutterError') {
    // Try to extract widget type from error message (e.g., "A RenderFlex overflowed...")
    final widgetType = _extractWidgetTypeFromFlutterError(exceptionValue);
    final route = event.transaction ?? 'unknown_route';
    // Combine route with widget type for more granular grouping
    location = widgetType != null ? '$route/$widgetType' : route;
  } else {
    // Find the first in-app frame for other errors
    final exceptionStackFrames = event.exceptions?.lastOrNull?.stackTrace?.frames;
    final threadStackFrames = event.threads?.lastOrNull?.stacktrace?.frames;
    final Iterable<SentryStackFrame>? framesToSearch = exceptionStackFrames ?? threadStackFrames;
    if (framesToSearch?.isNotEmpty ?? false) {
      for (final frame in framesToSearch!) {
        if ((frame.inApp ?? false) && frame.fileName != null) {
          // Skip Sentry/WiseSentry internal frames
          if (!frame.fileName!.contains('sentry') && !frame.fileName!.contains('core.dart')) {
            location = frame.fileName!;
            break;
          }
        }
      }
    }
  }

  return [category, location, exceptionType, exceptionValue];
}

/// Extracts widget type from FlutterError messages (e.g., "RenderFlex" from overflow errors).
String? _extractWidgetTypeFromFlutterError(String message) {
  // Match patterns like "A RenderFlex overflowed" or "RenderBox was not laid out"
  final renderMatch = RegExp(r'(Render\w+)').firstMatch(message);
  if (renderMatch != null) {
    return renderMatch.group(1);
  }

  // Match patterns like "Incorrect use of ParentDataWidget"
  final widgetMatch = RegExp(r'(\w+Widget)').firstMatch(message);
  if (widgetMatch != null) {
    return widgetMatch.group(1);
  }

  return null;
}

/// Extracts detailed information from FlutterError messages for debugging.
Map<String, dynamic> _extractFlutterErrorDetails(String message) {
  final details = <String, dynamic>{};

  // Extract overflow information
  final overflowMatch = RegExp(r'overflowed by ([\d.]+) pixels? on the (top|bottom|left|right)').firstMatch(message);
  if (overflowMatch != null) {
    details['overflow_pixels'] = overflowMatch.group(1);
    details['overflow_side'] = overflowMatch.group(2);
    details['error_type'] = 'overflow';
  }

  // Extract widget type
  final widgetType = _extractWidgetTypeFromFlutterError(message);
  if (widgetType != null) {
    details['widget_type'] = widgetType;
  }

  // Extract parent widget if mentioned (e.g., "The overflowing RenderFlex has...")
  final parentMatch = RegExp(r'The (\w+) has').firstMatch(message);
  if (parentMatch != null) {
    details['parent_widget'] = parentMatch.group(1);
  }

  return details;
}

/// Checks if a FlutterError message indicates a UI/layout error.
bool _isUIError(String message) {
  final uiPatterns = [
    'overflowed',
    'constraint',
    'RenderBox',
    'RenderFlex',
    'layout',
    'painting',
    'size',
    'positioned',
    'unbounded',
  ];

  final lowerMessage = message.toLowerCase();
  return uiPatterns.any((pattern) => lowerMessage.contains(pattern.toLowerCase()));
}

/// Checks if a FlutterError message indicates a lifecycle/state error.
bool _isLifecycleError(String message) {
  final lifecyclePatterns = [
    'setState',
    'disposed',
    'unmounted',
    'after dispose',
    'during build',
    'BuildContext',
  ];

  final lowerMessage = message.toLowerCase();
  return lifecyclePatterns.any((pattern) => lowerMessage.contains(pattern.toLowerCase()));
}

/// Normalizes HttpException messages by replacing dynamic URL segments.
String _normalizeHttpExceptionMessage(String message) {
  final normalizedEndpoint = _extractNormalizedEndpoint(message);
  if (normalizedEndpoint == null) return message;

  // Replace the URL in the message with the normalized version
  return message.replaceAllMapped(
    RegExp(r'(GET|POST|PUT|PATCH|DELETE|HEAD|OPTIONS)\s+([^\s?]+)'),
    (match) => '${match.group(1)} $normalizedEndpoint',
  );
}

/// Extracts and normalizes the endpoint pattern from an HTTP error message or URL.
/// Returns the normalized path (without query params) with IDs replaced.
String? _extractNormalizedEndpoint(String message) {
  // Try to extract URL from the message (e.g., "Dio Request Failed (404): GET /api/v1/users/123")
  final urlMatch = RegExp(r'(?:GET|POST|PUT|PATCH|DELETE|HEAD|OPTIONS)\s+([^\s?]+)').firstMatch(message);
  if (urlMatch == null) return null;

  var path = urlMatch.group(1)!;

  // Replace UUIDs with :id
  path = path.replaceAll(
    RegExp(r'[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}', caseSensitive: false),
    ':id',
  );

  // Replace numeric IDs (standalone numbers as path segments)
  // This handles /users/123, /apps/456, etc.
  path = path.replaceAll(
    RegExp(r'/\d+(?=/|$)'),
    '/:id',
  );

  // Replace alphanumeric IDs that look like resource identifiers
  // This handles /apps1122 -> /apps:id (word followed by numbers)
  path = path.replaceAll(
    RegExp(r'/([a-z_]+)\d+(?=/|$)'),
    r'/\1:id',
  );

  return path;
}

/// Determines whether an error should be filtered out (not sent to Sentry).
/// Returns a reason string if the error should be filtered, or null if it should be logged.
String? _shouldFilterError(dynamic throwable) {
  if (throwable is DioException) {
    final method = throwable.requestOptions.method.toUpperCase();
    final statusCode = throwable.response?.statusCode;
    final hasUserParams = throwable.requestOptions.queryParameters?.isNotEmpty == true;

    // GET: Only log 400/422/404 with user params, or always log 401/403/404
    if (method == 'GET') {
      // Always log authentication/authorization errors and not found errors
      if (statusCode == 401 || statusCode == 403 || statusCode == 404) {
        return null; // Don't filter - log to Sentry
      }
      // Log validation errors only when they involve user input
      final shouldLog = hasUserParams && (statusCode == 400 || statusCode == 422);
      return shouldLog ? null : 'GET client error without user params';
    }

    // POST/PUT/PATCH/DELETE: filter server/network errors
    if (method == 'POST' || method == 'PUT' || method == 'PATCH' || method == 'DELETE') {
      if (statusCode != null && statusCode >= 500) {
        return 'server error 5xx';
      }
      const filteredTypes = {
        DioExceptionType.connectionTimeout,
        DioExceptionType.sendTimeout,
        DioExceptionType.receiveTimeout,
        DioExceptionType.connectionError,
        DioExceptionType.cancel,
        DioExceptionType.badCertificate,
        DioExceptionType.unknown,
      };
      if (filteredTypes.contains(throwable.type)) {
        return 'network/connection error: ${throwable.type.name}';
      }
    }
    return 'unhandled HTTP method/status';
  }

  // NetworkExceptions: Filter all network-related errors
  if (throwable is SocketException) {
    return 'network error: SocketException';
  }
  if (throwable is HandshakeException) {
    return 'network error: HandshakeException';
  }
  if (throwable is HttpException) {
    return 'network error: HttpException';
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
    if (patterns.any(message.contains)) {
      return 'network error: ${throwable.message}';
    }
  }

  // Provider errors (Riverpod): TODO: Add specific filtering for known non-breaking errors
  // Example: if (throwable is SomeProviderException && throwable.message.contains('Future is already completed')) return 'provider: future already completed';

  return null; // Don't filter
}

/// Converts raw TypeErrors and FormatExceptions to WiseExceptions.
WiseException? _convertToWiseException(Object throwable, SentryEvent event, Hint? hint) {
  // Convert DioException to HttpException with parsed API error
  if (throwable is DioException) {
    return WiseException.fromDioException(throwable);
  }

  // Convert FlutterError to appropriate WiseException based on error type
  if (throwable is FlutterError) {
    final message = throwable.message;
    final errorDetails = _extractFlutterErrorDetails(message);
    final stackTrace = throwable.stackTrace ?? hint?.get('stackTrace') as StackTrace?;

    // Categorize FlutterError based on message content
    if (_isUIError(message)) {
      return UIException(
        message,
        originalError: throwable,
        stackTrace: stackTrace,
        extras: errorDetails,
      );
    } else if (_isLifecycleError(message)) {
      // Lifecycle errors are also UI-related (e.g., setState after dispose)
      return UIException(
        message,
        originalError: throwable,
        stackTrace: stackTrace,
        extras: {...errorDetails, 'error_subtype': 'lifecycle'},
      );
    } else {
      // Default to UIException for most FlutterError cases
      return UIException(
        message,
        originalError: throwable,
        stackTrace: stackTrace,
        extras: {...errorDetails, 'flutter_error_type': 'other'},
      );
    }
  }

  if (throwable is TypeError) {
    final errorMessage = throwable.toString();
    final expectedType = _extractExpectedType(errorMessage);
    final problematicLine = _extractProblematicLine(event);
    final jsonContext = hint?.get('json');
    final stackTrace = hint?.get('stackTrace') as StackTrace?;

    // Check if TypeError is actually happening in DTO/mapper code by analyzing stack trace
    final isDTOError = _isTypeErrorInDTOContext(event);

    if (isDTOError) {
      return DTOException(
        'Type error during DTO deserialization: $errorMessage',
        originalError: throwable,
        stackTrace: stackTrace,
        extras: {
          if (expectedType != null) 'expected_type': expectedType,
          if (problematicLine != null) 'problematic_line': problematicLine,
          if (jsonContext != null) 'json': jsonContext,
        },
      );
    } else {
      // TypeError in UI/business logic code - treat as UIException
      return UIException(
        'Type error: $errorMessage',
        originalError: throwable,
        stackTrace: stackTrace,
        extras: {
          if (expectedType != null) 'expected_type': expectedType,
          if (problematicLine != null) 'problematic_line': problematicLine,
        },
      );
    }
  } else if (throwable is FormatException) {
    final jsonContext = hint?.get('json');

    return DTOException(
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

/// Checks if a TypeError occurred in DTO/mapper context by analyzing the stack trace.
bool _isTypeErrorInDTOContext(SentryEvent event) {
  final frames = event.exceptions?.lastOrNull?.stackTrace?.frames ?? event.threads?.lastOrNull?.stacktrace?.frames;

  if (frames == null || frames.isEmpty) return false;

  // Look through stack frames for DTO/mapper indicators
  for (final frame in frames.reversed) {
    final path = frame.absPath ?? frame.fileName ?? '';
    final function = frame.function ?? '';

    // Check for DTO/mapper file patterns
    if (path.contains('_mapper.dart') ||
        path.contains('_dto.dart') ||
        path.contains('/dto/') ||
        path.contains('/dtos/') ||
        path.contains('/models/')) {
      return true;
    }

    // Check for JSON/deserialization function names
    if (function.contains('fromJson') || function.contains('toJson') || function.contains('deserialize') || function.contains('parse')) {
      return true;
    }
  }

  // If no DTO context found, it's likely a regular type error in UI/business logic
  return false;
}

/// Formats an error for logging with structured API error details if available.
String _formatErrorForLog(dynamic throwable) {
  if (throwable is DioException) {
    final method = throwable.requestOptions.method;
    final path = throwable.requestOptions.path;
    final statusCode = throwable.response?.statusCode;
    final data = throwable.response?.data;

    final summary = StringBuffer('$method $path');
    if (statusCode != null) {
      summary.write(' → $statusCode');
    }

    // Try to parse the standard API error response
    final apiError = ApiErrorResponse.fromJson(data);
    if (apiError != null) {
      summary.write(' - ${apiError.getSummary()}');
    }

    return summary.toString();
  }
  return throwable.toString();
}
