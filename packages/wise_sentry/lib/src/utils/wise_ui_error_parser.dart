/// Utility class for wrapping UI errors with context for Sentry.
///
/// Usage:
///   final result = WiseUIErrorParser.parse(() => myWidgetBuilder(), context: {...}, location: 'my_widget.dart');
///
/// This ensures that UI errors (e.g., null errors, overflow, assertion errors) are wrapped as UIError with context (file, error, extras).
class WiseUIErrorParser {
  const WiseUIErrorParser._();

  static T parse<T>(T Function() fn, {Object? context, String? location}) {
    try {
      return fn();
    } on UIError catch (e) {
      // Already a UIError, just rethrow
      rethrow;
    } on Exception catch (e, stack) {
      throw UIError(
        'UI error: $e',
        originalError: e,
        stackTrace: stack,
        extras: {
          if (context != null) 'context': context,
          if (location != null) 'location': location,
        },
      );
    } on Error catch (e, stack) {
      throw UIError(
        'UI error: $e',
        originalError: e,
        stackTrace: stack,
        extras: {
          if (context != null) 'context': context,
          if (location != null) 'location': location,
        },
      );
    }
  }
}
