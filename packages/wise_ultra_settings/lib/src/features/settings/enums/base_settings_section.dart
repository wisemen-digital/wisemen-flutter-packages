import 'package:flutter/src/widgets/framework.dart';

import '../settings.dart';

enum BaseSettingsSection implements SettingsSection {
  profileManagement,
  appInfo,
  logout;

  @override
  List<SettingsItem> getItems() {
    switch (this) {
      case BaseSettingsSection.profileManagement:
        return [BaseSettingsItem.personalInfo, BaseSettingsItem.notificationSettings, BaseSettingsItem.appTheme, BaseSettingsItem.appLanguage];
      case BaseSettingsSection.appInfo:
        return [BaseSettingsItem.appVersion, BaseSettingsItem.TermsAndConditions, BaseSettingsItem.privacyPolicy];
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
