//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/permission.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_permissions_updated_event_content.g.dart';

/// RolePermissionsUpdatedEventContent
///
/// Properties:
/// * [roleUuid]
/// * [newPermissions]
/// * [roleName]
@BuiltValue()
abstract class RolePermissionsUpdatedEventContent
    implements
        Built<
          RolePermissionsUpdatedEventContent,
          RolePermissionsUpdatedEventContentBuilder
        > {
  @BuiltValueField(wireName: r'roleUuid')
  String get roleUuid;

  @BuiltValueField(wireName: r'newPermissions')
  BuiltList<Permission> get newPermissions;

  @BuiltValueField(wireName: r'roleName')
  String get roleName;

  RolePermissionsUpdatedEventContent._();

  factory RolePermissionsUpdatedEventContent([
    void updates(RolePermissionsUpdatedEventContentBuilder b),
  ]) = _$RolePermissionsUpdatedEventContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RolePermissionsUpdatedEventContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RolePermissionsUpdatedEventContent> get serializer =>
      _$RolePermissionsUpdatedEventContentSerializer();
}

class _$RolePermissionsUpdatedEventContentSerializer
    implements PrimitiveSerializer<RolePermissionsUpdatedEventContent> {
  @override
  final Iterable<Type> types = const [
    RolePermissionsUpdatedEventContent,
    _$RolePermissionsUpdatedEventContent,
  ];

  @override
  final String wireName = r'RolePermissionsUpdatedEventContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RolePermissionsUpdatedEventContent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'roleUuid';
    yield serializers.serialize(
      object.roleUuid,
      specifiedType: const FullType(String),
    );
    yield r'newPermissions';
    yield serializers.serialize(
      object.newPermissions,
      specifiedType: const FullType(BuiltList, [FullType(Permission)]),
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
    RolePermissionsUpdatedEventContent object, {
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
    required RolePermissionsUpdatedEventContentBuilder result,
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
        case r'newPermissions':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(Permission),
                    ]),
                  )
                  as BuiltList<Permission>;
          result.newPermissions.replace(valueDes);
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
  RolePermissionsUpdatedEventContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RolePermissionsUpdatedEventContentBuilder();
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
