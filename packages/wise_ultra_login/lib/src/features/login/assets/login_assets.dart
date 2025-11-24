/// Interface for providing asset paths used in the login feature.
///
/// Implementations of this interface supply paths to images and icons
/// displayed in the login UI. All assets should be SVG format for icons
/// and standard image formats (PNG, JPG) for the splash image.
///
/// Example implementation:
/// ```dart
/// class AppLoginAssets implements LoginAssets {
///   @override
///   String get splashImage => 'assets/images/login_splash.png';
///
///   @override
///   String get google => 'assets/icons/google.svg';
///
///   @override
///   String get apple => 'assets/icons/apple.svg';
///
///   @override
///   String get email => 'assets/icons/email.svg';
/// }
/// ```
abstract interface class LoginAssets {
  /// Path to the splash screen background image.
  ///
  /// This image is displayed full-screen behind the login options panel.
  /// Can be a local asset path or a network URL.
  ///
  /// Example: 'assets/images/splash.jpg' or 'https://example.com/splash.jpg'
  String get splashImage;

  /// Path to the Google icon SVG asset.
  ///
  /// Used for the 'Sign in with Google' button.
  /// Should be an SVG file for proper scaling and theming.
  ///
  /// Example: 'assets/icons/google.svg'
  String get google;

  /// Path to the Apple icon SVG asset.
  ///
  /// Used for the 'Sign in with Apple' button.
  /// Should be an SVG file for proper scaling and theming.
  ///
  /// Example: 'assets/icons/apple.svg'
  String get apple;

  /// Path to the Email icon SVG asset.
  ///
  /// Used for the email/password login button.
  /// Should be an SVG file for proper scaling and theming.
  ///
  /// Example: 'assets/icons/email.svg'
  String get email;

  /// Path to the avatar image asset.
  String? get avatar;
}
