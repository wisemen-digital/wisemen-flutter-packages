import '../settings.dart';

/// Interface for handling navigation and actions from settings items.
///
/// Implement this interface to define navigation logic for each settings item.
/// This is typically implemented as a Riverpod provider to access routing
/// and other services.
///
/// Example:
/// ```dart
/// @Riverpod(keepAlive: true)
/// class MyNavigationManager extends _$MyNavigationManager
///     implements SettingsNavigationManager {
///
///   @override
///   void build() {}
///
///   @override
///   void navigateToPersonalInfo() {
///     // Use your router to navigate
///     ref.read(routerProvider).push(const PersonalInfoRoute());
///   }
///
///   // Implement other methods...
/// }
/// ```
abstract interface class SettingsNavigationManager {
  /// Navigate to the personal information screen.
  ///
  /// Called when the user taps the personal info settings item.
  void navigateToPersonalInfo();

  /// Navigate to the notification settings screen.
  ///
  /// Called when the user taps the notification settings item.
  void navigateToNotifications();

  /// Navigate to the app theme selection screen.
  ///
  /// Called when the user taps the app theme settings item.
  /// The package provides a built-in [AppThemeScreen] you can use.
  void navigateToAppTheme();

  /// Navigate to or open the privacy policy.
  ///
  /// Called when the user taps the privacy policy settings item.
  /// You can navigate to a screen or open the URL from [SettingsFlavors.privacyPolicyUrl].
  void navigateToPrivacyPolicy();

  /// Navigate to or open the terms and conditions.
  ///
  /// Called when the user taps the terms and conditions settings item.
  /// You can navigate to a screen or open the URL from [SettingsFlavors.termsAndConditionsUrl].
  void navigateToTermsAndConditions();

  /// Handle the logout action.
  ///
  /// Called when the user taps the logout button.
  /// Implement your logout logic here (clear tokens, navigate to login, etc.).
  void logout();

  /// Navigate to the app language selection screen.
  ///
  /// Called when the user taps the app language settings item.
  void navigateToAppLanguage();

  /// Pops to the previous route on the stack
  ///
  /// Calles when the user taps done
  void completeSettingsScreen();
}
