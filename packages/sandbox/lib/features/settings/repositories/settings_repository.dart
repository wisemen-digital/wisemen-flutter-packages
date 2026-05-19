import 'package:flutter/material.dart';

import '../settings.dart';

abstract interface class SettingsRepository {
  Future<void> toggleThemeMode({required ThemeMode themeMode});
  Stream<ThemeMode> watchThemeMode();
  Future<List<NotificationSetting>> getNotificationSettings();
  Stream<Profile> watchProfile();
  Future<void> refreshProfile();
}
