//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/update_roles_permissions_command_item.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_roles_permissions_command.g.dart';

/// UpdateRolesPermissionsCommand
///
/// Properties:
/// * [roles]
@BuiltValue()
abstract class UpdateRolesPermissionsCommand
    implements
        Built<
          UpdateRolesPermissionsCommand,
          UpdateRolesPermissionsCommandBuilder
        > {
  @BuiltValueField(wireName: r'roles')
  BuiltList<UpdateRolesPermissionsCommandItem> get roles;

  UpdateRolesPermissionsCommand._();

  factory UpdateRolesPermissionsCommand([
    void updates(UpdateRolesPermissionsCommandBuilder b),
  ]) = _$UpdateRolesPermissionsCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateRolesPermissionsCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateRolesPermissionsCommand> get serializer =>
      _$UpdateRolesPermissionsCommandSerializer();
}

class _$UpdateRolesPermissionsCommandSerializer
    implements PrimitiveSerializer<UpdateRolesPermissionsCommand> {
  @override
  final Iterable<Type> types = const [
    UpdateRolesPermissionsCommand,
    _$UpdateRolesPermissionsCommand,
  ];

  @override
  final String wireName = r'UpdateRolesPermissionsCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateRolesPermissionsCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'roles';
    yield serializers.serialize(
      object.roles,
      specifiedType: const FullType(BuiltList, [
        FullType(UpdateRolesPermissionsCommandItem),
      ]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateRolesPermissionsCommand object, {
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
    required UpdateRolesPermissionsCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'roles':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(UpdateRolesPermissionsCommandItem),
                    ]),
                  )
                  as BuiltList<UpdateRolesPermissionsCommandItem>;
          result.roles.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateRolesPermissionsCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateRolesPermissionsCommandBuilder();
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
