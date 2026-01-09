//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'translations.g.dart';

/// Translations
///
/// Properties:
/// * [nl]
/// * [en]
@BuiltValue()
abstract class Translations
    implements Built<Translations, TranslationsBuilder> {
  @BuiltValueField(wireName: r'nl')
  String? get nl;

  @BuiltValueField(wireName: r'en')
  String? get en;

  Translations._();

  factory Translations([void updates(TranslationsBuilder b)]) = _$Translations;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TranslationsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Translations> get serializer => _$TranslationsSerializer();
}

class _$TranslationsSerializer implements PrimitiveSerializer<Translations> {
  @override
  final Iterable<Type> types = const [Translations, _$Translations];

  @override
  final String wireName = r'Translations';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Translations object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.nl != null) {
      yield r'nl';
      yield serializers.serialize(
        object.nl,
        specifiedType: const FullType(String),
      );
    }
    if (object.en != null) {
      yield r'en';
      yield serializers.serialize(
        object.en,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Translations object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(
      serializers,
      object,
      specifiedType: specifiedType,
    ).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TranslationsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'nl':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.nl = valueDes;
          break;
        case r'en':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.en = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Translations deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TranslationsBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
