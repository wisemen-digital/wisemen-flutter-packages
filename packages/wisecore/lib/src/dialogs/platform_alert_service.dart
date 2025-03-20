import 'package:flutter_platform_alert/flutter_platform_alert.dart';

abstract class PlatformAlertService {
  Future<void> showAlert({
    required String title,
    required String message,
    required IconStyle iconStyle,
  });
}

class FlutterPlatformAlertService implements PlatformAlertService {
  @override
  Future<void> showAlert({
    required String title,
    required String message,
    required IconStyle iconStyle,
  }) {
    return FlutterPlatformAlert.showAlert(
      windowTitle: title,
      text: message,
      iconStyle: iconStyle,
    );
  }
}