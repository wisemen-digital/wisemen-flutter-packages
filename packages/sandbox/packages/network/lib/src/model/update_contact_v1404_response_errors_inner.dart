//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/contact_not_found_error.dart';
import 'package:openapi/src/model/file_not_found_error.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'update_contact_v1404_response_errors_inner.g.dart';

/// UpdateContactV1404ResponseErrorsInner
///
/// Properties:
/// * [detail] - a human-readable explanation specific to this occurrence of the problem
/// * [status]
/// * [code]
@BuiltValue()
abstract class UpdateContactV1404ResponseErrorsInner
    implements
        Built<
          UpdateContactV1404ResponseErrorsInner,
          UpdateContactV1404ResponseErrorsInnerBuilder
        > {
  /// Any Of [ContactNotFoundError], [FileNotFoundError]
  AnyOf get anyOf;

  UpdateContactV1404ResponseErrorsInner._();

  factory UpdateContactV1404ResponseErrorsInner([
    void updates(UpdateContactV1404ResponseErrorsInnerBuilder b),
  ]) = _$UpdateContactV1404ResponseErrorsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateContactV1404ResponseErrorsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateContactV1404ResponseErrorsInner> get serializer =>
      _$UpdateContactV1404ResponseErrorsInnerSerializer();
}

class _$UpdateContactV1404ResponseErrorsInnerSerializer
    implements PrimitiveSerializer<UpdateContactV1404ResponseErrorsInner> {
  @override
  final Iterable<Type> types = const [
    UpdateContactV1404ResponseErrorsInner,
    _$UpdateContactV1404ResponseErrorsInner,
  ];

  @override
  final String wireName = r'UpdateContactV1404ResponseErrorsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateContactV1404ResponseErrorsInner object,
  ) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    UpdateContactV1404ResponseErrorsInner object, {
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
  UpdateContactV1404ResponseErrorsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateContactV1404ResponseErrorsInnerBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [
      FullType(ContactNotFoundError),
      FullType(FileNotFoundError),
    ]);
    anyOfDataSrc = serialized;
    result.anyOf =
        serializers.deserialize(anyOfDataSrc, specifiedType: targetType)
            as AnyOf;
    return result.build();
  }
}

class UpdateContactV1404ResponseErrorsInnerStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'404')
  static const UpdateContactV1404ResponseErrorsInnerStatusEnum n404 =
      _$updateContactV1404ResponseErrorsInnerStatusEnum_n404;

  static Serializer<UpdateContactV1404ResponseErrorsInnerStatusEnum>
  get serializer => _$updateContactV1404ResponseErrorsInnerStatusEnumSerializer;

  const UpdateContactV1404ResponseErrorsInnerStatusEnum._(String name)
    : super(name);

  static BuiltSet<UpdateContactV1404ResponseErrorsInnerStatusEnum> get values =>
      _$updateContactV1404ResponseErrorsInnerStatusEnumValues;
  static UpdateContactV1404ResponseErrorsInnerStatusEnum valueOf(String name) =>
      _$updateContactV1404ResponseErrorsInnerStatusEnumValueOf(name);
}

class UpdateContactV1404ResponseErrorsInnerCodeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'file_not_found')
  static const UpdateContactV1404ResponseErrorsInnerCodeEnum fileNotFound =
      _$updateContactV1404ResponseErrorsInnerCodeEnum_fileNotFound;

  static Serializer<UpdateContactV1404ResponseErrorsInnerCodeEnum>
  get serializer => _$updateContactV1404ResponseErrorsInnerCodeEnumSerializer;

  const UpdateContactV1404ResponseErrorsInnerCodeEnum._(String name)
    : super(name);

  static BuiltSet<UpdateContactV1404ResponseErrorsInnerCodeEnum> get values =>
      _$updateContactV1404ResponseErrorsInnerCodeEnumValues;
  static UpdateContactV1404ResponseErrorsInnerCodeEnum valueOf(String name) =>
      _$updateContactV1404ResponseErrorsInnerCodeEnumValueOf(name);
}
