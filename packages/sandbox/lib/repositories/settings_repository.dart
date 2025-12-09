import 'package:flutter/src/material/app.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sandbox/data/dao/app_settings_dao.dart';
import 'package:sandbox/features/settings/settings.dart';

part 'settings_repository.g.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this.ref);
  final Ref ref;

  @override
  Future<void> toggleThemeMode({required ThemeMode themeMode}) async {
    try {
      await ref.read(appSettingsDaoProvider).updateThemeMode(themeMode);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Stream<ThemeMode> watchThemeMode() {
    return ref.watch(appSettingsDaoProvider).watchAppSettings().map(
          (event) => event?.themeMode ?? ThemeMode.system,
        );
  }
}

@riverpod
SettingsRepositoryImpl settingsRepositoryImpl(Ref ref) {
  return SettingsRepositoryImpl(ref);
}
