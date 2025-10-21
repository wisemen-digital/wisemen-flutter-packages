import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_providers.g.dart';

@riverpod
class AppVersion extends _$AppVersion {
  @override
  Future<String> build() async {
    PackageInfo info = await PackageInfo.fromPlatform();

    return '${info.version} (${info.buildNumber})';
  }
}

@Riverpod(keepAlive: true)
class ThemeModeNotifier extends _$ThemeModeNotifier {
  static const String _themeModeKey = 'theme_mode';

  @override
  Future<ThemeMode> build() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString(_themeModeKey);

    if (themeModeString == null) {
      return ThemeMode.system;
    }

    return ThemeMode.values.firstWhere(
      (mode) => mode.toString() == themeModeString,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, mode.toString());
    state = AsyncValue.data(mode);
  }
}
