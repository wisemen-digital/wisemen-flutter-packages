import 'dialog_button_option.dart';

/// Base class for dialog buttons
sealed class DialogButton {
  /// Constructor [DialogButton]
  const DialogButton({
    required this.text,
    required this.type,
  });

  /// Text to be displayed on the button
  final String text;

  /// Type of the button
  final DialogButtonOption type;
}

/// Cancel button class, usually pops context without action
class CancelDialogButton extends DialogButton {
  /// Constructor [CancelDialogButton]
  const CancelDialogButton({
    required super.text,
    super.type = DialogButtonOption.cancel,
  });
}

/// Destructive button class, usually deletes
class DestructiveDialogButton extends DialogButton {
  /// Constructor [DestructiveDialogButton]
  const DestructiveDialogButton({
    required super.text,
    super.type = DialogButtonOption.destructive,
  });
}

/// Normal button class
class NormalDialogButton extends DialogButton {
  /// Constructor [NormalDialogButton]
  const NormalDialogButton({
    required super.text,
    super.type = DialogButtonOption.normal,
  });
}

/// Custom button class
class CustomDialogButton extends DialogButton {
  /// Constructor [CustomDialogButton]
  const CustomDialogButton({
    required super.text,
    required super.type,
  });
}
