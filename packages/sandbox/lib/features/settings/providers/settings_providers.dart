import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../settings.dart';

part 'settings_providers.g.dart';

class SettingsProviders {
  static var themeMode = settingsControllerProvider;
}

@riverpod
class ThemeModeStream extends _$ThemeModeStream {
  @override
  Stream<ThemeMode> build() {
    return ref.watch(SettingsFeature.settingsRepository).watchThemeMode();
  }
}

@riverpod
class SwitchValue extends _$SwitchValue {
  @override
  bool build() {
    return false;
  }

  bool changeValue(bool val) => state = val;
}
