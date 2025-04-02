import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisecore/src/dialogs/dialogs.dart';

void main() {
  group('DialogButtonOption', () {
    test('DialogButtonOption.cancel maps to IosButtonStyle.cancel', () {
      expect(DialogButtonOption.cancel.iosStyle, IosButtonStyle.cancel);
    });

    test('DialogButtonOption.destructive maps to IosButtonStyle.destructive',
        () {
      expect(
        DialogButtonOption.destructive.iosStyle,
        IosButtonStyle.destructive,
      );
    });

    test('DialogButtonOption.normal maps to IosButtonStyle.normal', () {
      expect(DialogButtonOption.normal.iosStyle, IosButtonStyle.normal);
    });
  });

  group('DialogButton', () {
    test('CancelDialogButton has correct type', () {
      const button = CancelDialogButton(text: 'Cancel');
      expect(button.text, 'Cancel');
      expect(button.type, DialogButtonOption.cancel);
    });

    test('DestructiveDialogButton has correct type', () {
      const button = DestructiveDialogButton(text: 'Delete');
      expect(button.text, 'Delete');
      expect(button.type, DialogButtonOption.destructive);
    });

    test('NormalDialogButton has correct type', () {
      const button = NormalDialogButton(text: 'OK');
      expect(button.text, 'OK');
      expect(button.type, DialogButtonOption.normal);
    });

    test('CustomDialogButton has correct type and text', () {
      const button = CustomDialogButton(
        text: 'Custom',
        type: DialogButtonOption.destructive,
      );
      expect(button.text, 'Custom');
      expect(button.type, DialogButtonOption.destructive);
    });
  });
}
