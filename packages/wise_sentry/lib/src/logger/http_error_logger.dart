import 'package:dio/dio.dart';
import 'package:wise_sentry/src/logger/sentry_logger.dart';
import 'package:wise_sentry/src/models/wise_exceptions.dart';

/// A function that converts an exception of type [T] into a [WiseException].
typedef WiseExceptionConverter<T> = WiseException Function(T exception);

/// Logger for HTTP errors
/// Handles logging of various HTTP-related exceptions to Sentry
/// Includes filtering for common network exceptions
class HttpErrorLogger {
  /// Logs HTTP errors to Sentry
  static void logDioError(
    DioException e,
    StackTrace stackTrace, {
    WiseExceptionConverter<DioException>? exceptionConverter,
  }) {
    final wiseException = exceptionConverter != null ? exceptionConverter(e) : WiseException.fromDioException(e);

    //log to sentry
    WiseSentryLogger.capture(
      wiseException,
      stackTrace,
      configureScope: (scope) {
        scope
          ..setContexts('Request details', {
            'method': e.requestOptions.method,
            'url': e.requestOptions.uri.toString(),
            'headers': e.requestOptions.headers,
            'query_parameters': e.requestOptions.queryParameters,
            'body': e.requestOptions.data,
          })
          ..setContexts('Response details', {
            'status_code': e.response?.statusCode,
            'headers': e.response?.headers,
            'data': (wiseException as HttpError).errorBody,
          });
      },
    );
  }
}
