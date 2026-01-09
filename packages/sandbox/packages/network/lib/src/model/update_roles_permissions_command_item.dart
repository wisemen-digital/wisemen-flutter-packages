//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/permission.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_roles_permissions_command_item.g.dart';

/// UpdateRolesPermissionsCommandItem
///
/// Properties:
/// * [roleUuid]
/// * [permissions]
@BuiltValue()
abstract class UpdateRolesPermissionsCommandItem
    implements
        Built<
          UpdateRolesPermissionsCommandItem,
          UpdateRolesPermissionsCommandItemBuilder
        > {
  @BuiltValueField(wireName: r'roleUuid')
  String get roleUuid;

  @BuiltValueField(wireName: r'permissions')
  BuiltList<Permission> get permissions;

  UpdateRolesPermissionsCommandItem._();

  factory UpdateRolesPermissionsCommandItem([
    void updates(UpdateRolesPermissionsCommandItemBuilder b),
  ]) = _$UpdateRolesPermissionsCommandItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateRolesPermissionsCommandItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateRolesPermissionsCommandItem> get serializer =>
      _$UpdateRolesPermissionsCommandItemSerializer();
}

class _$UpdateRolesPermissionsCommandItemSerializer
    implements PrimitiveSerializer<UpdateRolesPermissionsCommandItem> {
  @override
  final Iterable<Type> types = const [
    UpdateRolesPermissionsCommandItem,
    _$UpdateRolesPermissionsCommandItem,
  ];

  @override
  final String wireName = r'UpdateRolesPermissionsCommandItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateRolesPermissionsCommandItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'roleUuid';
    yield serializers.serialize(
      object.roleUuid,
      specifiedType: const FullType(String),
    );
    yield r'permissions';
    yield serializers.serialize(
      object.permissions,
      specifiedType: const FullType(BuiltList, [FullType(Permission)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateRolesPermissionsCommandItem object, {
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
    required UpdateRolesPermissionsCommandItemBuilder result,
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
        case r'permissions':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(Permission),
                    ]),
                  )
                  as BuiltList<Permission>;
          result.permissions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateRolesPermissionsCommandItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateRolesPermissionsCommandItemBuilder();
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
