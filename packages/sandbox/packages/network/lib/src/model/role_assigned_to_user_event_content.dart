//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_assigned_to_user_event_content.g.dart';

/// RoleAssignedToUserEventContent
///
/// Properties:
/// * [userUuid]
/// * [roleUuid]
@BuiltValue()
abstract class RoleAssignedToUserEventContent
    implements
        Built<
          RoleAssignedToUserEventContent,
          RoleAssignedToUserEventContentBuilder
        > {
  @BuiltValueField(wireName: r'userUuid')
  String get userUuid;

  @BuiltValueField(wireName: r'roleUuid')
  String get roleUuid;

  RoleAssignedToUserEventContent._();

  factory RoleAssignedToUserEventContent([
    void updates(RoleAssignedToUserEventContentBuilder b),
  ]) = _$RoleAssignedToUserEventContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RoleAssignedToUserEventContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RoleAssignedToUserEventContent> get serializer =>
      _$RoleAssignedToUserEventContentSerializer();
}

class _$RoleAssignedToUserEventContentSerializer
    implements PrimitiveSerializer<RoleAssignedToUserEventContent> {
  @override
  final Iterable<Type> types = const [
    RoleAssignedToUserEventContent,
    _$RoleAssignedToUserEventContent,
  ];

  @override
  final String wireName = r'RoleAssignedToUserEventContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RoleAssignedToUserEventContent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userUuid';
    yield serializers.serialize(
      object.userUuid,
      specifiedType: const FullType(String),
    );
    yield r'roleUuid';
    yield serializers.serialize(
      object.roleUuid,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RoleAssignedToUserEventContent object, {
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
    required RoleAssignedToUserEventContentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userUuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.userUuid = valueDes;
          break;
        case r'roleUuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.roleUuid = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RoleAssignedToUserEventContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RoleAssignedToUserEventContentBuilder();
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
