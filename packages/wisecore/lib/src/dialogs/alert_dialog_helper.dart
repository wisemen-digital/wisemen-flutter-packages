import 'package:flutter_platform_alert/flutter_platform_alert.dart';

/// Shows a platform alert dialog.
Future<void> showPlatformAlertDialog({
  required String title,
  required String text,
}) async {
  await FlutterPlatformAlert.showAlert(
    windowTitle: title,
    text: text,
  );
}
