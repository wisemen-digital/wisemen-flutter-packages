import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'logger/http_error_logger.dart';

export 'interceptors/http_interceptors.dart';

/// Wise Sentry class
class WiseSentry {
  /// Log an error to Sentry
  /// [error] The error object
  /// [stackTrace] The stack trace associated with the error
  static void logError(dynamic error, StackTrace stackTrace) {
    Sentry.captureException(
      error,
      stackTrace: stackTrace,
    );
  }

  /// Set user data in Sentry scope
  /// [id] The user ID to set
  static void setUserData(String id) {
    Sentry.configureScope((scope) {
      scope.setUser(SentryUser(id: id));
    });
  }

  /// Clear user data from Sentry scope
  static void clearUserData() {
    Sentry.configureScope((scope) {
      scope.setUser(null);
    });
  }

  /// Log an HTTP error using the HttpErrorLogger
  static void logHttpError(DioException e, StackTrace stackTrace) {
    HttpErrorLogger.logHttpError(e, stackTrace);
  }

  /// Log a UI error to Sentry
  static void logUIError(dynamic e, StackTrace stackTrace) {}
}
