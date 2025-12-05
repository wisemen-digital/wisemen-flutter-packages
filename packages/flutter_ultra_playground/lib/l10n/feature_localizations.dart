import 'package:flutter/src/widgets/framework.dart';
import 'package:wise_ultra_login/wise_ultra_login.dart';
import 'package:wise_ultra_settings/wise_ultra_settings.dart';
import 'package:wise_ultra_update/wise_ultra_update.dart';

import '../flavors.dart';
import '../generated/l10n.dart';

class FeatureLocalizations implements LoginLocalizations, SettingsLocalizations, UpdateLocalizations {
  @override
  String get logout => S.current.logout;

  @override
  String get logoutWarning => S.current.logoutWarning;

  @override
  String get cancel => S.current.cancel;

  @override
  String get ok => S.current.ok;

  @override
  String get required => S.current.required;

  @override
  String get areYouSure => S.current.areYouSure;

  @override
  String get no => S.current.no;

  @override
  String get unsavedChangesWarning => S.current.unsavedChangesWarning;

  @override
  String get yes => S.current.yes;

  @override
  String get illDoThisLater => S.current.illDoThisLater;

  @override
  String get installUpdate => S.current.installUpdate;

  @override
  String get newUpdateAvailableSubtitle => S.current.updateAvailableSubtitle;

  @override
  String get newUpdateAvailableTitle => S.current.updateAvailableTitle;

  @override
  String email(BuildContext context) {
    return S.of(context).email;
  }

  @override
  String loginMethod(BuildContext context, String value) {
    return S.of(context).loginMethod(value);
  }

  @override
  String loginSubtitle(BuildContext context) {
    return S.of(context).loginSubtitle;
  }

  @override
  String loginTitle(BuildContext context) {
    return S.of(context).loginTitle(F.appName);
  }

  @override
  String appVersion(BuildContext context) {
    return S.of(context).appVersion;
  }

  @override
  String notificationSettings(BuildContext context) {
    return S.of(context).notificationSettings;
  }

  @override
  String personalInfo(BuildContext context) {
    return S.of(context).personalInfo;
  }

  @override
  String privacyPolicy(BuildContext context) {
    return S.of(context).privacyPolicy;
  }

  @override
  String termsAndConditions(BuildContext context) {
    return S.of(context).termsAndConditions;
  }

  @override
  String appInfo(BuildContext context) {
    return S.of(context).appDetails;
  }

  @override
  String profileManagement(BuildContext context) {
    return S.of(context).profileManagement;
  }

  @override
  String appTheme(BuildContext context) {
    return S.of(context).appTheme;
  }

  @override
  String appLanguage(BuildContext context) {
    return S.of(context).appLanguage;
  }

  @override
  String darkMode(BuildContext context) {
    return S.of(context).darkMode;
  }

  @override
  String lightMode(BuildContext context) {
    return S.of(context).lightMode;
  }

  @override
  String system(BuildContext context) {
    return S.of(context).system;
  }

  @override
  String done(BuildContext context) {
    return S.of(context).done;
  }

  @override
  String firstName(BuildContext context) {
    return S.of(context).firstName;
  }

  @override
  String lastName(BuildContext context) {
    return S.of(context).lastName;
  }

  @override
  String save(BuildContext context) {
    return S.of(context).save;
  }

  @override
  String birthDate(BuildContext context) {
    return S.of(context).birthDate;
  }
}
