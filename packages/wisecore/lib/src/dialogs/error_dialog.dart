import 'package:flutter_platform_alert/flutter_platform_alert.dart';

/// Helper class to show error dialog
mixin class ErrorDialog {
  /// Shows error dialog
  Future<void> showErrorDialog({
    required String title,
    required String message,
  }) async {
    await FlutterPlatformAlert.showAlert(
      windowTitle: title,
      text: message,
      iconStyle: IconStyle.error,
    );
  }
}
