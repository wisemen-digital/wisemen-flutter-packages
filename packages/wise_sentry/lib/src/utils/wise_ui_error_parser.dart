import '../models/wise_exceptions.dart';

/// Utility class for wrapping UI errors with rich context.
///
/// Usage:
///   final result = WiseUIErrorParser.parse(() => myWidgetBuilder(), context: {...}, location: 'my_widget.dart');
///
/// Wraps all UI errors as UIException with rich context (location, error type, context).
/// The original exception and stack trace are preserved in UIException.originalError and UIException.stackTrace.
///
/// App code receives UIException but can access the underlying exception:
///   try { ... } on UIException catch (e) {
///     if (e.originalError is RenderException) { ... }
///   }
class WiseUIErrorParser {
  const WiseUIErrorParser._();

  static T parse<T>(T Function() fn, {Object? context, String? location}) {
    try {
      return fn();
    } catch (e, stack) {
      // Build enriched context
      final extras = <String, dynamic>{
        'errorType': e.runtimeType.toString(),
        'context_type': 'UI',
        if (location != null) 'location': location,
        if (context != null) 'context': context.toString(),
      };

      // Create wrapped exception with all context and original exception preserved
      final uiException = UIException(
        'UI error${location != null ? ' in $location' : ''}: ${e.toString()}',
        originalError: e,
        stackTrace: stack,
        extras: extras,
      );

      // Throw with original stack trace preserved (critical for debugging)
      Error.throwWithStackTrace(uiException, stack);
    }
  }
}
