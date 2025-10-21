/// Enumeration of supported authentication method types.
///
/// Each type corresponds to a different authentication provider or method,
/// and determines the icon and label displayed in the login UI.
enum LoginType {
  /// Sign in with Apple authentication.
  ///
  /// Requires Apple developer account configuration and proper
  /// entitlements in iOS apps.
  apple,

  /// Sign in with Google authentication.
  ///
  /// Requires Google Cloud Console OAuth2 configuration.
  google,

  /// Email/password authentication.
  ///
  /// Standard email and password login through Zitadel.
  email,

  /// Custom identity provider or authentication method.
  ///
  /// Used for organization-specific SSO or custom authentication providers
  /// configured in Zitadel.
  other,
}
