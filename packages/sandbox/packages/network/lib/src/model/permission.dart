//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'permission.g.dart';

class Permission extends EnumClass {
  @BuiltValueEnumConst(wireName: r'all_permissions')
  static const Permission allPermissions = _$allPermissions;
  @BuiltValueEnumConst(wireName: r'contact.create')
  static const Permission contactPeriodCreate = _$contactPeriodCreate;
  @BuiltValueEnumConst(wireName: r'contact.read')
  static const Permission contactPeriodRead = _$contactPeriodRead;
  @BuiltValueEnumConst(wireName: r'contact.update')
  static const Permission contactPeriodUpdate = _$contactPeriodUpdate;
  @BuiltValueEnumConst(wireName: r'contact.delete')
  static const Permission contactPeriodDelete = _$contactPeriodDelete;
  @BuiltValueEnumConst(wireName: r'event-log.read')
  static const Permission eventLogPeriodRead = _$eventLogPeriodRead;
  @BuiltValueEnumConst(wireName: r'file.read')
  static const Permission filePeriodRead = _$filePeriodRead;
  @BuiltValueEnumConst(wireName: r'file.create')
  static const Permission filePeriodCreate = _$filePeriodCreate;
  @BuiltValueEnumConst(wireName: r'jobs.read.index')
  static const Permission jobsPeriodReadPeriodIndex =
      _$jobsPeriodReadPeriodIndex;
  @BuiltValueEnumConst(wireName: r'jobs.read.detail')
  static const Permission jobsPeriodReadPeriodDetail =
      _$jobsPeriodReadPeriodDetail;
  @BuiltValueEnumConst(wireName: r'notification.read.own')
  static const Permission notificationPeriodReadPeriodOwn =
      _$notificationPeriodReadPeriodOwn;
  @BuiltValueEnumConst(wireName: r'notification.read.config')
  static const Permission notificationPeriodReadPeriodConfig =
      _$notificationPeriodReadPeriodConfig;
  @BuiltValueEnumConst(wireName: r'notification.update.read')
  static const Permission notificationPeriodUpdatePeriodRead =
      _$notificationPeriodUpdatePeriodRead;
  @BuiltValueEnumConst(wireName: r'notification.update.unread')
  static const Permission notificationPeriodUpdatePeriodUnread =
      _$notificationPeriodUpdatePeriodUnread;
  @BuiltValueEnumConst(wireName: r'notification.preferences.update.channel')
  static const Permission
  notificationPeriodPreferencesPeriodUpdatePeriodChannel =
      _$notificationPeriodPreferencesPeriodUpdatePeriodChannel;
  @BuiltValueEnumConst(wireName: r'notification.preferences.update.preset')
  static const Permission
  notificationPeriodPreferencesPeriodUpdatePeriodPreset =
      _$notificationPeriodPreferencesPeriodUpdatePeriodPreset;
  @BuiltValueEnumConst(wireName: r'notification.preferences.update.types')
  static const Permission notificationPeriodPreferencesPeriodUpdatePeriodTypes =
      _$notificationPeriodPreferencesPeriodUpdatePeriodTypes;
  @BuiltValueEnumConst(wireName: r'notification.preferences.read.own')
  static const Permission notificationPeriodPreferencesPeriodReadPeriodOwn =
      _$notificationPeriodPreferencesPeriodReadPeriodOwn;
  @BuiltValueEnumConst(wireName: r'notification.migrate-type')
  static const Permission notificationPeriodMigrateType =
      _$notificationPeriodMigrateType;
  @BuiltValueEnumConst(wireName: r'notification.send-test')
  static const Permission notificationPeriodSendTest =
      _$notificationPeriodSendTest;
  @BuiltValueEnumConst(wireName: r'role.read')
  static const Permission rolePeriodRead = _$rolePeriodRead;
  @BuiltValueEnumConst(wireName: r'role.create')
  static const Permission rolePeriodCreate = _$rolePeriodCreate;
  @BuiltValueEnumConst(wireName: r'role.update')
  static const Permission rolePeriodUpdate = _$rolePeriodUpdate;
  @BuiltValueEnumConst(wireName: r'role.delete')
  static const Permission rolePeriodDelete = _$rolePeriodDelete;
  @BuiltValueEnumConst(wireName: r'role.cache.clear')
  static const Permission rolePeriodCachePeriodClear =
      _$rolePeriodCachePeriodClear;
  @BuiltValueEnumConst(wireName: r'send_push_notification')
  static const Permission sendPushNotification = _$sendPushNotification;
  @BuiltValueEnumConst(wireName: r'typesense')
  static const Permission typesense = _$typesense;
  @BuiltValueEnumConst(wireName: r'user.read')
  static const Permission userPeriodRead = _$userPeriodRead;
  @BuiltValueEnumConst(wireName: r'user.create')
  static const Permission userPeriodCreate = _$userPeriodCreate;
  @BuiltValueEnumConst(wireName: r'user.update')
  static const Permission userPeriodUpdate = _$userPeriodUpdate;
  @BuiltValueEnumConst(wireName: r'user.delete')
  static const Permission userPeriodDelete = _$userPeriodDelete;

  static Serializer<Permission> get serializer => _$permissionSerializer;

  const Permission._(String name) : super(name);

  static BuiltSet<Permission> get values => _$values;
  static Permission valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class PermissionMixin = Object with _$PermissionMixin;
