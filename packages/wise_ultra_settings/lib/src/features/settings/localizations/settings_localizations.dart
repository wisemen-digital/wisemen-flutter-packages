import 'package:flutter/widgets.dart';

/// Interface for providing localized strings used in the settings feature.
///
/// Implement this interface to provide translations for all settings-related
/// text in your app. Pass your implementation to SettingsFeature.init
///
/// Example:
/// ```dart
/// class MySettingsLocalizations implements SettingsLocalizations {
///   @override
///   String get logout => 'Logout';
///
///   @override
///   String personalInfo(BuildContext context) =>
///     AppLocalizations.of(context).personalInfo;
/// }
/// ```
abstract interface class SettingsLocalizations {
  /// Text for the logout button.
  String get logout;

  String get ok;

  String get required;

  String get cancel;

  String get areYouSure;

  String get unsavedChangesWarning;

  String get yes;

  String get no;

  /// Text for the personal information settings item.
  String personalInfo(BuildContext context);

  /// Text for the notification settings item.
  String notificationSettings(BuildContext context);

  /// Text for the app theme settings item.
  String appTheme(BuildContext context);

  /// Text for the app version settings item.
  String appVersion(BuildContext context);

  /// Text for the terms and conditions settings item.
  String termsAndConditions(BuildContext context);

  /// Text for the privacy policy settings item.
  String privacyPolicy(BuildContext context);

  /// Text for the profile management section header.
  String profileManagement(BuildContext context);

  /// Text for the app info section header.
  String appInfo(BuildContext context);

  /// Text for the app language settings item.
  String appLanguage(BuildContext context);

  /// Text for the light mode theme option.
  String lightMode(BuildContext context);

  /// Text for the dark mode theme option.
  String darkMode(BuildContext context);

  /// Text for the system theme option (follows device settings).
  String system(BuildContext context);

  /// Text for the done button in the app bar.
  String done(BuildContext context);

  String firstName(BuildContext context);

  String lastName(BuildContext context);

  String save(BuildContext context);

  String birthDate(BuildContext context);
}
