import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisecore/src/dialogs/dialogs.dart';

class MockAlertUtils with AlertDialog {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final alerts = MockAlertUtils();
  const channel = MethodChannel('flutter_platform_alert');
  final calls = <MethodCall>[];
  var platformResult = 'other';
  const cancelButton = CancelDialogButton(text: 'Cancel');
  const deleteButton = DestructiveDialogButton(text: 'Delete');
  const confirmButton = NormalDialogButton(text: 'Confirm');
  const customButton = CustomDialogButton(
    text: 'Custom',
    type: DialogButtonOption.normal,
  );
  const windowTitle = 'title';
  const text = 'message';

  setUp(() {
    calls.clear();
    platformResult = 'other';
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          calls.add(call);
          return platformResult;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  for (final withCustomButton in [false, true]) {
    group('confirmAction with ${withCustomButton ? 3 : 2} buttons', () {
      for (final result in [
        'positive_button',
        'negative_button',
        'neutral_button',
        'other',
      ]) {
        test('returns ${result == 'positive_button'} for $result', () async {
          platformResult = result;

          final confirmed = await alerts.confirmAction(
            title: windowTitle,
            message: text,
            cancelButton: cancelButton,
            confirmButton: confirmButton,
            customButton: withCustomButton ? customButton : null,
          );

          expect(confirmed, result == 'positive_button');
          final call = calls.single;
          expect(call.method, 'showCustomAlert');
          expect(
            call.arguments,
            allOf(
              containsPair('windowTitle', windowTitle),
              containsPair('text', text),
              containsPair('positiveButtonTitle', confirmButton.text),
              containsPair('negativeButtonTitle', cancelButton.text),
              containsPair(
                'neutralButtonTitle',
                withCustomButton ? customButton.text : '',
              ),
            ),
          );
        });
      }
    });
  }

  test('Calls custom alert with confirm delete', () async {
    platformResult = 'negative_button';

    final deleted = await alerts.confirmDelete(
      title: windowTitle,
      message: text,
      cancelButton: cancelButton,
      deleteButton: deleteButton,
      customButton: customButton,
    );

    expect(deleted, isTrue);
    final call = calls.single;
    expect(call.method, 'showCustomAlert');
    expect(
      call.arguments,
      allOf(
        containsPair('positiveButtonTitle', customButton.text),
        containsPair('negativeButtonTitle', deleteButton.text),
        containsPair('neutralButtonTitle', cancelButton.text),
      ),
    );
  });

  for (final (buttons, negativeButton, neutralButton)
      in <(List<DialogButton>, DialogButton?, DialogButton?)>[
        ([confirmButton], null, null),
        ([confirmButton, cancelButton], cancelButton, null),
        (
          [confirmButton, cancelButton, deleteButton],
          deleteButton,
          cancelButton,
        ),
      ]) {
    group('custom with ${buttons.length} buttons', () {
      final expectedButtons = <String, DialogButton?>{
        'positive_button': buttons.first,
        'negative_button': negativeButton,
        'neutral_button': neutralButton,
        'other': null,
      };

      for (final entry in expectedButtons.entries) {
        test('maps ${entry.key} to the correct button', () async {
          platformResult = entry.key;

          final selected = await alerts.custom(
            title: windowTitle,
            message: text,
            buttons: buttons,
          );

          expect(selected, same(entry.value));
          final call = calls.single;
          expect(call.method, 'showCustomAlert');
          expect(
            call.arguments,
            allOf(
              containsPair('windowTitle', windowTitle),
              containsPair('text', text),
              containsPair('positiveButtonTitle', buttons.first.text),
              containsPair('negativeButtonTitle', negativeButton?.text ?? ''),
              containsPair('neutralButtonTitle', neutralButton?.text ?? ''),
            ),
          );
        });
      }
    });
  }
}
