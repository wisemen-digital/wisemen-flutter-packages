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
      negativeButtonTitle: cancelButton.text,
      neutralButtonTitle: customButton?.text,
      options: PlatformAlertOptions(
        ios: IosAlertOptions(
          positiveButtonStyle: confirmButton.type.iosStyle,
          negativeButtonStyle: cancelButton.type.iosStyle,
          neutralButtonStyle: customButton?.type.iosStyle,
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
    // Work around the Android plugin's neutral-button guard for two buttons.
    final negativeButton = buttons.length > 1 ? buttons.last : null;
    final neutralButton = buttons.length > 2 ? buttons[1] : null;
    final option = await FlutterPlatformAlert.showCustomAlert(
      windowTitle: title,
      text: message,
      positiveButtonTitle: firstButton.text,
      neutralButtonTitle: neutralButton?.text,
      negativeButtonTitle: negativeButton?.text,
      options: PlatformAlertOptions(
        ios: IosAlertOptions(
          positiveButtonStyle: firstButton.type.iosStyle,
          neutralButtonStyle: neutralButton?.type.iosStyle,
          negativeButtonStyle: negativeButton?.type.iosStyle,
        ),
      ),
    );
    switch (option) {
      case CustomButton.positiveButton:
        return firstButton;
      case CustomButton.neutralButton:
        return neutralButton;
      case CustomButton.negativeButton:
        return negativeButton;
      case CustomButton.other:
        return null;
    }
  }
}
