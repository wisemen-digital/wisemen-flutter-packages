import 'package:flutter/src/gestures/tap.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/src/core.dart';

import '../settings.dart';

enum BaseSettingsItem implements SettingsItem {
  personalInfo,
  notificationSettings,
  appTheme,
  appVersion,
  privacyPolicy,
  TermsAndConditions,
  logout,
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
      case BaseSettingsItem.TermsAndConditions:
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
      case BaseSettingsItem.TermsAndConditions:
        return ref.read(SettingsFeature.navigationManager).navigateToTermsAndConditions;
      case BaseSettingsItem.logout:
        return ref.read(SettingsFeature.navigationManager).logout;
      case BaseSettingsItem.appTheme:
        return ref.read(SettingsFeature.navigationManager).navigateToAppTheme;
      case BaseSettingsItem.appLanguage:
        return ref.read(SettingsFeature.navigationManager).navigateToAppLanguage;
      case BaseSettingsItem.notificationSettings:
        return ref.read(SettingsFeature.navigationManager).navigateToNotifications;
      default:
        return null;
    }
  }
}
