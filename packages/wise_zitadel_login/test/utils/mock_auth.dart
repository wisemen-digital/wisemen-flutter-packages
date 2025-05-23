import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const channel = MethodChannel('crossingthestreams.io/flutter_appauth');

void mockPlatformAlerts() {
  Future<Map<String, dynamic>?>? handler(MethodCall methodCall) async {
    if (methodCall.method == 'authorizeAndExchangeCode') {
      return {
        'accessToken': 'mock_access_token',
        'refreshToken': 'mock_refresh_token',
        'accessTokenExpirationTime': DateTime.now()
            .add(
              const Duration(hours: 1),
            )
            .millisecondsSinceEpoch,
        'idToken': 'mock_id_token',
        'tokenType': 'Bearer',
        'scopes': ['openid', 'profile', 'email'],
        'authorizationAdditionalParameters': {'foo': 'bar'},
        'tokenAdditionalParameters': {'baz': 'qux'},
      };
    }
    return null;
  }

  TestWidgetsFlutterBinding.ensureInitialized();

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, handler);
}
