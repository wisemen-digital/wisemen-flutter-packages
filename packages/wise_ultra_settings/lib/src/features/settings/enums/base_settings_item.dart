// ignore_for_file: no_default_cases

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings.dart';

/// Base settings items provided by the package.
///
/// These are the default settings items that handle common app settings.
/// Each item's behavior (navigation, display) is configured through the
/// implementations you provide to [SettingsFeature.init].
///
/// You can use these items in your custom sections or create your own
/// by implementing [SettingsItem].
enum BaseSettingsItem implements SettingsItem {
  /// Navigate to personal information screen.
  ///
  /// Shows user profile details like name, email, etc.
  personalInfo,

  /// Navigate to notification settings screen.
  ///
  /// Allows users to configure push notification preferences.
  notificationSettings,

  /// Navigate to app theme selection screen.
  ///
  /// Allows users to choose between light, dark, or system theme.
  /// The package provides a built-in [AppThemeScreen] for this.
  appTheme,

  /// Display the current app version.
  ///
  /// This is a read-only item that shows the app version from package_info_plus.
  appVersion,

  /// Navigate to privacy policy.
  ///
  /// Opens the URL configured in [SettingsFlavors.privacyPolicyUrl].
  privacyPolicy,

  /// Navigate to terms and conditions.
  ///
  /// Opens the URL configured in [SettingsFlavors.termsAndConditionsUrl].
  termsAndConditions,

  /// Trigger logout action.
  ///
  /// Calls [SettingsNavigationManager.logout] to handle the logout flow.
  logout,

  /// Navigate to app language selection screen.
  ///
  /// Allows users to change the app's display language.
  appLanguage;

  @override
  String getTitle(BuildContext context) {
    switch (this) {
      case BaseSettingsItem.personalInfo:
        return SettingsFeature.localizations.personalInfo(context);
      case BaseSettingsItem.notificationSettings:
        return SettingsFeature.localizations.notificationSettings(context);
      case BaseSettingsItem.appTheme:
        return SettingsFeature.localizations.appTheme(context);
      case BaseSettingsItem.appVersion:
        return SettingsFeature.localizations.appVersion(context);
      case BaseSettingsItem.privacyPolicy:
        return SettingsFeature.localizations.privacyPolicy(context);
      case BaseSettingsItem.termsAndConditions:
        return SettingsFeature.localizations.termsAndConditions(context);
      case BaseSettingsItem.appLanguage:
        return SettingsFeature.localizations.appLanguage(context);
      case BaseSettingsItem.logout:
        return SettingsFeature.localizations.logout;
    }
  }

  @override
  String? getTrailingText(WidgetRef ref) {
    switch (this) {
      case BaseSettingsItem.appVersion:
        return ref.watch(appVersionProvider).value;
      default:
        return null;
    }
  }

  @override
  Widget? getTrailingWidget(BuildContext context) {
    return null;
  }

  @override
  GestureTapCallback? onTap(WidgetRef ref) {
    switch (this) {
      case BaseSettingsItem.privacyPolicy:
        return ref.read(SettingsFeature.navigationManager).navigateToPrivacyPolicy;
      case BaseSettingsItem.termsAndConditions:
        return ref.read(SettingsFeature.navigationManager).navigateToTermsAndConditions;
      case BaseSettingsItem.logout:
        return ref.read(SettingsFeature.navigationManager).logout;
      case BaseSettingsItem.appTheme:
        return ref.read(SettingsFeature.navigationManager).navigateToAppTheme;
      case BaseSettingsItem.appLanguage:
        return ref.read(SettingsFeature.navigationManager).navigateToAppLanguage;
      case BaseSettingsItem.notificationSettings:
        return ref.read(SettingsFeature.navigationManager).navigateToNotifications;
      case BaseSettingsItem.personalInfo:
        return ref.read(SettingsFeature.navigationManager).navigateToPersonalInfo;
      default:
        return null;
    }
  }
}
