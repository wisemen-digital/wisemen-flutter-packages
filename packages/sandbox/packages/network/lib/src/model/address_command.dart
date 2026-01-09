//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/coordinates_command.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'address_command.g.dart';

/// AddressCommand
///
/// Properties:
/// * [placeName]
/// * [placeId]
/// * [country]
/// * [city]
/// * [postalCode]
/// * [streetName]
/// * [streetNumber]
/// * [unit]
/// * [coordinates]
@BuiltValue()
abstract class AddressCommand
    implements Built<AddressCommand, AddressCommandBuilder> {
  @BuiltValueField(wireName: r'placeName')
  String? get placeName;

  @BuiltValueField(wireName: r'placeId')
  String? get placeId;

  @BuiltValueField(wireName: r'country')
  String? get country;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'postalCode')
  String? get postalCode;

  @BuiltValueField(wireName: r'streetName')
  String? get streetName;

  @BuiltValueField(wireName: r'streetNumber')
  String? get streetNumber;

  @BuiltValueField(wireName: r'unit')
  String? get unit;

  @BuiltValueField(wireName: r'coordinates')
  CoordinatesCommand? get coordinates;

  AddressCommand._();

  factory AddressCommand([void updates(AddressCommandBuilder b)]) =
      _$AddressCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AddressCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AddressCommand> get serializer =>
      _$AddressCommandSerializer();
}

class _$AddressCommandSerializer
    implements PrimitiveSerializer<AddressCommand> {
  @override
  final Iterable<Type> types = const [AddressCommand, _$AddressCommand];

  @override
  final String wireName = r'AddressCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AddressCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'placeName';
    yield object.placeName == null
        ? null
        : serializers.serialize(
            object.placeName,
            specifiedType: const FullType.nullable(String),
          );
    yield r'placeId';
    yield object.placeId == null
        ? null
        : serializers.serialize(
            object.placeId,
            specifiedType: const FullType.nullable(String),
          );
    yield r'country';
    yield object.country == null
        ? null
        : serializers.serialize(
            object.country,
            specifiedType: const FullType.nullable(String),
          );
    yield r'city';
    yield object.city == null
        ? null
        : serializers.serialize(
            object.city,
            specifiedType: const FullType.nullable(String),
          );
    yield r'postalCode';
    yield object.postalCode == null
        ? null
        : serializers.serialize(
            object.postalCode,
            specifiedType: const FullType.nullable(String),
          );
    yield r'streetName';
    yield object.streetName == null
        ? null
        : serializers.serialize(
            object.streetName,
            specifiedType: const FullType.nullable(String),
          );
    yield r'streetNumber';
    yield object.streetNumber == null
        ? null
        : serializers.serialize(
            object.streetNumber,
            specifiedType: const FullType.nullable(String),
          );
    yield r'unit';
    yield object.unit == null
        ? null
        : serializers.serialize(
            object.unit,
            specifiedType: const FullType.nullable(String),
          );
    yield r'coordinates';
    yield object.coordinates == null
        ? null
        : serializers.serialize(
            object.coordinates,
            specifiedType: const FullType.nullable(CoordinatesCommand),
          );
  }

  @override
  Object serialize(
    Serializers serializers,
    AddressCommand object, {
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
    required AddressCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'placeName':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.placeName = valueDes;
          break;
        case r'placeId':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.placeId = valueDes;
          break;
        case r'country':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.country = valueDes;
          break;
        case r'city':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.city = valueDes;
          break;
        case r'postalCode':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.postalCode = valueDes;
          break;
        case r'streetName':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.streetName = valueDes;
          break;
        case r'streetNumber':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.streetNumber = valueDes;
          break;
        case r'unit':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.unit = valueDes;
          break;
        case r'coordinates':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(CoordinatesCommand),
                  )
                  as CoordinatesCommand?;
          if (valueDes == null) continue;
          result.coordinates.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AddressCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AddressCommandBuilder();
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
