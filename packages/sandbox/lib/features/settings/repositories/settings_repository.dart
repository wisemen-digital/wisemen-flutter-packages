import 'package:flutter/material.dart';

abstract interface class SettingsRepository {
  Future<void> toggleThemeMode({required ThemeMode themeMode});
  Stream<ThemeMode> watchThemeMode();
}
