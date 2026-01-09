//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'clear_role_permissions_cache_command.g.dart';

/// ClearRolePermissionsCacheCommand
///
/// Properties:
/// * [roleUuids] - clears the cache for all roles when omitted or null
@BuiltValue()
abstract class ClearRolePermissionsCacheCommand
    implements
        Built<
          ClearRolePermissionsCacheCommand,
          ClearRolePermissionsCacheCommandBuilder
        > {
  /// clears the cache for all roles when omitted or null
  @BuiltValueField(wireName: r'roleUuids')
  BuiltList<String>? get roleUuids;

  ClearRolePermissionsCacheCommand._();

  factory ClearRolePermissionsCacheCommand([
    void updates(ClearRolePermissionsCacheCommandBuilder b),
  ]) = _$ClearRolePermissionsCacheCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ClearRolePermissionsCacheCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ClearRolePermissionsCacheCommand> get serializer =>
      _$ClearRolePermissionsCacheCommandSerializer();
}

class _$ClearRolePermissionsCacheCommandSerializer
    implements PrimitiveSerializer<ClearRolePermissionsCacheCommand> {
  @override
  final Iterable<Type> types = const [
    ClearRolePermissionsCacheCommand,
    _$ClearRolePermissionsCacheCommand,
  ];

  @override
  final String wireName = r'ClearRolePermissionsCacheCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ClearRolePermissionsCacheCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.roleUuids != null) {
      yield r'roleUuids';
      yield serializers.serialize(
        object.roleUuids,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ClearRolePermissionsCacheCommand object, {
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
    required ClearRolePermissionsCacheCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'roleUuids':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(BuiltList, [
                      FullType(String),
                    ]),
                  )
                  as BuiltList<String>?;
          if (valueDes == null) continue;
          result.roleUuids.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ClearRolePermissionsCacheCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ClearRolePermissionsCacheCommandBuilder();
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
