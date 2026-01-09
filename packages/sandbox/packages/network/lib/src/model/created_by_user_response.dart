//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'created_by_user_response.g.dart';

/// CreatedByUserResponse
///
/// Properties:
/// * [uuid]
/// * [name]
@BuiltValue()
abstract class CreatedByUserResponse
    implements Built<CreatedByUserResponse, CreatedByUserResponseBuilder> {
  @BuiltValueField(wireName: r'uuid')
  String get uuid;

  @BuiltValueField(wireName: r'name')
  String get name;

  CreatedByUserResponse._();

  factory CreatedByUserResponse([
    void updates(CreatedByUserResponseBuilder b),
  ]) = _$CreatedByUserResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreatedByUserResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreatedByUserResponse> get serializer =>
      _$CreatedByUserResponseSerializer();
}

class _$CreatedByUserResponseSerializer
    implements PrimitiveSerializer<CreatedByUserResponse> {
  @override
  final Iterable<Type> types = const [
    CreatedByUserResponse,
    _$CreatedByUserResponse,
  ];

  @override
  final String wireName = r'CreatedByUserResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreatedByUserResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'uuid';
    yield serializers.serialize(
      object.uuid,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreatedByUserResponse object, {
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
    required CreatedByUserResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'uuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.uuid = valueDes;
          break;
        case r'name':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.name = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreatedByUserResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreatedByUserResponseBuilder();
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
