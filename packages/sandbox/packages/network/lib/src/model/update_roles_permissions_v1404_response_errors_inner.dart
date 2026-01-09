//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/role_not_found_error.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'update_roles_permissions_v1404_response_errors_inner.g.dart';

/// UpdateRolesPermissionsV1404ResponseErrorsInner
///
/// Properties:
/// * [detail] - a human-readable explanation specific to this occurrence of the problem
/// * [status]
/// * [code]
@BuiltValue()
abstract class UpdateRolesPermissionsV1404ResponseErrorsInner
    implements
        Built<
          UpdateRolesPermissionsV1404ResponseErrorsInner,
          UpdateRolesPermissionsV1404ResponseErrorsInnerBuilder
        > {
  /// Any Of [RoleNotFoundError]
  AnyOf get anyOf;

  UpdateRolesPermissionsV1404ResponseErrorsInner._();

  factory UpdateRolesPermissionsV1404ResponseErrorsInner([
    void updates(UpdateRolesPermissionsV1404ResponseErrorsInnerBuilder b),
  ]) = _$UpdateRolesPermissionsV1404ResponseErrorsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(
    UpdateRolesPermissionsV1404ResponseErrorsInnerBuilder b,
  ) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateRolesPermissionsV1404ResponseErrorsInner>
  get serializer =>
      _$UpdateRolesPermissionsV1404ResponseErrorsInnerSerializer();
}

class _$UpdateRolesPermissionsV1404ResponseErrorsInnerSerializer
    implements
        PrimitiveSerializer<UpdateRolesPermissionsV1404ResponseErrorsInner> {
  @override
  final Iterable<Type> types = const [
    UpdateRolesPermissionsV1404ResponseErrorsInner,
    _$UpdateRolesPermissionsV1404ResponseErrorsInner,
  ];

  @override
  final String wireName = r'UpdateRolesPermissionsV1404ResponseErrorsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateRolesPermissionsV1404ResponseErrorsInner object,
  ) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    UpdateRolesPermissionsV1404ResponseErrorsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(
      anyOf,
      specifiedType: FullType(
        AnyOf,
        anyOf.valueTypes.map((type) => FullType(type)).toList(),
      ),
    )!;
  }

  @override
  UpdateRolesPermissionsV1404ResponseErrorsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateRolesPermissionsV1404ResponseErrorsInnerBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(RoleNotFoundError)]);
    anyOfDataSrc = serialized;
    result.anyOf =
        serializers.deserialize(anyOfDataSrc, specifiedType: targetType)
            as AnyOf;
    return result.build();
  }
}

class UpdateRolesPermissionsV1404ResponseErrorsInnerStatusEnum
    extends EnumClass {
  @BuiltValueEnumConst(wireName: r'404')
  static const UpdateRolesPermissionsV1404ResponseErrorsInnerStatusEnum n404 =
      _$updateRolesPermissionsV1404ResponseErrorsInnerStatusEnum_n404;

  static Serializer<UpdateRolesPermissionsV1404ResponseErrorsInnerStatusEnum>
  get serializer =>
      _$updateRolesPermissionsV1404ResponseErrorsInnerStatusEnumSerializer;

  const UpdateRolesPermissionsV1404ResponseErrorsInnerStatusEnum._(String name)
    : super(name);

  static BuiltSet<UpdateRolesPermissionsV1404ResponseErrorsInnerStatusEnum>
  get values =>
      _$updateRolesPermissionsV1404ResponseErrorsInnerStatusEnumValues;
  static UpdateRolesPermissionsV1404ResponseErrorsInnerStatusEnum valueOf(
    String name,
  ) => _$updateRolesPermissionsV1404ResponseErrorsInnerStatusEnumValueOf(name);
}

class UpdateRolesPermissionsV1404ResponseErrorsInnerCodeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'role_not_found')
  static const UpdateRolesPermissionsV1404ResponseErrorsInnerCodeEnum
  roleNotFound =
      _$updateRolesPermissionsV1404ResponseErrorsInnerCodeEnum_roleNotFound;

  static Serializer<UpdateRolesPermissionsV1404ResponseErrorsInnerCodeEnum>
  get serializer =>
      _$updateRolesPermissionsV1404ResponseErrorsInnerCodeEnumSerializer;

  const UpdateRolesPermissionsV1404ResponseErrorsInnerCodeEnum._(String name)
    : super(name);

  static BuiltSet<UpdateRolesPermissionsV1404ResponseErrorsInnerCodeEnum>
  get values => _$updateRolesPermissionsV1404ResponseErrorsInnerCodeEnumValues;
  static UpdateRolesPermissionsV1404ResponseErrorsInnerCodeEnum valueOf(
    String name,
  ) => _$updateRolesPermissionsV1404ResponseErrorsInnerCodeEnumValueOf(name);
}
