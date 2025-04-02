import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisecore/src/dialogs/dialogs.dart';

class MockAlertUtils with AlertDialog {}

final List<MethodCall> log = <MethodCall>[];
const channel = MethodChannel('flutter_platform_alert');

void mockPlatformAlerts() {
  Future<String?>? handler(MethodCall methodCall) async {
    if (methodCall.method == 'showCustomAlert') {
      log.add(methodCall);
      return 'whoops';
    }
    return null;
  }

  TestWidgetsFlutterBinding.ensureInitialized();

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, handler);
}

void main() {
  final mockErrorUtils = MockAlertUtils();
  const cancelButton = CancelDialogButton(text: 'Cancel');
  const deleteButton = DestructiveDialogButton(text: 'Delete');
  const confirmButton = NormalDialogButton(text: 'Confirm');
  const customButton = CustomDialogButton(
    text: 'Custom',
    type: DialogButtonOption.normal,
  );
  const windowTitle = 'title';
  const text = 'message';

  setUp(mockPlatformAlerts);
  tearDown(log.clear);

  Future<void> waitForPlatformAlertCallBack() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 100),
    );
  }

  test('Calls custom alert with confirm action', () async {
    unawaited(
      mockErrorUtils.confirmAction(
        title: windowTitle,
        message: text,
        cancelButton: cancelButton,
        confirmButton: confirmButton,
        customButton: customButton,
      ),
    );
    await waitForPlatformAlertCallBack();
    expect(
      log.first.method,
      'showCustomAlert',
    );
    channel.setMethodCallHandler(null);
  });

  test('Calls custom alert with confirm delete', () async {
    unawaited(
      mockErrorUtils.confirmDelete(
        title: windowTitle,
        message: text,
        cancelButton: cancelButton,
        deleteButton: deleteButton,
        customButton: customButton,
      ),
    );
    await waitForPlatformAlertCallBack();
    expect(
      log.first.method,
      'showCustomAlert',
    );
    channel.setMethodCallHandler(null);
  });

  test('Calls custom alert with custom', () async {
    unawaited(
      mockErrorUtils.custom(
        title: windowTitle,
        message: text,
        buttons: [
          cancelButton,
          deleteButton,
          confirmButton,
        ],
      ),
    );
    await waitForPlatformAlertCallBack();
    expect(
      log.first.method,
      'showCustomAlert',
    );
    channel.setMethodCallHandler(null);
  });

  test('Calls custom alert with one custom button', () async {
    unawaited(
      mockErrorUtils.custom(
        title: windowTitle,
        message: text,
        buttons: [
          customButton,
        ],
      ),
    );
    await waitForPlatformAlertCallBack();
    expect(
      log.first.method,
      'showCustomAlert',
    );
    channel.setMethodCallHandler(null);
  });
}
