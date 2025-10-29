import 'package:flutter/material.dart';

import '../settings.dart';

/// Base settings sections provided by the package.
///
/// These are the default sections that can be used in the settings screen.
/// You can use these as-is or create your own custom sections by implementing
/// [SettingsSection].
///
/// Example:
/// ```dart
/// SettingsScreen(
///   sections: [
///     BaseSettingsSection.profileManagement,
///     BaseSettingsSection.appInfo,
///     BaseSettingsSection.logout,
///   ],
/// )
/// ```
enum BaseSettingsSection implements SettingsSection {
  /// Section containing profile and app customization settings.
  ///
  /// Includes: personal info, notification settings, app theme, and app language.
  profileManagement,

  /// Section containing app information and legal links.
  ///
  /// Includes: app version, terms and conditions, and privacy policy.
  appInfo,

  /// Section containing the logout button.
  ///
  /// This section has no title and contains only the logout item.
  logout;

  @override
  List<SettingsItem> getItems() {
    switch (this) {
      case BaseSettingsSection.profileManagement:
        return [BaseSettingsItem.personalInfo, BaseSettingsItem.notificationSettings, BaseSettingsItem.appTheme, BaseSettingsItem.appLanguage];
      case BaseSettingsSection.appInfo:
        return [BaseSettingsItem.appVersion, BaseSettingsItem.termsAndConditions, BaseSettingsItem.privacyPolicy];
      case BaseSettingsSection.logout:
        return [BaseSettingsItem.logout];
    }
  }

  @override
  String getTitle(BuildContext context) {
    switch (this) {
      case BaseSettingsSection.profileManagement:
        return SettingsFeature.localizations.profileManagement(context);
      case BaseSettingsSection.appInfo:
        return SettingsFeature.localizations.appInfo(context);
      case BaseSettingsSection.logout:
        return '';
    }
  }
}
