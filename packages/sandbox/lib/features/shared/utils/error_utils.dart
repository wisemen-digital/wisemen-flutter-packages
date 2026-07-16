import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wisecore/wisecore.dart';

class ErrorUtils with ErrorDialog {
  static final _instance = ErrorUtils();

  static Future<void> showAsyncError(AsyncValue<dynamic> asyncValue) async {
    if (asyncValue.hasError) {
      final error = asyncValue.error;
      final stackTrace = asyncValue.stackTrace;
      await _instance.showErrorDialog(
        title: 'Error',
        message: 'An error occurred: $error\nStack trace: $stackTrace',
      );
    }
  }

  static Future<void> showDialog({required String title, required String message}) async {
    await _instance.showErrorDialog(
      title: title,
      message: message,
    );
  }
}
