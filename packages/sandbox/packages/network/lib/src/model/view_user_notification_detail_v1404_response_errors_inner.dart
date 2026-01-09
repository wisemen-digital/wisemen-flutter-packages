//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/user_notification_not_found_error.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'view_user_notification_detail_v1404_response_errors_inner.g.dart';

/// ViewUserNotificationDetailV1404ResponseErrorsInner
///
/// Properties:
/// * [detail] - a human-readable explanation specific to this occurrence of the problem
/// * [status]
/// * [code]
@BuiltValue()
abstract class ViewUserNotificationDetailV1404ResponseErrorsInner
    implements
        Built<
          ViewUserNotificationDetailV1404ResponseErrorsInner,
          ViewUserNotificationDetailV1404ResponseErrorsInnerBuilder
        > {
  /// Any Of [UserNotificationNotFoundError]
  AnyOf get anyOf;

  ViewUserNotificationDetailV1404ResponseErrorsInner._();

  factory ViewUserNotificationDetailV1404ResponseErrorsInner([
    void updates(ViewUserNotificationDetailV1404ResponseErrorsInnerBuilder b),
  ]) = _$ViewUserNotificationDetailV1404ResponseErrorsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(
    ViewUserNotificationDetailV1404ResponseErrorsInnerBuilder b,
  ) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewUserNotificationDetailV1404ResponseErrorsInner>
  get serializer =>
      _$ViewUserNotificationDetailV1404ResponseErrorsInnerSerializer();
}

class _$ViewUserNotificationDetailV1404ResponseErrorsInnerSerializer
    implements
        PrimitiveSerializer<
          ViewUserNotificationDetailV1404ResponseErrorsInner
        > {
  @override
  final Iterable<Type> types = const [
    ViewUserNotificationDetailV1404ResponseErrorsInner,
    _$ViewUserNotificationDetailV1404ResponseErrorsInner,
  ];

  @override
  final String wireName = r'ViewUserNotificationDetailV1404ResponseErrorsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewUserNotificationDetailV1404ResponseErrorsInner object,
  ) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    ViewUserNotificationDetailV1404ResponseErrorsInner object, {
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
  ViewUserNotificationDetailV1404ResponseErrorsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewUserNotificationDetailV1404ResponseErrorsInnerBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [
      FullType(UserNotificationNotFoundError),
    ]);
    anyOfDataSrc = serialized;
    result.anyOf =
        serializers.deserialize(anyOfDataSrc, specifiedType: targetType)
            as AnyOf;
    return result.build();
  }
}

class ViewUserNotificationDetailV1404ResponseErrorsInnerStatusEnum
    extends EnumClass {
  @BuiltValueEnumConst(wireName: r'404')
  static const ViewUserNotificationDetailV1404ResponseErrorsInnerStatusEnum
  n404 = _$viewUserNotificationDetailV1404ResponseErrorsInnerStatusEnum_n404;

  static Serializer<
    ViewUserNotificationDetailV1404ResponseErrorsInnerStatusEnum
  >
  get serializer =>
      _$viewUserNotificationDetailV1404ResponseErrorsInnerStatusEnumSerializer;

  const ViewUserNotificationDetailV1404ResponseErrorsInnerStatusEnum._(
    String name,
  ) : super(name);

  static BuiltSet<ViewUserNotificationDetailV1404ResponseErrorsInnerStatusEnum>
  get values =>
      _$viewUserNotificationDetailV1404ResponseErrorsInnerStatusEnumValues;
  static ViewUserNotificationDetailV1404ResponseErrorsInnerStatusEnum valueOf(
    String name,
  ) => _$viewUserNotificationDetailV1404ResponseErrorsInnerStatusEnumValueOf(
    name,
  );
}

class ViewUserNotificationDetailV1404ResponseErrorsInnerCodeEnum
    extends EnumClass {
  @BuiltValueEnumConst(wireName: r'user_notification_not_found')
  static const ViewUserNotificationDetailV1404ResponseErrorsInnerCodeEnum
  userNotificationNotFound =
      _$viewUserNotificationDetailV1404ResponseErrorsInnerCodeEnum_userNotificationNotFound;

  static Serializer<ViewUserNotificationDetailV1404ResponseErrorsInnerCodeEnum>
  get serializer =>
      _$viewUserNotificationDetailV1404ResponseErrorsInnerCodeEnumSerializer;

  const ViewUserNotificationDetailV1404ResponseErrorsInnerCodeEnum._(
    String name,
  ) : super(name);

  static BuiltSet<ViewUserNotificationDetailV1404ResponseErrorsInnerCodeEnum>
  get values =>
      _$viewUserNotificationDetailV1404ResponseErrorsInnerCodeEnumValues;
  static ViewUserNotificationDetailV1404ResponseErrorsInnerCodeEnum valueOf(
    String name,
  ) =>
      _$viewUserNotificationDetailV1404ResponseErrorsInnerCodeEnumValueOf(name);
}
