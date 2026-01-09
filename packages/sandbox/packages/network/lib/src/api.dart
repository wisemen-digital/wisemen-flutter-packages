//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:dio/dio.dart';
import 'package:built_value/serializer.dart';
import 'package:openapi/src/serializers.dart';
import 'package:openapi/src/api/api_status_api.dart';
import 'package:openapi/src/api/contact_api.dart';
import 'package:openapi/src/api/event_log_api.dart';
import 'package:openapi/src/api/file_api.dart';
import 'package:openapi/src/api/global_search_api.dart';
import 'package:openapi/src/api/job_api.dart';
import 'package:openapi/src/api/notification_api.dart';
import 'package:openapi/src/api/notification_preference_api.dart';
import 'package:openapi/src/api/one_signal_api.dart';
import 'package:openapi/src/api/permission_api.dart';
import 'package:openapi/src/api/preference_api.dart';
import 'package:openapi/src/api/role_api.dart';
import 'package:openapi/src/api/typesense_api.dart';
import 'package:openapi/src/api/user_api.dart';
import 'package:wiseclient/wiseclient.dart';

class Openapi {
  static const String basePath = r'http://localhost:8080';

  final WiseClient client;
  final Serializers serializers;

  Openapi({WiseClient? client, Serializers? serializers, List<Interceptor>? interceptors})
    : this.serializers = serializers ?? standardSerializers,
      this.client =
          client ??
          WiseClient(
            options: WiseOptions.base(url: basePath),
            wiseInterceptors: [WiseInterceptor.fresh],
          ) {}

  /// Get APIStatusApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  APIStatusApi getAPIStatusApi() {
    return APIStatusApi(client, serializers);
  }

  /// Get ContactApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ContactApi getContactApi() {
    return ContactApi(client, serializers);
  }

  /// Get EventLogApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  EventLogApi getEventLogApi() {
    return EventLogApi(client, serializers);
  }

  /// Get FileApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  FileApi getFileApi() {
    return FileApi(client, serializers);
  }

  /// Get GlobalSearchApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  GlobalSearchApi getGlobalSearchApi() {
    return GlobalSearchApi(client, serializers);
  }

  /// Get JobApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  JobApi getJobApi() {
    return JobApi(client, serializers);
  }

  /// Get NotificationApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  NotificationApi getNotificationApi() {
    return NotificationApi(client, serializers);
  }

  /// Get NotificationPreferenceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  NotificationPreferenceApi getNotificationPreferenceApi() {
    return NotificationPreferenceApi(client, serializers);
  }

  /// Get OneSignalApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  OneSignalApi getOneSignalApi() {
    return OneSignalApi(client, serializers);
  }

  /// Get PermissionApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  PermissionApi getPermissionApi() {
    return PermissionApi(client, serializers);
  }

  /// Get PreferenceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  PreferenceApi getPreferenceApi() {
    return PreferenceApi(client, serializers);
  }

  /// Get RoleApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  RoleApi getRoleApi() {
    return RoleApi(client, serializers);
  }

  /// Get TypesenseApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TypesenseApi getTypesenseApi() {
    return TypesenseApi(client, serializers);
  }

  /// Get UserApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  UserApi getUserApi() {
    return UserApi(client, serializers);
  }
}
