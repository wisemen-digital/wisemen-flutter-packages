import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisecore/src/dialogs/platform_alert_service.dart';

import '../extensions/extensions.dart';

/// Helper class to show error dialog
class ErrorDialog {
  /// Constructor [ErrorDialog]
  ErrorDialog(
      {required this.networkErrorString,
      required this.appName,
      required this.alertService});

  /// Fall back error message
  String networkErrorString;

  /// Application name used as dialog title
  String appName;

  /// Platform alert service
  final PlatformAlertService alertService;

  /// Shows error dialog
  Future<void> showErrorDialog<T>(
    BuildContext context,
    AsyncValue<T> asyncValue, {
    String? customErrorMessage,
  }) async {
    final message = getErrorMessage(value: asyncValue);

    if (message != null || customErrorMessage != null) {
      await alertService.showAlert(
        title: appName,
        message: customErrorMessage ?? message!,
        iconStyle: IconStyle.error,
      );
    }
  }

  /// Returns error message from [AsyncValue]
  String? getErrorMessage({required AsyncValue<dynamic> value}) {
    if (!value.hasError || value.isLoading) {
      return null;
    }

    return _getErrorMessageFromObject(error: value.error);
  }

  String _getErrorMessageFromObject({
    Object? error,
  }) {
    String? message;

    if (error is DioException) {
      if (error.response?.data is List<dynamic>) {
        final errors = (error.response?.data as List<dynamic>)
            .map((error) => error as Map<String, dynamic>);
        message = errors.firstOrNull?['message'] as String;
      } else if (error.response?.data is Map<String, dynamic>) {
        if ((error.response?.data as Map<String, dynamic>)
            .containsKey('message')) {
          message = (error.response?.data as Map<String, dynamic>)['message']
              as String;
        } else {
          message = error.message;
        }
      }
    } else if (error is Exception) {
      message = error.toString().replaceAll('Exception: ', '');
    }

    if (message.isNullOrEmpty) {
      message = networkErrorString;
    }

    return message!;
  }
}

/// Extension on [AsyncError] to show dialog
extension AsyncValueExtensions on AsyncError<Object> {
  /// Shows error dialog from AsyncValue of T
  Future<void> showErrorDialog({
    required ErrorDialog dialogShower,
    required BuildContext? context,
  }) async {
    await dialogShower.showErrorDialog(context!, this);
  }
}
