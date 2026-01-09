//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/contact_not_found_error.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'delete_contact_v1404_response_errors_inner.g.dart';

/// DeleteContactV1404ResponseErrorsInner
///
/// Properties:
/// * [detail] - a human-readable explanation specific to this occurrence of the problem
/// * [status]
/// * [code]
@BuiltValue()
abstract class DeleteContactV1404ResponseErrorsInner
    implements
        Built<
          DeleteContactV1404ResponseErrorsInner,
          DeleteContactV1404ResponseErrorsInnerBuilder
        > {
  /// Any Of [ContactNotFoundError]
  AnyOf get anyOf;

  DeleteContactV1404ResponseErrorsInner._();

  factory DeleteContactV1404ResponseErrorsInner([
    void updates(DeleteContactV1404ResponseErrorsInnerBuilder b),
  ]) = _$DeleteContactV1404ResponseErrorsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteContactV1404ResponseErrorsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteContactV1404ResponseErrorsInner> get serializer =>
      _$DeleteContactV1404ResponseErrorsInnerSerializer();
}

class _$DeleteContactV1404ResponseErrorsInnerSerializer
    implements PrimitiveSerializer<DeleteContactV1404ResponseErrorsInner> {
  @override
  final Iterable<Type> types = const [
    DeleteContactV1404ResponseErrorsInner,
    _$DeleteContactV1404ResponseErrorsInner,
  ];

  @override
  final String wireName = r'DeleteContactV1404ResponseErrorsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteContactV1404ResponseErrorsInner object,
  ) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    DeleteContactV1404ResponseErrorsInner object, {
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
  DeleteContactV1404ResponseErrorsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteContactV1404ResponseErrorsInnerBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(ContactNotFoundError)]);
    anyOfDataSrc = serialized;
    result.anyOf =
        serializers.deserialize(anyOfDataSrc, specifiedType: targetType)
            as AnyOf;
    return result.build();
  }
}

class DeleteContactV1404ResponseErrorsInnerStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'404')
  static const DeleteContactV1404ResponseErrorsInnerStatusEnum n404 =
      _$deleteContactV1404ResponseErrorsInnerStatusEnum_n404;

  static Serializer<DeleteContactV1404ResponseErrorsInnerStatusEnum>
  get serializer => _$deleteContactV1404ResponseErrorsInnerStatusEnumSerializer;

  const DeleteContactV1404ResponseErrorsInnerStatusEnum._(String name)
    : super(name);

  static BuiltSet<DeleteContactV1404ResponseErrorsInnerStatusEnum> get values =>
      _$deleteContactV1404ResponseErrorsInnerStatusEnumValues;
  static DeleteContactV1404ResponseErrorsInnerStatusEnum valueOf(String name) =>
      _$deleteContactV1404ResponseErrorsInnerStatusEnumValueOf(name);
}

class DeleteContactV1404ResponseErrorsInnerCodeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'contact_not_found')
  static const DeleteContactV1404ResponseErrorsInnerCodeEnum contactNotFound =
      _$deleteContactV1404ResponseErrorsInnerCodeEnum_contactNotFound;

  static Serializer<DeleteContactV1404ResponseErrorsInnerCodeEnum>
  get serializer => _$deleteContactV1404ResponseErrorsInnerCodeEnumSerializer;

  const DeleteContactV1404ResponseErrorsInnerCodeEnum._(String name)
    : super(name);

  static BuiltSet<DeleteContactV1404ResponseErrorsInnerCodeEnum> get values =>
      _$deleteContactV1404ResponseErrorsInnerCodeEnumValues;
  static DeleteContactV1404ResponseErrorsInnerCodeEnum valueOf(String name) =>
      _$deleteContactV1404ResponseErrorsInnerCodeEnumValueOf(name);
}
