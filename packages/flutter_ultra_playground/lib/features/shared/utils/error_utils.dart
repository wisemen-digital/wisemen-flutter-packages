import 'package:flutter_ultra_playground/generated/l10n.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisecore/wisecore.dart';

class ErrorUtils {
  static final _ErrorUtilsImpl _instance = _ErrorUtilsImpl();

  static Future<void> showAsyncError(AsyncValue value) {
    return _instance.showErrorDialog(title: S.current.appName, message: _errorParser(value));
  }

  static String _errorParser(AsyncValue value) {
    return value.error.toString();
  }

  static void showDialog({required String title, required String message}) {
    _instance.showErrorDialog(title: title, message: message);
  }
}

class _ErrorUtilsImpl with ErrorDialog {}
