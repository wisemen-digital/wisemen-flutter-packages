import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisecore/src/dialogs/error_dialog.dart';

class MockErrorUtils with ErrorDialog {}

final List<MethodCall> log = <MethodCall>[];
const channel = MethodChannel('flutter_platform_alert');

void mockPlatformAlerts() {
  Future<String?>? handler(MethodCall methodCall) async {
    if (methodCall.method == 'showAlert') {
      log.add(methodCall);
      return 'ok';
    }
    return null;
  }

  TestWidgetsFlutterBinding.ensureInitialized();

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, handler);
}

void main() {
  final mockErrorUtils = MockErrorUtils();
  setUpAll(mockPlatformAlerts);
  tearDown(log.clear);

  test('Calls the right method channel function on showErrorDialog', () async {
    unawaited(
      mockErrorUtils.showErrorDialog(
        title: 'title',
        message: 'message',
      ),
    );
    expect(
      log.first.method,
      'showAlert',
    );
    channel.setMethodCallHandler(null);
  });
}
