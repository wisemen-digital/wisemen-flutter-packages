//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/user_not_found_error.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'set_user_roles_v1404_response_errors_inner.g.dart';

/// SetUserRolesV1404ResponseErrorsInner
///
/// Properties:
/// * [detail] - a human-readable explanation specific to this occurrence of the problem
/// * [status]
/// * [code]
@BuiltValue()
abstract class SetUserRolesV1404ResponseErrorsInner
    implements
        Built<
          SetUserRolesV1404ResponseErrorsInner,
          SetUserRolesV1404ResponseErrorsInnerBuilder
        > {
  /// Any Of [UserNotFoundError]
  AnyOf get anyOf;

  SetUserRolesV1404ResponseErrorsInner._();

  factory SetUserRolesV1404ResponseErrorsInner([
    void updates(SetUserRolesV1404ResponseErrorsInnerBuilder b),
  ]) = _$SetUserRolesV1404ResponseErrorsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SetUserRolesV1404ResponseErrorsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SetUserRolesV1404ResponseErrorsInner> get serializer =>
      _$SetUserRolesV1404ResponseErrorsInnerSerializer();
}

class _$SetUserRolesV1404ResponseErrorsInnerSerializer
    implements PrimitiveSerializer<SetUserRolesV1404ResponseErrorsInner> {
  @override
  final Iterable<Type> types = const [
    SetUserRolesV1404ResponseErrorsInner,
    _$SetUserRolesV1404ResponseErrorsInner,
  ];

  @override
  final String wireName = r'SetUserRolesV1404ResponseErrorsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SetUserRolesV1404ResponseErrorsInner object,
  ) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    SetUserRolesV1404ResponseErrorsInner object, {
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
  SetUserRolesV1404ResponseErrorsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SetUserRolesV1404ResponseErrorsInnerBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(UserNotFoundError)]);
    anyOfDataSrc = serialized;
    result.anyOf =
        serializers.deserialize(anyOfDataSrc, specifiedType: targetType)
            as AnyOf;
    return result.build();
  }
}

class SetUserRolesV1404ResponseErrorsInnerStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'404')
  static const SetUserRolesV1404ResponseErrorsInnerStatusEnum n404 =
      _$setUserRolesV1404ResponseErrorsInnerStatusEnum_n404;

  static Serializer<SetUserRolesV1404ResponseErrorsInnerStatusEnum>
  get serializer => _$setUserRolesV1404ResponseErrorsInnerStatusEnumSerializer;

  const SetUserRolesV1404ResponseErrorsInnerStatusEnum._(String name)
    : super(name);

  static BuiltSet<SetUserRolesV1404ResponseErrorsInnerStatusEnum> get values =>
      _$setUserRolesV1404ResponseErrorsInnerStatusEnumValues;
  static SetUserRolesV1404ResponseErrorsInnerStatusEnum valueOf(String name) =>
      _$setUserRolesV1404ResponseErrorsInnerStatusEnumValueOf(name);
}

class SetUserRolesV1404ResponseErrorsInnerCodeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'user_not_found')
  static const SetUserRolesV1404ResponseErrorsInnerCodeEnum userNotFound =
      _$setUserRolesV1404ResponseErrorsInnerCodeEnum_userNotFound;

  static Serializer<SetUserRolesV1404ResponseErrorsInnerCodeEnum>
  get serializer => _$setUserRolesV1404ResponseErrorsInnerCodeEnumSerializer;

  const SetUserRolesV1404ResponseErrorsInnerCodeEnum._(String name)
    : super(name);

  static BuiltSet<SetUserRolesV1404ResponseErrorsInnerCodeEnum> get values =>
      _$setUserRolesV1404ResponseErrorsInnerCodeEnumValues;
  static SetUserRolesV1404ResponseErrorsInnerCodeEnum valueOf(String name) =>
      _$setUserRolesV1404ResponseErrorsInnerCodeEnumValueOf(name);
}
