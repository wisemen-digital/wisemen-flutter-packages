import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:wisecore/src/dialogs/dialogs.dart';

/// Helper class to show error dialog
mixin class AlertDialog {
  /// Show confirm action dialog
  /// Uses overridden confirm and cancel as fall back, guidelines specify
  /// leaving a meaningful message.
  /// Returns true if user confirms action, false otherwise.
  Future<bool> confirmAction({
    required String title,
    required String message,
    required CancelDialogButton cancelButton,
    required NormalDialogButton confirmButton,
    CustomDialogButton? customButton,
  }) async {
    final option = await FlutterPlatformAlert.showCustomAlert(
      windowTitle: title,
      text: message,
      positiveButtonTitle: confirmButton.text,
      neutralButtonTitle: cancelButton.text,
      negativeButtonTitle: customButton?.text,
      options: PlatformAlertOptions(
        ios: IosAlertOptions(
          positiveButtonStyle: confirmButton.type.iosStyle,
          neutralButtonStyle: cancelButton.type.iosStyle,
          negativeButtonStyle: customButton?.type.iosStyle,
        ),
      ),
      iconStyle: IconStyle.question,
    );
    return option == CustomButton.positiveButton;
  }

  /// Show delete action dialog
  /// Guidelines specify leaving a meaningful message.
  /// Returns true if user confirms action, false otherwise.
  Future<bool> confirmDelete({
    required String title,
    required String message,
    required DestructiveDialogButton deleteButton,
    required CancelDialogButton cancelButton,
    CustomDialogButton? customButton,
  }) async {
    final option = await FlutterPlatformAlert.showCustomAlert(
      windowTitle: title,
      text: message,
      negativeButtonTitle: deleteButton.text,
      neutralButtonTitle: cancelButton.text,
      positiveButtonTitle: customButton?.text,
      options: PlatformAlertOptions(
        ios: IosAlertOptions(
          negativeButtonStyle: deleteButton.type.iosStyle,
          neutralButtonStyle: cancelButton.type.iosStyle,
          positiveButtonStyle: customButton?.type.iosStyle,
        ),
      ),
    );
    return option == CustomButton.negativeButton;
  }

  /// Show custom action dialog
  /// Maximum 3 buttons
  Future<DialogButton?> custom({
    required String title,
    required String message,
    required List<DialogButton> buttons,
  }) async {
    assert(
      buttons.isNotEmpty && buttons.length <= 3,
      'Buttons length must be between 1 and 3',
    );
    final firstButton = buttons.first;
    final secondButton = buttons.length > 1 ? buttons[1] : null;
    final thirdButton = buttons.length > 2 ? buttons[2] : null;
    final option = await FlutterPlatformAlert.showCustomAlert(
      windowTitle: title,
      text: message,
      positiveButtonTitle: firstButton.text,
      neutralButtonTitle: secondButton?.text,
      negativeButtonTitle: thirdButton?.text,
      options: PlatformAlertOptions(
        ios: IosAlertOptions(
          positiveButtonStyle: firstButton.type.iosStyle,
          neutralButtonStyle: secondButton?.type.iosStyle,
          negativeButtonStyle: thirdButton?.type.iosStyle,
        ),
      ),
    );
    switch (option) {
      case CustomButton.positiveButton:
        return firstButton;
      case CustomButton.negativeButton:
        return secondButton;
      case CustomButton.neutralButton:
        return thirdButton;
      case CustomButton.other:
        return null;
    }
  }
}
