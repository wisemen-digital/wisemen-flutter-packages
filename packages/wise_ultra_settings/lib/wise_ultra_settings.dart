/// A customizable settings screen package for Flutter apps using Wisemen backends.
///
/// This library provides a ready-to-use settings interface with profile management,
/// app theme selection, version information, and navigation to legal documents.
///
/// ## Quick Start
///
/// 1. Initialize the package in your app's main function:
///
/// ```dart
/// void main() {
///   SettingsFeature.init(
///     settingsLocalizations: YourLocalizationsImpl(),
///     settingsAssets: YourAssetsImpl(),
///     settingsNavigationManager: yourNavigationManagerProvider,
///     settingsFlavors: YourFlavorsImpl(),
///   );
///   runApp(MyApp());
/// }
/// ```
///
/// 2. Add the settings screen to your routing:
///
/// ```dart
/// AutoRoute(page: SettingsRoute.page),
/// ```
///
/// 3. Navigate to the settings screen:
///
/// ```dart
/// context.router.push(const SettingsRoute());
/// ```
///
/// ## Key Components
///
/// - [SettingsFeature]: Central configuration class that must be initialized
/// - [SettingsScreen]: Main settings screen widget
/// - [SettingsSection]: Interface for defining custom settings sections
/// - [SettingsItem]: Interface for defining custom settings items
/// - [BaseSettingsSection]: Pre-built settings sections
/// - [BaseSettingsItem]: Pre-built settings items
///
/// ## Customization
///
/// Create custom sections and items by implementing the [SettingsSection]
/// and [SettingsItem] interfaces with enums.
library wise_ultra_settings;

import 'wise_ultra_settings.dart';

export 'src/database/database.dart';
export 'src/features/settings/settings.dart';
export 'src/network/network.dart';
export 'src/repository/repository.dart';
