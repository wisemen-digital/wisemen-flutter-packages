import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for NotificationPreferenceApi
void main() {
  final instance = Openapi().getNotificationPreferenceApi();

  group(NotificationPreferenceApi, () {
    //Future<GetMyNotificationPreferencesResponse> getMyNotificationPreferencesV1() async
    test('test getMyNotificationPreferencesV1', () async {
      // TODO
    });

    //Future<GetNotificationTypesConfigResponse> getNotificationTypesConfigV1() async
    test('test getNotificationTypesConfigV1', () async {
      // TODO
    });

    //Future updateMyChannelNotificationPreferenceV1(UpdateMyChannelNotificationPreferenceCommand updateMyChannelNotificationPreferenceCommand) async
    test('test updateMyChannelNotificationPreferenceV1', () async {
      // TODO
    });

    //Future updateMyNotificationPreferencePresetV1(UpdateMyNotificationPreferencePresetCommand updateMyNotificationPreferencePresetCommand) async
    test('test updateMyNotificationPreferencePresetV1', () async {
      // TODO
    });

    //Future updateMyNotificationTypePreferenceV1(UpdateMyNotificationTypePreferenceCommand updateMyNotificationTypePreferenceCommand) async
    test('test updateMyNotificationTypePreferenceV1', () async {
      // TODO
    });
  });
}
