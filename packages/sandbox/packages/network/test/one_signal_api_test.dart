import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for OneSignalApi
void main() {
  final instance = Openapi().getOneSignalApi();

  group(OneSignalApi, () {
    //Future<CreateOneSignalTokenResponse> createOneSignalTokenV1() async
    test('test createOneSignalTokenV1', () async {
      // TODO
    });

    //Future sendPushNotificationV1(SendPushNotificationCommand sendPushNotificationCommand) async
    test('test sendPushNotificationV1', () async {
      // TODO
    });
  });
}
