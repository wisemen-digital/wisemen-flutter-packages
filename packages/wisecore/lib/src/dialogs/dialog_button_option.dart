import 'package:flutter_platform_alert/flutter_platform_alert.dart';

/// Dialog button options
enum DialogButtonOption {
  /// Cancel button
  cancel,

  /// Destructive button
  destructive,

  /// Normal button
  normal;

  /// Converts the [DialogButtonOption] to the corresponding [IosButtonStyle].
  /// This abstracts this enum from the flutter_platform_alert package.
  IosButtonStyle get iosStyle {
    switch (this) {
      case DialogButtonOption.cancel:
        return IosButtonStyle.cancel;
      case DialogButtonOption.destructive:
        return IosButtonStyle.destructive;
      case DialogButtonOption.normal:
        return IosButtonStyle.normal;
    }
  }
}
