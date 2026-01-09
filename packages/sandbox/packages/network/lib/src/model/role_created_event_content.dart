//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_created_event_content.g.dart';

/// RoleCreatedEventContent
///
/// Properties:
/// * [roleUuid]
/// * [roleName]
@BuiltValue()
abstract class RoleCreatedEventContent
    implements Built<RoleCreatedEventContent, RoleCreatedEventContentBuilder> {
  @BuiltValueField(wireName: r'roleUuid')
  String get roleUuid;

  @BuiltValueField(wireName: r'roleName')
  String get roleName;

  RoleCreatedEventContent._();

  factory RoleCreatedEventContent([
    void updates(RoleCreatedEventContentBuilder b),
  ]) = _$RoleCreatedEventContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RoleCreatedEventContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RoleCreatedEventContent> get serializer =>
      _$RoleCreatedEventContentSerializer();
}

class _$RoleCreatedEventContentSerializer
    implements PrimitiveSerializer<RoleCreatedEventContent> {
  @override
  final Iterable<Type> types = const [
    RoleCreatedEventContent,
    _$RoleCreatedEventContent,
  ];

  @override
  final String wireName = r'RoleCreatedEventContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RoleCreatedEventContent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'roleUuid';
    yield serializers.serialize(
      object.roleUuid,
      specifiedType: const FullType(String),
    );
    yield r'roleName';
    yield serializers.serialize(
      object.roleName,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RoleCreatedEventContent object, {
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
    required RoleCreatedEventContentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'roleUuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.roleUuid = valueDes;
          break;
        case r'roleName':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.roleName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RoleCreatedEventContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RoleCreatedEventContentBuilder();
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
