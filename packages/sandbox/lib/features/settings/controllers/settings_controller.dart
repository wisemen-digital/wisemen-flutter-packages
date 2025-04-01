import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sandbox/features/settings/settings_feature.dart';

import '../../shared/shared.dart';

part 'settings_controller.g.dart';

@riverpod
class SettingsController extends _$SettingsController {
  @override
  FutureOr<dynamic> build() async {
    listenSelf(
      (previous, next) {
        if (next.hasError && !next.isLoading) {
          ErrorUtils.showAsyncError(next);
        }
      },
    );
    return null;
  }

  Future<void> toggleThemeMode(ThemeMode mode) async {
    state = const AsyncValue.loading();
    try {
      await ref
          .read(SettingsFeature.settingsRepository)
          .toggleThemeMode(themeMode: mode);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}
