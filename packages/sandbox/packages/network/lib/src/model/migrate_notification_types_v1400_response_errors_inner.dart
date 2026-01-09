//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/migration_already_performed_error.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'migrate_notification_types_v1400_response_errors_inner.g.dart';

/// MigrateNotificationTypesV1400ResponseErrorsInner
///
/// Properties:
/// * [detail] - a human-readable explanation specific to this occurrence of the problem
/// * [status]
/// * [code]
/// * [meta] - a meta object containing non-standard meta-information about the error
@BuiltValue()
abstract class MigrateNotificationTypesV1400ResponseErrorsInner
    implements
        Built<
          MigrateNotificationTypesV1400ResponseErrorsInner,
          MigrateNotificationTypesV1400ResponseErrorsInnerBuilder
        > {
  /// Any Of [MigrationAlreadyPerformedError]
  AnyOf get anyOf;

  MigrateNotificationTypesV1400ResponseErrorsInner._();

  factory MigrateNotificationTypesV1400ResponseErrorsInner([
    void updates(MigrateNotificationTypesV1400ResponseErrorsInnerBuilder b),
  ]) = _$MigrateNotificationTypesV1400ResponseErrorsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(
    MigrateNotificationTypesV1400ResponseErrorsInnerBuilder b,
  ) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MigrateNotificationTypesV1400ResponseErrorsInner>
  get serializer =>
      _$MigrateNotificationTypesV1400ResponseErrorsInnerSerializer();
}

class _$MigrateNotificationTypesV1400ResponseErrorsInnerSerializer
    implements
        PrimitiveSerializer<MigrateNotificationTypesV1400ResponseErrorsInner> {
  @override
  final Iterable<Type> types = const [
    MigrateNotificationTypesV1400ResponseErrorsInner,
    _$MigrateNotificationTypesV1400ResponseErrorsInner,
  ];

  @override
  final String wireName = r'MigrateNotificationTypesV1400ResponseErrorsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MigrateNotificationTypesV1400ResponseErrorsInner object,
  ) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    MigrateNotificationTypesV1400ResponseErrorsInner object, {
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
  MigrateNotificationTypesV1400ResponseErrorsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MigrateNotificationTypesV1400ResponseErrorsInnerBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [
      FullType(MigrationAlreadyPerformedError),
    ]);
    anyOfDataSrc = serialized;
    result.anyOf =
        serializers.deserialize(anyOfDataSrc, specifiedType: targetType)
            as AnyOf;
    return result.build();
  }
}

class MigrateNotificationTypesV1400ResponseErrorsInnerStatusEnum
    extends EnumClass {
  @BuiltValueEnumConst(wireName: r'400')
  static const MigrateNotificationTypesV1400ResponseErrorsInnerStatusEnum n400 =
      _$migrateNotificationTypesV1400ResponseErrorsInnerStatusEnum_n400;

  static Serializer<MigrateNotificationTypesV1400ResponseErrorsInnerStatusEnum>
  get serializer =>
      _$migrateNotificationTypesV1400ResponseErrorsInnerStatusEnumSerializer;

  const MigrateNotificationTypesV1400ResponseErrorsInnerStatusEnum._(
    String name,
  ) : super(name);

  static BuiltSet<MigrateNotificationTypesV1400ResponseErrorsInnerStatusEnum>
  get values =>
      _$migrateNotificationTypesV1400ResponseErrorsInnerStatusEnumValues;
  static MigrateNotificationTypesV1400ResponseErrorsInnerStatusEnum valueOf(
    String name,
  ) =>
      _$migrateNotificationTypesV1400ResponseErrorsInnerStatusEnumValueOf(name);
}

class MigrateNotificationTypesV1400ResponseErrorsInnerCodeEnum
    extends EnumClass {
  @BuiltValueEnumConst(wireName: r'migration_already_performed')
  static const MigrateNotificationTypesV1400ResponseErrorsInnerCodeEnum
  migrationAlreadyPerformed =
      _$migrateNotificationTypesV1400ResponseErrorsInnerCodeEnum_migrationAlreadyPerformed;

  static Serializer<MigrateNotificationTypesV1400ResponseErrorsInnerCodeEnum>
  get serializer =>
      _$migrateNotificationTypesV1400ResponseErrorsInnerCodeEnumSerializer;

  const MigrateNotificationTypesV1400ResponseErrorsInnerCodeEnum._(String name)
    : super(name);

  static BuiltSet<MigrateNotificationTypesV1400ResponseErrorsInnerCodeEnum>
  get values =>
      _$migrateNotificationTypesV1400ResponseErrorsInnerCodeEnumValues;
  static MigrateNotificationTypesV1400ResponseErrorsInnerCodeEnum valueOf(
    String name,
  ) => _$migrateNotificationTypesV1400ResponseErrorsInnerCodeEnumValueOf(name);
}
