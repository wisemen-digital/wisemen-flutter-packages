import 'package:flutter_platform_alert/flutter_platform_alert.dart';

/// Service to show platform alerts
mixin PlatformAlertService {
  /// Shows an alert dialog
  Future<void> showAlert({
    /// Title of the alert
    required String title,

    /// Message of the alert
    required String message,

    /// Icon style of the alert
    required IconStyle iconStyle,
  });
}

/// Flutter implementation of [PlatformAlertService]
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
