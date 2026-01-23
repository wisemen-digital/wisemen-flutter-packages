/// Utility class for parsing DTOs and wrapping errors with context for Sentry.
///
/// Usage:
///   final model = WiseDTOParser.parse(() => MyModel.fromJson(json), json: json, mapper: 'MyModel.fromJson');
///
/// This ensures that FormatException/TypeError are wrapped as DTOError with context.
class WiseDTOParser {
  const WiseDTOParser._();

  static T parse<T>(T Function() parse, {Object? json, String? mapper}) {
    try {
      return parse();
    } on FormatException catch (e, stack) {
      throw DTOError(
        'Format error during DTO deserialization: ${e.message}',
        originalError: e,
        stackTrace: stack,
        extras: {
          if (e.offset != null) 'offset': e.offset,
          if (json != null) 'json': json,
          if (mapper != null) 'mapper': mapper,
        },
      );
    } on TypeError catch (e, stack) {
      throw DTOError(
        'Type error during DTO deserialization: $e',
        originalError: e,
        stackTrace: stack,
        extras: {
          if (json != null) 'json': json,
          if (mapper != null) 'mapper': mapper,
        },
      );
    }
  }
}
