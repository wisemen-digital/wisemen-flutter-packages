import '../models/wise_exceptions.dart';

/// Utility class for wrapping mapping errors with rich context.
///
/// Usage:
///   final model = WiseMapperParser.parse(() => MyModel.fromDetailJson(json), json: json, mapper: 'MyModel.fromDetailJson');
///
/// Wraps all mapping errors as MapperException with rich context (mapper name, json data, error type).
/// The original exception and stack trace are preserved in MapperException.originalError and MapperException.stackTrace.
///
/// App code receives MapperException but can access the underlying exception:
///   try { ... } on MapperException catch (e) {
///     if (e.originalError is StateError) { ... }
///   }
class WiseMapperParser {
  const WiseMapperParser._();

  static T parse<T>(T Function() parse, {Object? json, String? mapper, Object? value}) {
    try {
      return parse();
    } catch (e, stack) {
      // Build enriched context
      final extras = <String, dynamic>{
        'errorType': e.runtimeType.toString(),
        'context': 'Mapper',
        if (mapper != null) 'mapper': mapper,
        if (json != null) 'json': _truncateJson(json),
        if (value != null) 'value': value.toString(),
      };

      // Create wrapped exception with all context and original exception preserved
      final mapperException = MapperException(
        'Mapper error${mapper != null ? ' in $mapper' : ''}: ${e.toString()}',
        originalError: e,
        stackTrace: stack,
        extras: extras,
      );

      // Throw with original stack trace preserved (critical for debugging)
      Error.throwWithStackTrace(mapperException, stack);
    }
  }

  /// Truncates JSON to prevent bloating Sentry events
  static String _truncateJson(Object json, {int maxLength = 1000}) {
    final str = json.toString();
    return str.length > maxLength ? '${str.substring(0, maxLength)}... [TRUNCATED ${str.length} chars]' : str;
  }
}
