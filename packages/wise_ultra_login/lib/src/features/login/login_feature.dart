import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'login.dart';

/// Central configuration class for the wise_ultra_login feature.
///
/// This class acts as a static registry for all required dependencies and
/// configurations needed by the login feature. It must be initialized before
/// using any login functionality.
///
/// Example:
/// ```dart
/// LoginFeature.init(
///   loginLocalizations: MyLoginLocalizations(),
///   loginAssets: MyLoginAssets(),
///   loginFlavors: MyLoginFlavors(),
///   loginRepository: myCustomRepositoryProvider, // Optional
/// );
/// ```
class LoginFeature {
  /// The repository provider for handling authentication operations.
  ///
  /// Defaults to [baseLoginRepositoryProvider] if not provided during initialization.
  static late Provider<LoginRepository> repository;

  /// Localization strings for the login feature UI.
  ///
  /// Must implement [LoginLocalizations] interface.
  static late LoginLocalizations localizations;

  /// Asset paths for images and icons used in the login UI.
  ///
  /// Must implement [LoginAssets] interface.
  static late LoginAssets assets;

  /// OAuth2 and application configuration for the login feature.
  ///
  /// Must implement [LoginFlavors] interface with Zitadel server details,
  /// client ID, and supported login methods.
  static late LoginFlavors flavors;

  /// Initializes the login feature with required configurations.
  ///
  /// This method must be called before using any login functionality,
  /// typically in your app's main() function or during app initialization.
  ///
  /// Parameters:
  /// - [loginRepository]: Optional custom repository implementation. Defaults to [baseLoginRepositoryProvider].
  /// - [loginLocalizations]: Required localization strings for the UI.
  /// - [loginAssets]: Required asset paths for images and icons.
  /// - [loginFlavors]: Required OAuth2 and app configuration.
  ///
  /// Example:
  /// ```dart
  /// void main() {
  ///   LoginFeature.init(
  ///     loginLocalizations: AppLoginLocalizations(),
  ///     loginAssets: AppLoginAssets(),
  ///     loginFlavors: AppLoginFlavors(),
  ///   );
  ///   runApp(MyApp());
  /// }
  /// ```
  static void init({
    required LoginLocalizations loginLocalizations,
    required LoginAssets loginAssets,
    required LoginFlavors loginFlavors,
    Provider<LoginRepository>? loginRepository,
  }) {
    repository = loginRepository ?? baseLoginRepositoryProvider;
    localizations = loginLocalizations;
    assets = loginAssets;
    flavors = loginFlavors;
  }
}
