//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:openapi/src/date_serializer.dart';
import 'package:openapi/src/model/date.dart';

import 'package:openapi/src/model/address_command.dart';
import 'package:openapi/src/model/address_response.dart';
import 'package:openapi/src/model/all_notifications_marked_as_read_event_content.dart';
import 'package:openapi/src/model/clear_role_permissions_cache_command.dart';
import 'package:openapi/src/model/confirm_file_upload_command.dart';
import 'package:openapi/src/model/confirm_file_upload_v2404_response.dart';
import 'package:openapi/src/model/confirm_file_upload_v2404_response_errors_inner.dart';
import 'package:openapi/src/model/contact_created_domain_event_log.dart';
import 'package:openapi/src/model/contact_created_event_content.dart';
import 'package:openapi/src/model/contact_deleted_domain_event_log.dart';
import 'package:openapi/src/model/contact_deleted_event_content.dart';
import 'package:openapi/src/model/contact_not_found_error.dart';
import 'package:openapi/src/model/contact_response.dart';
import 'package:openapi/src/model/contact_updated_domain_event_log.dart';
import 'package:openapi/src/model/contact_updated_event_content.dart';
import 'package:openapi/src/model/coordinates_command.dart';
import 'package:openapi/src/model/coordinates_response.dart';
import 'package:openapi/src/model/create_contact_command.dart';
import 'package:openapi/src/model/create_contact_response.dart';
import 'package:openapi/src/model/create_file_command.dart';
import 'package:openapi/src/model/create_file_response.dart';
import 'package:openapi/src/model/create_one_signal_token_response.dart';
import 'package:openapi/src/model/create_role_command.dart';
import 'package:openapi/src/model/create_role_response.dart';
import 'package:openapi/src/model/created_by_user_response.dart';
import 'package:openapi/src/model/currency.dart';
import 'package:openapi/src/model/delete_contact_v1404_response.dart';
import 'package:openapi/src/model/delete_contact_v1404_response_errors_inner.dart';
import 'package:openapi/src/model/domain_event_log_response.dart';
import 'package:openapi/src/model/file_created_domain_event_log.dart';
import 'package:openapi/src/model/file_created_event_content.dart';
import 'package:openapi/src/model/file_not_found_error.dart';
import 'package:openapi/src/model/file_response.dart';
import 'package:openapi/src/model/file_uploaded_domain_event_log.dart';
import 'package:openapi/src/model/file_uploaded_event_content.dart';
import 'package:openapi/src/model/font_size.dart';
import 'package:openapi/src/model/get_api_info_response.dart';
import 'package:openapi/src/model/get_my_notification_preferences_response.dart';
import 'package:openapi/src/model/get_my_notifications_filter_query.dart';
import 'package:openapi/src/model/get_my_notifications_pagination_query.dart';
import 'package:openapi/src/model/get_my_notifications_query_key.dart';
import 'package:openapi/src/model/get_my_notifications_response.dart';
import 'package:openapi/src/model/get_my_notifications_response_items_inner.dart';
import 'package:openapi/src/model/get_my_notifications_response_meta.dart';
import 'package:openapi/src/model/get_notification_types_config_response.dart';
import 'package:openapi/src/model/global_search_collection_name.dart';
import 'package:openapi/src/model/internal_server_api_error.dart';
import 'package:openapi/src/model/job_not_found_error.dart';
import 'package:openapi/src/model/job_status.dart';
import 'package:openapi/src/model/locale.dart';
import 'package:openapi/src/model/migrate_collections_v1500_response.dart';
import 'package:openapi/src/model/migrate_collections_v1500_response_errors_inner.dart';
import 'package:openapi/src/model/migrate_notification_types_command.dart';
import 'package:openapi/src/model/migrate_notification_types_v1400_response.dart';
import 'package:openapi/src/model/migrate_notification_types_v1400_response_errors_inner.dart';
import 'package:openapi/src/model/migration_already_performed_error.dart';
import 'package:openapi/src/model/migration_already_performed_error_meta.dart';
import 'package:openapi/src/model/mime_type.dart';
import 'package:openapi/src/model/monetary_dto.dart';
import 'package:openapi/src/model/notification_channel.dart';
import 'package:openapi/src/model/notification_created_domain_event_log.dart';
import 'package:openapi/src/model/notification_created_event_content.dart';
import 'package:openapi/src/model/notification_preference_preset_event_content.dart';
import 'package:openapi/src/model/notification_preference_preset_updated_domain_event_log.dart';
import 'package:openapi/src/model/notification_preset.dart';
import 'package:openapi/src/model/notification_read_all_domain_event_log.dart';
import 'package:openapi/src/model/notification_read_domain_event_log.dart';
import 'package:openapi/src/model/notification_read_event_content.dart';
import 'package:openapi/src/model/notification_type.dart';
import 'package:openapi/src/model/notification_type_channel_config.dart';
import 'package:openapi/src/model/notification_types_migrated_domain_event_log.dart';
import 'package:openapi/src/model/notification_types_migrated_event_content.dart';
import 'package:openapi/src/model/notification_unread_domain_event_log.dart';
import 'package:openapi/src/model/notification_unread_event_content.dart';
import 'package:openapi/src/model/paginated_offset_query.dart';
import 'package:openapi/src/model/paginated_offset_response_meta.dart';
import 'package:openapi/src/model/permission.dart';
import 'package:openapi/src/model/preference_types.dart';
import 'package:openapi/src/model/presigned_file_response.dart';
import 'package:openapi/src/model/presigned_file_variant_response.dart';
import 'package:openapi/src/model/queue_name.dart';
import 'package:openapi/src/model/role_assigned_to_user_event_content.dart';
import 'package:openapi/src/model/role_created_domain_event_log.dart';
import 'package:openapi/src/model/role_created_event_content.dart';
import 'package:openapi/src/model/role_deleted_domain_event_log.dart';
import 'package:openapi/src/model/role_deleted_event_content.dart';
import 'package:openapi/src/model/role_not_found_error.dart';
import 'package:openapi/src/model/role_permissions_cache_cleared_domain_event_log.dart';
import 'package:openapi/src/model/role_permissions_cache_cleared_event_content.dart';
import 'package:openapi/src/model/role_permissions_updated_domain_event_log.dart';
import 'package:openapi/src/model/role_permissions_updated_event_content.dart';
import 'package:openapi/src/model/role_renamed_domain_event_log.dart';
import 'package:openapi/src/model/role_renamed_event_content.dart';
import 'package:openapi/src/model/role_response.dart';
import 'package:openapi/src/model/search_collection_contact_response.dart';
import 'package:openapi/src/model/search_collection_user_response.dart';
import 'package:openapi/src/model/search_collections_filter_contact_query.dart';
import 'package:openapi/src/model/search_collections_filter_query.dart';
import 'package:openapi/src/model/search_collections_response.dart';
import 'package:openapi/src/model/search_collections_response_item.dart';
import 'package:openapi/src/model/search_collections_response_item_entity.dart';
import 'package:openapi/src/model/send_push_notification_command.dart';
import 'package:openapi/src/model/send_test_notification_command.dart';
import 'package:openapi/src/model/set_user_roles_command.dart';
import 'package:openapi/src/model/set_user_roles_v1404_response.dart';
import 'package:openapi/src/model/set_user_roles_v1404_response_errors_inner.dart';
import 'package:openapi/src/model/sort_direction.dart';
import 'package:openapi/src/model/subject_type.dart';
import 'package:openapi/src/model/system_test_notification_notification.dart';
import 'package:openapi/src/model/test_notification_content.dart';
import 'package:openapi/src/model/test_notification_sent_domain_event_log.dart';
import 'package:openapi/src/model/test_notification_sent_event_content.dart';
import 'package:openapi/src/model/translations.dart';
import 'package:openapi/src/model/typesense_collection_name.dart';
import 'package:openapi/src/model/ui_theme.dart';
import 'package:openapi/src/model/update_contact_command.dart';
import 'package:openapi/src/model/update_contact_v1404_response.dart';
import 'package:openapi/src/model/update_contact_v1404_response_errors_inner.dart';
import 'package:openapi/src/model/update_my_channel_notification_preference_command.dart';
import 'package:openapi/src/model/update_my_notification_preference_preset_command.dart';
import 'package:openapi/src/model/update_my_notification_type_preference_command.dart';
import 'package:openapi/src/model/update_role_command.dart';
import 'package:openapi/src/model/update_roles_permissions_command.dart';
import 'package:openapi/src/model/update_roles_permissions_command_item.dart';
import 'package:openapi/src/model/update_roles_permissions_v1404_response.dart';
import 'package:openapi/src/model/update_roles_permissions_v1404_response_errors_inner.dart';
import 'package:openapi/src/model/update_ui_preferences_command.dart';
import 'package:openapi/src/model/user_created_domain_event_log.dart';
import 'package:openapi/src/model/user_created_event_content.dart';
import 'package:openapi/src/model/user_index_role_view.dart';
import 'package:openapi/src/model/user_index_view.dart';
import 'package:openapi/src/model/user_not_found_error.dart';
import 'package:openapi/src/model/user_notification_created_domain_event_log.dart';
import 'package:openapi/src/model/user_notification_created_event_content.dart';
import 'package:openapi/src/model/user_notification_not_found_error.dart';
import 'package:openapi/src/model/user_role_assigned_domain_event_log.dart';
import 'package:openapi/src/model/view_collection_index_response.dart';
import 'package:openapi/src/model/view_contact_detail_response.dart';
import 'package:openapi/src/model/view_contact_index_filter_query.dart';
import 'package:openapi/src/model/view_contact_index_response.dart';
import 'package:openapi/src/model/view_contact_index_sort_query.dart';
import 'package:openapi/src/model/view_contact_index_sort_query_key.dart';
import 'package:openapi/src/model/view_domain_event_log_index_filter_query.dart';
import 'package:openapi/src/model/view_domain_event_log_index_pagination_query.dart';
import 'package:openapi/src/model/view_domain_event_log_index_query_key.dart';
import 'package:openapi/src/model/view_domain_event_log_index_response.dart';
import 'package:openapi/src/model/view_domain_event_log_index_response_items_inner.dart';
import 'package:openapi/src/model/view_domain_event_log_index_response_meta.dart';
import 'package:openapi/src/model/view_job_detail_response.dart';
import 'package:openapi/src/model/view_job_detail_v1404_response.dart';
import 'package:openapi/src/model/view_job_detail_v1404_response_errors_inner.dart';
import 'package:openapi/src/model/view_jobs_index_filter_query.dart';
import 'package:openapi/src/model/view_jobs_index_item_response.dart';
import 'package:openapi/src/model/view_jobs_index_pagination_query.dart';
import 'package:openapi/src/model/view_jobs_index_query_key.dart';
import 'package:openapi/src/model/view_jobs_index_response.dart';
import 'package:openapi/src/model/view_jobs_index_response_meta.dart';
import 'package:openapi/src/model/view_jobs_index_sort_query.dart';
import 'package:openapi/src/model/view_jobs_index_sort_query_key.dart';
import 'package:openapi/src/model/view_me_response.dart';
import 'package:openapi/src/model/view_notification_type_config_type_response.dart';
import 'package:openapi/src/model/view_notification_types_config_group_response.dart';
import 'package:openapi/src/model/view_permission_index_group_response.dart';
import 'package:openapi/src/model/view_permission_index_permission_response.dart';
import 'package:openapi/src/model/view_permission_index_response.dart';
import 'package:openapi/src/model/view_role_detail_response.dart';
import 'package:openapi/src/model/view_role_index_response.dart';
import 'package:openapi/src/model/view_ui_preferences_response.dart';
import 'package:openapi/src/model/view_unread_notifications_count_response.dart';
import 'package:openapi/src/model/view_user_detail_response.dart';
import 'package:openapi/src/model/view_user_index_response.dart';
import 'package:openapi/src/model/view_user_notification_detail_v1404_response.dart';
import 'package:openapi/src/model/view_user_notification_detail_v1404_response_errors_inner.dart';

part 'serializers.g.dart';

@SerializersFor([
  AddressCommand,
  AddressResponse,
  AllNotificationsMarkedAsReadEventContent,
  ClearRolePermissionsCacheCommand,
  ConfirmFileUploadCommand,
  ConfirmFileUploadV2404Response,
  ConfirmFileUploadV2404ResponseErrorsInner,
  ContactCreatedDomainEventLog,
  ContactCreatedEventContent,
  ContactDeletedDomainEventLog,
  ContactDeletedEventContent,
  ContactNotFoundError,
  ContactResponse,
  ContactUpdatedDomainEventLog,
  ContactUpdatedEventContent,
  CoordinatesCommand,
  CoordinatesResponse,
  CreateContactCommand,
  CreateContactResponse,
  CreateFileCommand,
  CreateFileResponse,
  CreateOneSignalTokenResponse,
  CreateRoleCommand,
  CreateRoleResponse,
  CreatedByUserResponse,
  Currency,
  DeleteContactV1404Response,
  DeleteContactV1404ResponseErrorsInner,
  DomainEventLogResponse,
  FileCreatedDomainEventLog,
  FileCreatedEventContent,
  FileNotFoundError,
  FileResponse,
  FileUploadedDomainEventLog,
  FileUploadedEventContent,
  FontSize,
  GetApiInfoResponse,
  GetMyNotificationPreferencesResponse,
  GetMyNotificationsFilterQuery,
  GetMyNotificationsPaginationQuery,
  GetMyNotificationsQueryKey,
  GetMyNotificationsResponse,
  GetMyNotificationsResponseItemsInner,
  GetMyNotificationsResponseMeta,
  GetNotificationTypesConfigResponse,
  GlobalSearchCollectionName,
  InternalServerApiError,
  JobNotFoundError,
  JobStatus,
  Locale,
  MigrateCollectionsV1500Response,
  MigrateCollectionsV1500ResponseErrorsInner,
  MigrateNotificationTypesCommand,
  MigrateNotificationTypesV1400Response,
  MigrateNotificationTypesV1400ResponseErrorsInner,
  MigrationAlreadyPerformedError,
  MigrationAlreadyPerformedErrorMeta,
  MimeType,
  MonetaryDto,
  NotificationChannel,
  NotificationCreatedDomainEventLog,
  NotificationCreatedEventContent,
  NotificationPreferencePresetEventContent,
  NotificationPreferencePresetUpdatedDomainEventLog,
  NotificationPreset,
  NotificationReadAllDomainEventLog,
  NotificationReadDomainEventLog,
  NotificationReadEventContent,
  NotificationType,
  NotificationTypeChannelConfig,
  NotificationTypesMigratedDomainEventLog,
  NotificationTypesMigratedEventContent,
  NotificationUnreadDomainEventLog,
  NotificationUnreadEventContent,
  PaginatedOffsetQuery,
  PaginatedOffsetResponseMeta,
  Permission,
  PreferenceTypes,
  PresignedFileResponse,
  PresignedFileVariantResponse,
  QueueName,
  RoleAssignedToUserEventContent,
  RoleCreatedDomainEventLog,
  RoleCreatedEventContent,
  RoleDeletedDomainEventLog,
  RoleDeletedEventContent,
  RoleNotFoundError,
  RolePermissionsCacheClearedDomainEventLog,
  RolePermissionsCacheClearedEventContent,
  RolePermissionsUpdatedDomainEventLog,
  RolePermissionsUpdatedEventContent,
  RoleRenamedDomainEventLog,
  RoleRenamedEventContent,
  RoleResponse,
  SearchCollectionContactResponse,
  SearchCollectionUserResponse,
  SearchCollectionsFilterContactQuery,
  SearchCollectionsFilterQuery,
  SearchCollectionsResponse,
  SearchCollectionsResponseItem,
  SearchCollectionsResponseItemEntity,
  SendPushNotificationCommand,
  SendTestNotificationCommand,
  SetUserRolesCommand,
  SetUserRolesV1404Response,
  SetUserRolesV1404ResponseErrorsInner,
  SortDirection,
  SubjectType,
  SystemTestNotificationNotification,
  TestNotificationContent,
  TestNotificationSentDomainEventLog,
  TestNotificationSentEventContent,
  Translations,
  TypesenseCollectionName,
  UITheme,
  UpdateContactCommand,
  UpdateContactV1404Response,
  UpdateContactV1404ResponseErrorsInner,
  UpdateMyChannelNotificationPreferenceCommand,
  UpdateMyNotificationPreferencePresetCommand,
  UpdateMyNotificationTypePreferenceCommand,
  UpdateRoleCommand,
  UpdateRolesPermissionsCommand,
  UpdateRolesPermissionsCommandItem,
  UpdateRolesPermissionsV1404Response,
  UpdateRolesPermissionsV1404ResponseErrorsInner,
  UpdateUiPreferencesCommand,
  UserCreatedDomainEventLog,
  UserCreatedEventContent,
  UserIndexRoleView,
  UserIndexView,
  UserNotFoundError,
  UserNotificationCreatedDomainEventLog,
  UserNotificationCreatedEventContent,
  UserNotificationNotFoundError,
  UserRoleAssignedDomainEventLog,
  ViewCollectionIndexResponse,
  ViewContactDetailResponse,
  ViewContactIndexFilterQuery,
  ViewContactIndexResponse,
  ViewContactIndexSortQuery,
  ViewContactIndexSortQueryKey,
  ViewDomainEventLogIndexFilterQuery,
  ViewDomainEventLogIndexPaginationQuery,
  ViewDomainEventLogIndexQueryKey,
  ViewDomainEventLogIndexResponse,
  ViewDomainEventLogIndexResponseItemsInner,
  ViewDomainEventLogIndexResponseMeta,
  ViewJobDetailResponse,
  ViewJobDetailV1404Response,
  ViewJobDetailV1404ResponseErrorsInner,
  ViewJobsIndexFilterQuery,
  ViewJobsIndexItemResponse,
  ViewJobsIndexPaginationQuery,
  ViewJobsIndexQueryKey,
  ViewJobsIndexResponse,
  ViewJobsIndexResponseMeta,
  ViewJobsIndexSortQuery,
  ViewJobsIndexSortQueryKey,
  ViewMeResponse,
  ViewNotificationTypeConfigTypeResponse,
  ViewNotificationTypesConfigGroupResponse,
  ViewPermissionIndexGroupResponse,
  ViewPermissionIndexPermissionResponse,
  ViewPermissionIndexResponse,
  ViewRoleDetailResponse,
  ViewRoleIndexResponse,
  ViewUiPreferencesResponse,
  ViewUnreadNotificationsCountResponse,
  ViewUserDetailResponse,
  ViewUserIndexResponse,
  ViewUserNotificationDetailV1404Response,
  ViewUserNotificationDetailV1404ResponseErrorsInner,
])
Serializers serializers =
    (_$serializers.toBuilder()
          ..addBuilderFactory(
            const FullType(BuiltList, [FullType(ViewJobsIndexSortQuery)]),
            () => ListBuilder<ViewJobsIndexSortQuery>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, [FullType(TypesenseCollectionName)]),
            () => ListBuilder<TypesenseCollectionName>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, [FullType(ViewContactIndexSortQuery)]),
            () => ListBuilder<ViewContactIndexSortQuery>(),
          )
          ..add(const OneOfSerializer())
          ..add(const AnyOfSerializer())
          ..add(const DateSerializer())
          ..add(Iso8601DateTimeSerializer()))
        .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
