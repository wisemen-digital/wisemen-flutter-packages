import 'package:sentry_flutter/sentry_flutter.dart';

/// A central logger for reporting exceptions to Sentry.
class WiseSentryLogger {
  /// Captures an [exception] and reports it to Sentry.
  ///
  /// This automatically includes any globally configured user, tags, or breadcrumbs.
  /// The optional [configureScope] callback can be used to add context specific
  /// to this error event.
  static void capture(
    dynamic exception,
    StackTrace stackTrace, {
    void Function(Scope scope)? configureScope,
  }) {
    Sentry.captureException(
      exception,
      stackTrace: stackTrace,
      withScope: configureScope,
    );
  }
}
