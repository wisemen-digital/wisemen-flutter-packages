//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/system_test_notification_notification.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'get_my_notifications_response_items_inner.g.dart';

/// GetMyNotificationsResponseItemsInner
///
/// Properties:
/// * [createdAt]
/// * [readAt]
/// * [notificationUuid]
/// * [createdByUser]
/// * [message]
/// * [type]
/// * [meta]
@BuiltValue()
abstract class GetMyNotificationsResponseItemsInner
    implements
        Built<
          GetMyNotificationsResponseItemsInner,
          GetMyNotificationsResponseItemsInnerBuilder
        > {
  /// One Of [SystemTestNotificationNotification]
  OneOf get oneOf;

  GetMyNotificationsResponseItemsInner._();

  factory GetMyNotificationsResponseItemsInner([
    void updates(GetMyNotificationsResponseItemsInnerBuilder b),
  ]) = _$GetMyNotificationsResponseItemsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetMyNotificationsResponseItemsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetMyNotificationsResponseItemsInner> get serializer =>
      _$GetMyNotificationsResponseItemsInnerSerializer();
}

class _$GetMyNotificationsResponseItemsInnerSerializer
    implements PrimitiveSerializer<GetMyNotificationsResponseItemsInner> {
  @override
  final Iterable<Type> types = const [
    GetMyNotificationsResponseItemsInner,
    _$GetMyNotificationsResponseItemsInner,
  ];

  @override
  final String wireName = r'GetMyNotificationsResponseItemsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetMyNotificationsResponseItemsInner object,
  ) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    GetMyNotificationsResponseItemsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(
      oneOf.value,
      specifiedType: FullType(oneOf.valueType),
    )!;
  }

  @override
  GetMyNotificationsResponseItemsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetMyNotificationsResponseItemsInnerBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [
      FullType(SystemTestNotificationNotification),
    ]);
    oneOfDataSrc = serialized;
    result.oneOf =
        serializers.deserialize(oneOfDataSrc, specifiedType: targetType)
            as OneOf;
    return result.build();
  }
}

class GetMyNotificationsResponseItemsInnerTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'system.test-notification')
  static const GetMyNotificationsResponseItemsInnerTypeEnum
  systemPeriodTestNotification =
      _$getMyNotificationsResponseItemsInnerTypeEnum_systemPeriodTestNotification;

  static Serializer<GetMyNotificationsResponseItemsInnerTypeEnum>
  get serializer => _$getMyNotificationsResponseItemsInnerTypeEnumSerializer;

  const GetMyNotificationsResponseItemsInnerTypeEnum._(String name)
    : super(name);

  static BuiltSet<GetMyNotificationsResponseItemsInnerTypeEnum> get values =>
      _$getMyNotificationsResponseItemsInnerTypeEnumValues;
  static GetMyNotificationsResponseItemsInnerTypeEnum valueOf(String name) =>
      _$getMyNotificationsResponseItemsInnerTypeEnumValueOf(name);
}
