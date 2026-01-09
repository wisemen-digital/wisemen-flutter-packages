//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/internal_server_api_error.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'migrate_collections_v1500_response_errors_inner.g.dart';

/// MigrateCollectionsV1500ResponseErrorsInner
///
/// Properties:
/// * [detail] - a human-readable explanation specific to this occurrence of the problem
/// * [status]
/// * [code]
@BuiltValue()
abstract class MigrateCollectionsV1500ResponseErrorsInner
    implements
        Built<
          MigrateCollectionsV1500ResponseErrorsInner,
          MigrateCollectionsV1500ResponseErrorsInnerBuilder
        > {
  /// One Of [InternalServerApiError]
  OneOf get oneOf;

  MigrateCollectionsV1500ResponseErrorsInner._();

  factory MigrateCollectionsV1500ResponseErrorsInner([
    void updates(MigrateCollectionsV1500ResponseErrorsInnerBuilder b),
  ]) = _$MigrateCollectionsV1500ResponseErrorsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MigrateCollectionsV1500ResponseErrorsInnerBuilder b) =>
      b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MigrateCollectionsV1500ResponseErrorsInner>
  get serializer => _$MigrateCollectionsV1500ResponseErrorsInnerSerializer();
}

class _$MigrateCollectionsV1500ResponseErrorsInnerSerializer
    implements PrimitiveSerializer<MigrateCollectionsV1500ResponseErrorsInner> {
  @override
  final Iterable<Type> types = const [
    MigrateCollectionsV1500ResponseErrorsInner,
    _$MigrateCollectionsV1500ResponseErrorsInner,
  ];

  @override
  final String wireName = r'MigrateCollectionsV1500ResponseErrorsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MigrateCollectionsV1500ResponseErrorsInner object,
  ) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    MigrateCollectionsV1500ResponseErrorsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(
      oneOf.value,
      specifiedType: FullType(oneOf.valueType),
    )!;
  }

  @override
  MigrateCollectionsV1500ResponseErrorsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MigrateCollectionsV1500ResponseErrorsInnerBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [
      FullType(InternalServerApiError),
    ]);
    oneOfDataSrc = serialized;
    result.oneOf =
        serializers.deserialize(oneOfDataSrc, specifiedType: targetType)
            as OneOf;
    return result.build();
  }
}

class MigrateCollectionsV1500ResponseErrorsInnerStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'500')
  static const MigrateCollectionsV1500ResponseErrorsInnerStatusEnum n500 =
      _$migrateCollectionsV1500ResponseErrorsInnerStatusEnum_n500;

  static Serializer<MigrateCollectionsV1500ResponseErrorsInnerStatusEnum>
  get serializer =>
      _$migrateCollectionsV1500ResponseErrorsInnerStatusEnumSerializer;

  const MigrateCollectionsV1500ResponseErrorsInnerStatusEnum._(String name)
    : super(name);

  static BuiltSet<MigrateCollectionsV1500ResponseErrorsInnerStatusEnum>
  get values => _$migrateCollectionsV1500ResponseErrorsInnerStatusEnumValues;
  static MigrateCollectionsV1500ResponseErrorsInnerStatusEnum valueOf(
    String name,
  ) => _$migrateCollectionsV1500ResponseErrorsInnerStatusEnumValueOf(name);
}

class MigrateCollectionsV1500ResponseErrorsInnerCodeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'internal_server_error')
  static const MigrateCollectionsV1500ResponseErrorsInnerCodeEnum
  internalServerError =
      _$migrateCollectionsV1500ResponseErrorsInnerCodeEnum_internalServerError;

  static Serializer<MigrateCollectionsV1500ResponseErrorsInnerCodeEnum>
  get serializer =>
      _$migrateCollectionsV1500ResponseErrorsInnerCodeEnumSerializer;

  const MigrateCollectionsV1500ResponseErrorsInnerCodeEnum._(String name)
    : super(name);

  static BuiltSet<MigrateCollectionsV1500ResponseErrorsInnerCodeEnum>
  get values => _$migrateCollectionsV1500ResponseErrorsInnerCodeEnumValues;
  static MigrateCollectionsV1500ResponseErrorsInnerCodeEnum valueOf(
    String name,
  ) => _$migrateCollectionsV1500ResponseErrorsInnerCodeEnumValueOf(name);
}
