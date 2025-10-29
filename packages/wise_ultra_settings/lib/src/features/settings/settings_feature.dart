import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise_ultra_settings/src/repository/base_settings_repository.dart';
import 'settings.dart';

/// Central configuration class for the wise_ultra_settings package.
///
/// This class must be initialized before using any settings-related features.
/// It holds all the required dependencies including localizations, assets,
/// navigation manager, flavors, and an optional repository.
///
/// Example:
/// ```dart
/// SettingsFeature.init(
///   settingsLocalizations: YourLocalizationsImpl(),
///   settingsAssets: YourAssetsImpl(),
///   settingsNavigationManager: yourNavigationManagerProvider,
///   settingsFlavors: YourFlavorsImpl(),
///   settingsRepository: yourRepositoryProvider, // Optional
/// );
/// ```
class SettingsFeature {
  /// Optional repository provider for fetching user data.
  ///
  /// If not provided, user-related features will need to be handled externally.
  static late Provider<SettingsRepository> repository;

  /// Localizations for all settings-related strings.
  ///
  /// Must implement [SettingsLocalizations] interface.
  static late SettingsLocalizations localizations;

  /// Asset paths used in the settings UI.
  ///
  /// Must implement [SettingsAssets] interface.
  static late SettingsAssets assets;

  /// Navigation manager for handling settings item actions.
  ///
  /// Provides navigation callbacks for all base settings items.
  static late Provider<SettingsNavigationManager> navigationManager;

  /// Environment-specific configuration like URLs for legal documents.
  ///
  /// Must implement [SettingsFlavors] interface.
  static late SettingsFlavors flavors;

  static late Provider<GeneratedDatabase> database;

  /// Initializes the settings feature with required dependencies.
  ///
  /// This method must be called before using any settings screens or widgets.
  ///
  /// Parameters:
  /// - [settingsLocalizations]: Implementation of [SettingsLocalizations] for UI text
  /// - [settingsAssets]: Implementation of [SettingsAssets] for asset paths
  /// - [settingsNavigationManager]: Provider for [SettingsNavigationManager] implementation
  /// - [settingsFlavors]: Implementation of [SettingsFlavors] for environment config
  /// - [settingsRepository]: Optional provider for [SettingsRepository] implementation
  static void init({
    required SettingsLocalizations settingsLocalizations,
    required SettingsAssets settingsAssets,
    required Provider<SettingsNavigationManager> settingsNavigationManager,
    required SettingsFlavors settingsFlavors,
    required Provider<GeneratedDatabase> settingsDatabase,
    Provider<SettingsRepository>? settingsRepository,
  }) {
    repository = settingsRepository ?? baseSettingsRepositoryProvider;
    localizations = settingsLocalizations;
    assets = settingsAssets;
    navigationManager = settingsNavigationManager;
    flavors = settingsFlavors;
    database = settingsDatabase;
  }
}
