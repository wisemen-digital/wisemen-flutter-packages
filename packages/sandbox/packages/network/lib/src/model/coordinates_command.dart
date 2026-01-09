//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'coordinates_command.g.dart';

/// CoordinatesCommand
///
/// Properties:
/// * [longitude]
/// * [latitude]
@BuiltValue()
abstract class CoordinatesCommand
    implements Built<CoordinatesCommand, CoordinatesCommandBuilder> {
  @BuiltValueField(wireName: r'longitude')
  num get longitude;

  @BuiltValueField(wireName: r'latitude')
  num get latitude;

  CoordinatesCommand._();

  factory CoordinatesCommand([void updates(CoordinatesCommandBuilder b)]) =
      _$CoordinatesCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CoordinatesCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CoordinatesCommand> get serializer =>
      _$CoordinatesCommandSerializer();
}

class _$CoordinatesCommandSerializer
    implements PrimitiveSerializer<CoordinatesCommand> {
  @override
  final Iterable<Type> types = const [CoordinatesCommand, _$CoordinatesCommand];

  @override
  final String wireName = r'CoordinatesCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CoordinatesCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'longitude';
    yield serializers.serialize(
      object.longitude,
      specifiedType: const FullType(num),
    );
    yield r'latitude';
    yield serializers.serialize(
      object.latitude,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CoordinatesCommand object, {
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
    required CoordinatesCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'longitude':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(num))
                  as num;
          result.longitude = valueDes;
          break;
        case r'latitude':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(num))
                  as num;
          result.latitude = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CoordinatesCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CoordinatesCommandBuilder();
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
