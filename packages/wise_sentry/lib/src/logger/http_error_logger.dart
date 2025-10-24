import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:wise_sentry/src/models/wise_exceptions.dart';

/// Logger for HTTP errors
/// Handles logging of various HTTP-related exceptions to Sentry
/// Includes filtering for common network exceptions
class HttpErrorLogger {
  /// Logs HTTP errors to Sentry
  static void logHttpError(DioException e, StackTrace stackTrace) {
    final wiseException = WiseException.fromDioException(e);

    //log to sentry
    Sentry.captureException(
      wiseException,
      stackTrace: stackTrace,
      withScope: (scope) {
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
