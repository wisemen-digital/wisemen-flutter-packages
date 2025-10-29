/// Interface for providing environment-specific configuration.
///
/// Implement this interface to provide URLs and other configuration that
/// may differ between development, staging, and production environments.
///
/// Example:
/// ```dart
/// class MySettingsFlavors implements SettingsFlavors {
///   @override
///   String get privacyPolicyUrl => 'https://myapp.com/privacy';
///
///   @override
///   String get termsAndConditionsUrl => 'https://myapp.com/terms';
/// }
/// ```
abstract interface class SettingsFlavors {
  /// URL to the privacy policy document.
  ///
  /// This URL is used when the user taps the privacy policy settings item.
  String get privacyPolicyUrl;

  /// URL to the terms and conditions document.
  ///
  /// This URL is used when the user taps the terms and conditions settings item.
  String get termsAndConditionsUrl;
}
