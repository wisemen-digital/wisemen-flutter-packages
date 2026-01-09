//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/job_not_found_error.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'view_job_detail_v1404_response_errors_inner.g.dart';

/// ViewJobDetailV1404ResponseErrorsInner
///
/// Properties:
/// * [detail] - a human-readable explanation specific to this occurrence of the problem
/// * [status]
/// * [code]
@BuiltValue()
abstract class ViewJobDetailV1404ResponseErrorsInner
    implements
        Built<
          ViewJobDetailV1404ResponseErrorsInner,
          ViewJobDetailV1404ResponseErrorsInnerBuilder
        > {
  /// Any Of [JobNotFoundError]
  AnyOf get anyOf;

  ViewJobDetailV1404ResponseErrorsInner._();

  factory ViewJobDetailV1404ResponseErrorsInner([
    void updates(ViewJobDetailV1404ResponseErrorsInnerBuilder b),
  ]) = _$ViewJobDetailV1404ResponseErrorsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewJobDetailV1404ResponseErrorsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewJobDetailV1404ResponseErrorsInner> get serializer =>
      _$ViewJobDetailV1404ResponseErrorsInnerSerializer();
}

class _$ViewJobDetailV1404ResponseErrorsInnerSerializer
    implements PrimitiveSerializer<ViewJobDetailV1404ResponseErrorsInner> {
  @override
  final Iterable<Type> types = const [
    ViewJobDetailV1404ResponseErrorsInner,
    _$ViewJobDetailV1404ResponseErrorsInner,
  ];

  @override
  final String wireName = r'ViewJobDetailV1404ResponseErrorsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewJobDetailV1404ResponseErrorsInner object,
  ) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    ViewJobDetailV1404ResponseErrorsInner object, {
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
  ViewJobDetailV1404ResponseErrorsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewJobDetailV1404ResponseErrorsInnerBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(JobNotFoundError)]);
    anyOfDataSrc = serialized;
    result.anyOf =
        serializers.deserialize(anyOfDataSrc, specifiedType: targetType)
            as AnyOf;
    return result.build();
  }
}

class ViewJobDetailV1404ResponseErrorsInnerStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'404')
  static const ViewJobDetailV1404ResponseErrorsInnerStatusEnum n404 =
      _$viewJobDetailV1404ResponseErrorsInnerStatusEnum_n404;

  static Serializer<ViewJobDetailV1404ResponseErrorsInnerStatusEnum>
  get serializer => _$viewJobDetailV1404ResponseErrorsInnerStatusEnumSerializer;

  const ViewJobDetailV1404ResponseErrorsInnerStatusEnum._(String name)
    : super(name);

  static BuiltSet<ViewJobDetailV1404ResponseErrorsInnerStatusEnum> get values =>
      _$viewJobDetailV1404ResponseErrorsInnerStatusEnumValues;
  static ViewJobDetailV1404ResponseErrorsInnerStatusEnum valueOf(String name) =>
      _$viewJobDetailV1404ResponseErrorsInnerStatusEnumValueOf(name);
}

class ViewJobDetailV1404ResponseErrorsInnerCodeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'job_not_found')
  static const ViewJobDetailV1404ResponseErrorsInnerCodeEnum jobNotFound =
      _$viewJobDetailV1404ResponseErrorsInnerCodeEnum_jobNotFound;

  static Serializer<ViewJobDetailV1404ResponseErrorsInnerCodeEnum>
  get serializer => _$viewJobDetailV1404ResponseErrorsInnerCodeEnumSerializer;

  const ViewJobDetailV1404ResponseErrorsInnerCodeEnum._(String name)
    : super(name);

  static BuiltSet<ViewJobDetailV1404ResponseErrorsInnerCodeEnum> get values =>
      _$viewJobDetailV1404ResponseErrorsInnerCodeEnumValues;
  static ViewJobDetailV1404ResponseErrorsInnerCodeEnum valueOf(String name) =>
      _$viewJobDetailV1404ResponseErrorsInnerCodeEnumValueOf(name);
}
