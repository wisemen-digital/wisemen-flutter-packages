import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/flavors.dart';
import 'package:sandbox/generated/l10n.dart';
import 'package:wisecore/wisecore.dart';
import 'package:wisecore/src/dialogs/platform_alert_service.dart';

class ErrorUtils {
  static Future<void> showErrorDialog<T>(
    BuildContext context, {
    required AsyncValue<T> error,
  }) async {
    await ErrorDialog(
      networkErrorString: S.of(context).networkErrorSomethingWentWrong,
      appName: F.appName,
      alertService: FlutterPlatformAlertService(),
    ).showErrorDialog<T>(
      context,
      error,
    );
  }
}
