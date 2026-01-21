import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../wise_sentry.dart';
import 'logger/http_error_logger.dart';
import 'logger/sentry_logger.dart';
import 'sentry_before_send.dart';

export 'interceptors/http_interceptors.dart';

/// Wise Sentry class
class WiseSentry {
  /// Initialize Wisemen Sentry
  /// [dsn] Sentry DSN
  /// [appRunner] Function that runs the main app widget
  /// [environment] Optional environment string (e.g., 'production', 'staging')
  /// [productionSampleRate] Sample rate for production environment (default is 0.2)
  /// [logInDebugMode] Whether to log errors in debug mode (default is false)
  static Future<void> init({
    required String? dsn,
    required Widget Function() appRunner,
    String? environment,
    double productionSampleRate = 0.2,
    bool logInDebugMode = false,
  }) async {
    if (dsn == null || dsn.isEmpty) {
      // If no DSN is provided, run the app without Sentry
      print('WiseSentry: No DSN provided, running without Sentry.');
      runApp(appRunner());
      return;
    }

    await SentryFlutter.init(
      (options) {
        options
          ..dsn = dsn
          ..environment = environment
          ..tracesSampleRate = environment == 'production' ? productionSampleRate : 1.0
          ..enableAppHangTracking = false
          ..beforeSend = (event, hint) => wiseSentryBeforeSend(
                event,
                hint: hint,
                logInDebugMode: logInDebugMode,
              );
      },
      appRunner: () => runApp(
        SentryWidget(child: appRunner()),
      ),
    );
  }

  /// Log an error to Sentry
  /// [error] The error object
  /// [stackTrace] The stack trace associated with the error
  /// [extras] Optional additional data to send with the error
  static void captureException(
    dynamic error,
    StackTrace stackTrace, {
    Map<String, dynamic>? extras,
  }) {
    var combinedExtras = extras;

    if (error is WiseException) {
      if (error.extras != null) {
        combinedExtras = {
          ...(combinedExtras ?? {}),
          ...error.extras!,
        };
      }
    }

    Sentry.captureException(
      error,
      stackTrace: stackTrace,
      withScope: (scope) {
        if (combinedExtras != null) {
          combinedExtras.forEach((key, value) {
            scope.setContexts(key, value);
          });
        }
      },
    );
  }

  /// Set user data in Sentry scope
  /// [uuid] The user ID to set
  /// [data] Additional user data as a map
  static void setUserData({required String uuid, Map<String, dynamic>? data}) {
    Sentry.configureScope((scope) {
      scope.setUser(SentryUser(id: uuid, data: data));
    });
  }

  /// Clear user data from Sentry scope
  static void clearUserData() {
    Sentry.configureScope((scope) {
      scope.setUser(null);
    });
  }

  /// Log an HTTP dio error using the HttpErrorLogger
  static void logDioError(DioException e, StackTrace stackTrace) {
    HttpErrorLogger.logDioError(e, stackTrace);
  }

  /// Log an HTTP dio error using the HttpErrorLogger
  static void captureDioException(DioException e, StackTrace stackTrace) {
    HttpErrorLogger.logDioError(e, stackTrace);
  }

  /// Log a UI error to Sentry
  static void logUIError(dynamic e, StackTrace stackTrace) {
    WiseSentryLogger.capture(
      UIError(
        e.toString(),
        originalError: e,
        stackTrace: stackTrace,
      ),
      stackTrace,
    );
  }
}
