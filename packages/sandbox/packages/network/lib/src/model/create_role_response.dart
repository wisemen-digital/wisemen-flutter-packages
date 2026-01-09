//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_role_response.g.dart';

/// CreateRoleResponse
///
/// Properties:
/// * [uuid]
@BuiltValue()
abstract class CreateRoleResponse
    implements Built<CreateRoleResponse, CreateRoleResponseBuilder> {
  @BuiltValueField(wireName: r'uuid')
  String get uuid;

  CreateRoleResponse._();

  factory CreateRoleResponse([void updates(CreateRoleResponseBuilder b)]) =
      _$CreateRoleResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateRoleResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateRoleResponse> get serializer =>
      _$CreateRoleResponseSerializer();
}

class _$CreateRoleResponseSerializer
    implements PrimitiveSerializer<CreateRoleResponse> {
  @override
  final Iterable<Type> types = const [CreateRoleResponse, _$CreateRoleResponse];

  @override
  final String wireName = r'CreateRoleResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateRoleResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'uuid';
    yield serializers.serialize(
      object.uuid,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateRoleResponse object, {
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
    required CreateRoleResponseBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateRoleResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateRoleResponseBuilder();
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
