// ignore_for_file: inference_failure_on_function_invocation

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../update.dart';

/// Controller for managing update dialogs and checking for app updates.
class UpdateController {
  /// Checks if an update is needed and shows the update dialog if necessary.
  ///
  /// This method will:
  /// - Check for available updates using the configured repository
  /// - Show the update dialog if an update is available
  /// - Skip showing optional updates if already shown in the current session
  /// - Always show required updates regardless of session state
  static Future<void> showUpdateDialogIfNeeded(BuildContext context, WidgetRef ref) async {
    final updateStatus = await ref.read(UpdateFeature.repository).checkNeedsUpdate();

    if (!updateStatus.$1) {
      return;
    }

    final isRequired = updateStatus.$2;

    if (!isRequired && ref.read(hasShownUpdateProvider)) {
      return;
    }

    ref.read(hasShownUpdateProvider.notifier).changeValue(true);

    await showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) {
        return UpdateWidget(isRequired: isRequired);
      },
      barrierDismissible: false,
    );
  }
}
