import '../models/wise_exceptions.dart';

/// Utility class for parsing DTOs and wrapping errors with rich context.
///
/// Usage:
///   final model = WiseDTOParser.parse(() => MyModel.fromJson(json), json: json, mapper: 'MyModel.fromJson');
///
/// Wraps all DTO parsing errors as DTOException with rich context (mapper name, json data, error type, offset).
/// The original exception and stack trace are preserved in DTOException.originalError and DTOException.stackTrace.
///
/// App code receives DTOException but can access the underlying exception:
///   try { ... } on DTOException catch (e) {
///     if (e.originalError is FormatException) { ... }
///   }
class WiseDTOParser {
  const WiseDTOParser._();

  static T parse<T>(T Function() parse, {Object? json, String? mapper}) {
    try {
      return parse();
    } catch (e, stack) {
      // Build enriched context
      final extras = <String, dynamic>{
        'errorType': e.runtimeType.toString(),
        'context': 'DTO parsing',
        if (mapper != null) 'mapper': mapper,
        if (json != null) 'json': _truncateJson(json),
      };

      // Extract error-specific data
      if (e is FormatException) {
        if (e.offset != null) extras['offset'] = e.offset;
        if (e.source != null) extras['source'] = e.source.toString();
      }

      // Create wrapped exception with all context and original exception preserved
      final dtoException = DTOException(
        'DTO parsing failed${mapper != null ? ' in $mapper' : ''}: ${e.toString()}',
        originalError: e,
        stackTrace: stack,
        extras: extras,
      );

      // Throw with original stack trace preserved (critical for debugging)
      Error.throwWithStackTrace(dtoException, stack);
    }
  }

  /// Truncates JSON to prevent bloating Sentry events
  static String _truncateJson(Object json, {int maxLength = 1000}) {
    final str = json.toString();
    return str.length > maxLength ? '${str.substring(0, maxLength)}... [TRUNCATED ${str.length} chars]' : str;
  }
}
