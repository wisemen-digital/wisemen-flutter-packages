//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/user_created_domain_event_log.dart';
import 'package:openapi/src/model/user_notification_created_domain_event_log.dart';
import 'package:openapi/src/model/notification_created_domain_event_log.dart';
import 'package:openapi/src/model/file_created_domain_event_log.dart';
import 'package:openapi/src/model/role_permissions_updated_domain_event_log.dart';
import 'package:openapi/src/model/notification_read_domain_event_log.dart';
import 'package:openapi/src/model/role_created_domain_event_log.dart';
import 'package:openapi/src/model/contact_created_domain_event_log.dart';
import 'package:openapi/src/model/role_deleted_domain_event_log.dart';
import 'package:openapi/src/model/contact_updated_domain_event_log.dart';
import 'package:openapi/src/model/role_renamed_domain_event_log.dart';
import 'package:openapi/src/model/contact_deleted_domain_event_log.dart';
import 'package:openapi/src/model/notification_types_migrated_domain_event_log.dart';
import 'package:openapi/src/model/test_notification_sent_domain_event_log.dart';
import 'package:openapi/src/model/notification_preference_preset_updated_domain_event_log.dart';
import 'package:openapi/src/model/file_uploaded_domain_event_log.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/role_permissions_cache_cleared_domain_event_log.dart';
import 'package:openapi/src/model/user_role_assigned_domain_event_log.dart';
import 'package:openapi/src/model/notification_read_all_domain_event_log.dart';
import 'package:openapi/src/model/notification_unread_domain_event_log.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'view_domain_event_log_index_response_items_inner.g.dart';

/// ViewDomainEventLogIndexResponseItemsInner
///
/// Properties:
/// * [uuid]
/// * [createdAt]
/// * [version]
/// * [source_]
/// * [userUuid]
/// * [message]
/// * [subjectType]
/// * [subjectId]
/// * [type]
/// * [content]
@BuiltValue()
abstract class ViewDomainEventLogIndexResponseItemsInner
    implements
        Built<
          ViewDomainEventLogIndexResponseItemsInner,
          ViewDomainEventLogIndexResponseItemsInnerBuilder
        > {
  /// One Of [ContactCreatedDomainEventLog], [ContactDeletedDomainEventLog], [ContactUpdatedDomainEventLog], [FileCreatedDomainEventLog], [FileUploadedDomainEventLog], [NotificationCreatedDomainEventLog], [NotificationPreferencePresetUpdatedDomainEventLog], [NotificationReadAllDomainEventLog], [NotificationReadDomainEventLog], [NotificationTypesMigratedDomainEventLog], [NotificationUnreadDomainEventLog], [RoleCreatedDomainEventLog], [RoleDeletedDomainEventLog], [RolePermissionsCacheClearedDomainEventLog], [RolePermissionsUpdatedDomainEventLog], [RoleRenamedDomainEventLog], [TestNotificationSentDomainEventLog], [UserCreatedDomainEventLog], [UserNotificationCreatedDomainEventLog], [UserRoleAssignedDomainEventLog]
  OneOf get oneOf;

  ViewDomainEventLogIndexResponseItemsInner._();

  factory ViewDomainEventLogIndexResponseItemsInner([
    void updates(ViewDomainEventLogIndexResponseItemsInnerBuilder b),
  ]) = _$ViewDomainEventLogIndexResponseItemsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewDomainEventLogIndexResponseItemsInnerBuilder b) =>
      b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewDomainEventLogIndexResponseItemsInner> get serializer =>
      _$ViewDomainEventLogIndexResponseItemsInnerSerializer();
}

class _$ViewDomainEventLogIndexResponseItemsInnerSerializer
    implements PrimitiveSerializer<ViewDomainEventLogIndexResponseItemsInner> {
  @override
  final Iterable<Type> types = const [
    ViewDomainEventLogIndexResponseItemsInner,
    _$ViewDomainEventLogIndexResponseItemsInner,
  ];

  @override
  final String wireName = r'ViewDomainEventLogIndexResponseItemsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewDomainEventLogIndexResponseItemsInner object,
  ) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    ViewDomainEventLogIndexResponseItemsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(
      oneOf.value,
      specifiedType: FullType(oneOf.valueType),
    )!;
  }

  @override
  ViewDomainEventLogIndexResponseItemsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewDomainEventLogIndexResponseItemsInnerBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [
      FullType(UserCreatedDomainEventLog),
      FullType(UserRoleAssignedDomainEventLog),
      FullType(RolePermissionsCacheClearedDomainEventLog),
      FullType(RolePermissionsUpdatedDomainEventLog),
      FullType(RoleDeletedDomainEventLog),
      FullType(NotificationCreatedDomainEventLog),
      FullType(UserNotificationCreatedDomainEventLog),
      FullType(ContactCreatedDomainEventLog),
      FullType(ContactUpdatedDomainEventLog),
      FullType(ContactDeletedDomainEventLog),
      FullType(RoleCreatedDomainEventLog),
      FullType(RoleRenamedDomainEventLog),
      FullType(FileCreatedDomainEventLog),
      FullType(FileUploadedDomainEventLog),
      FullType(NotificationReadDomainEventLog),
      FullType(NotificationUnreadDomainEventLog),
      FullType(NotificationPreferencePresetUpdatedDomainEventLog),
      FullType(NotificationTypesMigratedDomainEventLog),
      FullType(TestNotificationSentDomainEventLog),
      FullType(NotificationReadAllDomainEventLog),
    ]);
    oneOfDataSrc = serialized;
    result.oneOf =
        serializers.deserialize(oneOfDataSrc, specifiedType: targetType)
            as OneOf;
    return result.build();
  }
}

class ViewDomainEventLogIndexResponseItemsInnerTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'user.created')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  userPeriodCreated =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_userPeriodCreated;
  @BuiltValueEnumConst(wireName: r'user.role-assigned')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  userPeriodRoleAssigned =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_userPeriodRoleAssigned;
  @BuiltValueEnumConst(wireName: r'role.permissions.cache.cleared')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  rolePeriodPermissionsPeriodCachePeriodCleared =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_rolePeriodPermissionsPeriodCachePeriodCleared;
  @BuiltValueEnumConst(wireName: r'role.permissions.updated')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  rolePeriodPermissionsPeriodUpdated =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_rolePeriodPermissionsPeriodUpdated;
  @BuiltValueEnumConst(wireName: r'role.deleted')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  rolePeriodDeleted =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_rolePeriodDeleted;
  @BuiltValueEnumConst(wireName: r'notification.created')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  notificationPeriodCreated =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_notificationPeriodCreated;
  @BuiltValueEnumConst(wireName: r'user.notification.created')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  userPeriodNotificationPeriodCreated =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_userPeriodNotificationPeriodCreated;
  @BuiltValueEnumConst(wireName: r'contact.created')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  contactPeriodCreated =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_contactPeriodCreated;
  @BuiltValueEnumConst(wireName: r'contact.updated')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  contactPeriodUpdated =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_contactPeriodUpdated;
  @BuiltValueEnumConst(wireName: r'contact.deleted')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  contactPeriodDeleted =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_contactPeriodDeleted;
  @BuiltValueEnumConst(wireName: r'role.created')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  rolePeriodCreated =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_rolePeriodCreated;
  @BuiltValueEnumConst(wireName: r'role.renamed')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  rolePeriodRenamed =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_rolePeriodRenamed;
  @BuiltValueEnumConst(wireName: r'file.created')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  filePeriodCreated =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_filePeriodCreated;
  @BuiltValueEnumConst(wireName: r'file.uploaded')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  filePeriodUploaded =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_filePeriodUploaded;
  @BuiltValueEnumConst(wireName: r'notification.read')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  notificationPeriodRead =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_notificationPeriodRead;
  @BuiltValueEnumConst(wireName: r'notification.unread')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  notificationPeriodUnread =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_notificationPeriodUnread;
  @BuiltValueEnumConst(wireName: r'notification.preference.preset.updated')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  notificationPeriodPreferencePeriodPresetPeriodUpdated =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_notificationPeriodPreferencePeriodPresetPeriodUpdated;
  @BuiltValueEnumConst(wireName: r'notification.types.migrated')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  notificationPeriodTypesPeriodMigrated =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_notificationPeriodTypesPeriodMigrated;
  @BuiltValueEnumConst(wireName: r'test-notification.sent')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  testNotificationPeriodSent =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_testNotificationPeriodSent;
  @BuiltValueEnumConst(wireName: r'notification.read.all')
  static const ViewDomainEventLogIndexResponseItemsInnerTypeEnum
  notificationPeriodReadPeriodAll =
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnum_notificationPeriodReadPeriodAll;

  static Serializer<ViewDomainEventLogIndexResponseItemsInnerTypeEnum>
  get serializer =>
      _$viewDomainEventLogIndexResponseItemsInnerTypeEnumSerializer;

  const ViewDomainEventLogIndexResponseItemsInnerTypeEnum._(String name)
    : super(name);

  static BuiltSet<ViewDomainEventLogIndexResponseItemsInnerTypeEnum>
  get values => _$viewDomainEventLogIndexResponseItemsInnerTypeEnumValues;
  static ViewDomainEventLogIndexResponseItemsInnerTypeEnum valueOf(
    String name,
  ) => _$viewDomainEventLogIndexResponseItemsInnerTypeEnumValueOf(name);
}
