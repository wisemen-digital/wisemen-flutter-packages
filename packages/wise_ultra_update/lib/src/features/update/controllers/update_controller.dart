// ignore_for_file: inference_failure_on_function_invocation

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../update.dart';

class UpdateController {
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
      context: context,
      builder: (context) {
        return UpdateWidget(isRequired: isRequired);
      },
      barrierDismissible: false,
    );
  }
}
