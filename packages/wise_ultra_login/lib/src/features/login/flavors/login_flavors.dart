import '../login.dart';

/// Configuration interface for OAuth2 and application-specific settings.
///
/// Implementations of this interface provide the necessary configuration
/// for connecting to the Zitadel authentication server and defining
/// available login methods.
///
/// Example implementation:
/// ```dart
/// class AppLoginFlavors implements LoginFlavors {
///   @override
///   String get authenticationUrl => 'https://auth.example.com';
///
///   @override
///   String get bundleId => 'com.example.app';
///
///   @override
///   String get clientID => 'my-client-id@myproject';
///
///   @override
///   String get organizationID => '123456789';
///
///   @override
///   List<LoginMethod> get loginMethods => [
///     LoginMethod(id: 'google', name: 'Google', type: LoginType.google),
///     LoginMethod(id: 'apple', name: 'Apple', type: LoginType.apple),
///   ];
///
///   @override
///   String get splashImage => 'https://example.com/splash.jpg';
/// }
/// ```
abstract interface class LoginFlavors {
  /// The base URL of the Zitadel authentication server.
  ///
  /// This should be the root URL of your Zitadel instance, without trailing slash.
  /// Example: 'https://auth.example.com'
  String get authenticationUrl;

  /// The application bundle identifier.
  ///
  /// Used for constructing OAuth2 redirect URIs on mobile platforms.
  /// Should match your app's bundle ID (iOS) or application ID (Android).
  /// Example: 'com.example.myapp'
  String get bundleId;

  /// The OAuth2 client ID registered in Zitadel.
  ///
  /// This ID identifies your application to the Zitadel server.
  /// Example: 'my-app-client-id@myproject'
  String get clientID;

  /// The Zitadel organization ID to authenticate against.
  ///
  /// Users will be authenticated within this organization's context.
  /// This can be found in your Zitadel organization settings.
  String get organizationID;

  /// The list of authentication methods to offer users.
  ///
  /// This list determines which login buttons appear in the [LoginScreen].
  /// Each method should correspond to an identity provider configured in Zitadel.
  List<LoginMethod> get loginMethods;

  /// URL of the background image for the login screen splash.
  ///
  /// This image is displayed as a full-screen background behind the
  /// login options panel.
  String get splashImage;
}
