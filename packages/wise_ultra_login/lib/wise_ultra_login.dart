/// A Zitadel OAuth2-based authentication package for Wisemen Flutter applications.
///
/// This package provides a complete login flow UI and authentication management
/// system with support for multiple authentication methods (Apple, Google, Email,
/// and custom identity providers) in the context of the ULTRA system.
///
/// ## Usage
///
/// 1. Initialize the package with required configurations:
/// ```dart
/// LoginFeature.init(
///   loginLocalizations: MyLoginLocalizations(),
///   loginAssets: MyLoginAssets(),
///   loginFlavors: MyLoginFlavors(),
/// );
/// ```
///
/// 2. Add the LoginScreen to your widget tree:
/// ```dart
/// LoginScreen()
/// ```
///
/// 3. Access login functionality through the LoginController:
/// ```dart
/// ref.read(loginControllerProvider.notifier).login(method);
/// ref.read(loginControllerProvider.notifier).logout(needsConfirmation: true);
/// ```
library wise_ultra_login;

export 'src/features/login/login.dart';
