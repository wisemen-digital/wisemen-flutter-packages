import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for NotificationApi
void main() {
  final instance = Openapi().getNotificationApi();

  group(NotificationApi, () {
    //Future<GetMyNotificationsResponse> getMyNotificationsV1({ GetMyNotificationsFilterQuery filter, GetMyNotificationsPaginationQuery pagination }) async
    test('test getMyNotificationsV1', () async {
      // TODO
    });

    //Future markAllNotificationAsReadV1() async
    test('test markAllNotificationAsReadV1', () async {
      // TODO
    });

    //Future markNotificationAsReadV1(String notificationUuid) async
    test('test markNotificationAsReadV1', () async {
      // TODO
    });

    //Future markNotificationAsUnreadV1(String notificationUuid) async
    test('test markNotificationAsUnreadV1', () async {
      // TODO
    });

    //Future migrateNotificationTypesV1(MigrateNotificationTypesCommand migrateNotificationTypesCommand) async
    test('test migrateNotificationTypesV1', () async {
      // TODO
    });

    //Future sendTestNotificationV1(SendTestNotificationCommand sendTestNotificationCommand) async
    test('test sendTestNotificationV1', () async {
      // TODO
    });

    //Future<ViewUnreadNotificationsCountResponse> viewUnreadNotificationsCountV1() async
    test('test viewUnreadNotificationsCountV1', () async {
      // TODO
    });

    //Future<SystemTestNotificationNotification> viewUserNotificationDetailV1(String notificationUuid) async
    test('test viewUserNotificationDetailV1', () async {
      // TODO
    });
  });
}
