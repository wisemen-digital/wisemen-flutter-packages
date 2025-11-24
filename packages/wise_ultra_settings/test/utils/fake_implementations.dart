import 'package:flutter/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wise_ultra_settings/wise_ultra_settings.dart';

class FakeSettingsLocalizations implements SettingsLocalizations {
  @override
  String personalInfo(BuildContext context) => 'Personal Info';

  @override
  String notificationSettings(BuildContext context) => 'Notification Settings';

  @override
  String appTheme(BuildContext context) => 'App Theme';

  @override
  String appVersion(BuildContext context) => 'App Version';

  @override
  String privacyPolicy(BuildContext context) => 'Privacy Policy';

  @override
  String termsAndConditions(BuildContext context) => 'Terms and Conditions';

  @override
  String appLanguage(BuildContext context) => 'App Language';

  @override
  String get logout => 'Logout';

  @override
  String profileManagement(BuildContext context) => 'Profile Management';

  @override
  String appInfo(BuildContext context) => 'App Info';

  @override
  String save(BuildContext context) => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String firstName(BuildContext context) => 'First Name';

  @override
  String lastName(BuildContext context) => 'Last Name';

  @override
  String birthDate(BuildContext context) => 'Birth Date';

  @override
  String lightMode(BuildContext context) => 'Light';

  @override
  String darkMode(BuildContext context) => 'Dark';

  @override
  String system(BuildContext context) => 'System';

  @override
  String done(BuildContext context) => 'Done';

  @override
  String get ok => 'OK';

  @override
  String get required => 'Required';

  @override
  String get areYouSure => 'Are you sure?';

  @override
  String get unsavedChangesWarning => 'You have unsaved changes';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';
}

class FakeSettingsAssets implements SettingsAssets {
  @override
  String get chevronRight => 'test/fixtures/placeholder.png';
}

class FakeSettingsFlavors implements SettingsFlavors {
  @override
  String get privacyPolicyUrl => 'https://example.com/privacy';

  @override
  String get termsAndConditionsUrl => 'https://example.com/terms';
}

class FakeSettingsNavigationManager implements SettingsNavigationManager {
  @override
  void logout() {}

  @override
  void navigateToAppLanguage() {}

  @override
  void navigateToAppTheme() {}

  @override
  void navigateToNotifications() {}

  @override
  void navigateToPersonalInfo() {}

  @override
  void navigateToPrivacyPolicy() {}

  @override
  void navigateToTermsAndConditions() {}

  @override
  void completeSettingsScreen() {}
}

class MockSettingsNavigationManager extends Mock
    implements SettingsNavigationManager {}

class MockSettingsRepository extends Mock implements SettingsRepository {}

class MockUserService extends Mock implements UserService {}

class MockUserDao extends Mock implements UserDao {}
