/// Utility class for wrapping business logic errors with context for Sentry.
///
/// Usage:
///   final result = WiseBusinessLogicParser.parse(() => myProviderFunction(), context: {...}, location: 'my_provider.dart');
///
/// This ensures that business logic errors (e.g., RangeError, StateError, etc.) are wrapped as BusinessLogicError with context (file, error, extras).
class WiseBusinessLogicParser {
  const WiseBusinessLogicParser._();

  static T parse<T>(T Function() fn, {Object? context, String? location}) {
    try {
      return fn();
    } on BusinessLogicError catch (e) {
      // Already a BusinessLogicError, just rethrow
      rethrow;
    } on Exception catch (e, stack) {
      throw BusinessLogicError(
        'Business logic error: $e',
        originalError: e,
        stackTrace: stack,
        extras: {
          if (context != null) 'context': context,
          if (location != null) 'location': location,
        },
      );
    } on Error catch (e, stack) {
      throw BusinessLogicError(
        'Business logic error: $e',
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
