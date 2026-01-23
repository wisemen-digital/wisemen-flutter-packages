/// Utility class for parsing models with mapping logic and wrapping errors as MapperError for Sentry.
///
/// Usage:
///   final model = WiseMapperParser.parse(() => MyModel.fromDetailJson(json), json: json, mapper: 'MyModel.fromDetailJson');
///
/// This ensures that mapping errors are wrapped as MapperError with context (json, mapper, value).
class WiseMapperParser {
  const WiseMapperParser._();

  static T parse<T>(T Function() parse, {Object? json, String? mapper, Object? value}) {
    try {
      return parse();
    } on MapperError catch (e) {
      // Already a MapperError, just rethrow
      rethrow;
    } on Exception catch (e, stack) {
      throw MapperError(
        'Mapper error during model deserialization: $e',
        originalError: e,
        stackTrace: stack,
        extras: {
          if (json != null) 'json': json,
          if (mapper != null) 'mapper': mapper,
          if (value != null) 'value': value,
        },
      );
    } on Error catch (e, stack) {
      throw MapperError(
        'Mapper error during model deserialization: $e',
        originalError: e,
        stackTrace: stack,
        extras: {
          if (json != null) 'json': json,
          if (mapper != null) 'mapper': mapper,
          if (value != null) 'value': value,
        },
      );
    }
  }
}
