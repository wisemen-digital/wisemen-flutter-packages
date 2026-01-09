//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'coordinates_response.g.dart';

/// CoordinatesResponse
///
/// Properties:
/// * [longitude]
/// * [latitude]
@BuiltValue()
abstract class CoordinatesResponse
    implements Built<CoordinatesResponse, CoordinatesResponseBuilder> {
  @BuiltValueField(wireName: r'longitude')
  num get longitude;

  @BuiltValueField(wireName: r'latitude')
  num get latitude;

  CoordinatesResponse._();

  factory CoordinatesResponse([void updates(CoordinatesResponseBuilder b)]) =
      _$CoordinatesResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CoordinatesResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CoordinatesResponse> get serializer =>
      _$CoordinatesResponseSerializer();
}

class _$CoordinatesResponseSerializer
    implements PrimitiveSerializer<CoordinatesResponse> {
  @override
  final Iterable<Type> types = const [
    CoordinatesResponse,
    _$CoordinatesResponse,
  ];

  @override
  final String wireName = r'CoordinatesResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CoordinatesResponse object, {
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
    CoordinatesResponse object, {
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
    required CoordinatesResponseBuilder result,
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
  CoordinatesResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CoordinatesResponseBuilder();
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
