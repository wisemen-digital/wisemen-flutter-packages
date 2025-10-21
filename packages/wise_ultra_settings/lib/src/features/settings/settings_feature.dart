import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'settings.dart';


class SettingsFeature {
  static late Provider<SettingsRepository>? repository;
  static late SettingsLocalizations localizations;
  static late SettingsAssets assets;
  static late Provider<SettingsNavigationManager> navigationManager;
  static late SettingsFlavors flavors;

  static void init({
    required SettingsLocalizations settingsLocalizations, required SettingsAssets settingsAssets, required Provider<SettingsNavigationManager> settingsNavigationManager, required SettingsFlavors settingsFlavors, Provider<SettingsRepository>? settingsRepository,
  }) {
    repository = settingsRepository;
    localizations = settingsLocalizations;
    assets = settingsAssets;
    navigationManager = settingsNavigationManager;
    flavors = settingsFlavors;
  }
}
