//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/file_not_found_error.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'confirm_file_upload_v2404_response_errors_inner.g.dart';

/// ConfirmFileUploadV2404ResponseErrorsInner
///
/// Properties:
/// * [detail] - a human-readable explanation specific to this occurrence of the problem
/// * [status]
/// * [code]
@BuiltValue()
abstract class ConfirmFileUploadV2404ResponseErrorsInner
    implements
        Built<
          ConfirmFileUploadV2404ResponseErrorsInner,
          ConfirmFileUploadV2404ResponseErrorsInnerBuilder
        > {
  /// Any Of [FileNotFoundError]
  AnyOf get anyOf;

  ConfirmFileUploadV2404ResponseErrorsInner._();

  factory ConfirmFileUploadV2404ResponseErrorsInner([
    void updates(ConfirmFileUploadV2404ResponseErrorsInnerBuilder b),
  ]) = _$ConfirmFileUploadV2404ResponseErrorsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConfirmFileUploadV2404ResponseErrorsInnerBuilder b) =>
      b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ConfirmFileUploadV2404ResponseErrorsInner> get serializer =>
      _$ConfirmFileUploadV2404ResponseErrorsInnerSerializer();
}

class _$ConfirmFileUploadV2404ResponseErrorsInnerSerializer
    implements PrimitiveSerializer<ConfirmFileUploadV2404ResponseErrorsInner> {
  @override
  final Iterable<Type> types = const [
    ConfirmFileUploadV2404ResponseErrorsInner,
    _$ConfirmFileUploadV2404ResponseErrorsInner,
  ];

  @override
  final String wireName = r'ConfirmFileUploadV2404ResponseErrorsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ConfirmFileUploadV2404ResponseErrorsInner object,
  ) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    ConfirmFileUploadV2404ResponseErrorsInner object, {
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
  ConfirmFileUploadV2404ResponseErrorsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConfirmFileUploadV2404ResponseErrorsInnerBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(FileNotFoundError)]);
    anyOfDataSrc = serialized;
    result.anyOf =
        serializers.deserialize(anyOfDataSrc, specifiedType: targetType)
            as AnyOf;
    return result.build();
  }
}

class ConfirmFileUploadV2404ResponseErrorsInnerStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'404')
  static const ConfirmFileUploadV2404ResponseErrorsInnerStatusEnum n404 =
      _$confirmFileUploadV2404ResponseErrorsInnerStatusEnum_n404;

  static Serializer<ConfirmFileUploadV2404ResponseErrorsInnerStatusEnum>
  get serializer =>
      _$confirmFileUploadV2404ResponseErrorsInnerStatusEnumSerializer;

  const ConfirmFileUploadV2404ResponseErrorsInnerStatusEnum._(String name)
    : super(name);

  static BuiltSet<ConfirmFileUploadV2404ResponseErrorsInnerStatusEnum>
  get values => _$confirmFileUploadV2404ResponseErrorsInnerStatusEnumValues;
  static ConfirmFileUploadV2404ResponseErrorsInnerStatusEnum valueOf(
    String name,
  ) => _$confirmFileUploadV2404ResponseErrorsInnerStatusEnumValueOf(name);
}

class ConfirmFileUploadV2404ResponseErrorsInnerCodeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'file_not_found')
  static const ConfirmFileUploadV2404ResponseErrorsInnerCodeEnum fileNotFound =
      _$confirmFileUploadV2404ResponseErrorsInnerCodeEnum_fileNotFound;

  static Serializer<ConfirmFileUploadV2404ResponseErrorsInnerCodeEnum>
  get serializer =>
      _$confirmFileUploadV2404ResponseErrorsInnerCodeEnumSerializer;

  const ConfirmFileUploadV2404ResponseErrorsInnerCodeEnum._(String name)
    : super(name);

  static BuiltSet<ConfirmFileUploadV2404ResponseErrorsInnerCodeEnum>
  get values => _$confirmFileUploadV2404ResponseErrorsInnerCodeEnumValues;
  static ConfirmFileUploadV2404ResponseErrorsInnerCodeEnum valueOf(
    String name,
  ) => _$confirmFileUploadV2404ResponseErrorsInnerCodeEnumValueOf(name);
}
