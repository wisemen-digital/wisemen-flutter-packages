import 'package:flutter/widgets.dart';

abstract interface class SettingsLocalizations {
  String get logout;

  String personalInfo(BuildContext context);
  String notificationSettings(BuildContext context);
  String appTheme(BuildContext context);
  String appVersion(BuildContext context);
  String termsAndConditions(BuildContext context);
  String privacyPolicy(BuildContext context);
  String profileManagement(BuildContext context);
  String appInfo(BuildContext context);
  String appLanguage(BuildContext context);
  String lightMode(BuildContext context);
  String darkMode(BuildContext context);
  String system(BuildContext context);
  String done(BuildContext context);
}
