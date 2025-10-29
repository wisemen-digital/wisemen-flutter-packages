import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const channel = MethodChannel('crossingthestreams.io/flutter_appauth');
const secureStorageChannel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');
const platformAlertChannel = MethodChannel('flutter_platform_alert');

enum PlatformAlertResponse { positive, neutral, negative }

// Global state for platform alert response (persists across tests unless explicitly reset)
PlatformAlertResponse _platformAlertResponse = PlatformAlertResponse.positive;

void setPlatformAlertResponse(PlatformAlertResponse response) {
  _platformAlertResponse = response;
}

void resetPlatformAlertResponse() {
  _platformAlertResponse = PlatformAlertResponse.positive;
}

void mockPlatformAlerts() {
  resetPlatformAlertResponse();
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
    if (methodCall.method == 'endSession') {
      return {};
    }
    if (methodCall.method == 'token') {
      return {
        'accessToken': 'refreshed_access_token',
        'refreshToken': 'refreshed_refresh_token',
        'accessTokenExpirationTime': DateTime.now()
            .add(
              const Duration(hours: 1),
            )
            .millisecondsSinceEpoch,
        'idToken': 'refreshed_id_token',
        'tokenType': 'Bearer',
        'scopes': ['openid', 'profile', 'email'],
      };
    }
    return null;
  }

  Future<dynamic>? secureStorageHandler(MethodCall methodCall) async {
    if (methodCall.method == 'write') {
      return null;
    }
    if (methodCall.method == 'read') {
      return 'mock_id_token';
    }
    if (methodCall.method == 'delete') {
      return null;
    }
    return null;
  }

  Future<String>? platformAlertHandler(MethodCall methodCall) async {
    if (methodCall.method == 'showCustomAlert') {
      switch (_platformAlertResponse) {
        case PlatformAlertResponse.positive:
          return 'positiveButton';
        case PlatformAlertResponse.neutral:
          return 'neutralButton';
        case PlatformAlertResponse.negative:
          return 'negativeButton';
      }
    }
    return 'positiveButton';
  }

  TestWidgetsFlutterBinding.ensureInitialized();

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, handler);

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(secureStorageChannel, secureStorageHandler);

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(platformAlertChannel, platformAlertHandler);
}
