import 'package:app_settings/app_settings.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise_ultra_login/wise_ultra_login.dart';
import 'package:wise_ultra_settings/wise_ultra_settings.dart';
import 'package:wisecore/wisecore.dart';

import '../app_router.gr.dart';
import '../app_router_service.dart';

class SettingsNavigationManagerImpl implements SettingsNavigationManager {
  final Ref ref;

  StackRouter? get currentRouter => ref.read(appRouterServiceProvider).navigatorKey.currentContext?.router;

  SettingsNavigationManagerImpl({required this.ref});
  @override
  void logout() {
    ref.watch(loginControllerProvider.notifier).logout(needsConfirmation: true);
  }

  @override
  void navigateToAppTheme() {
    currentRouter?.push(const AppThemeScreenRoute());
  }

  @override
  void navigateToNotifications() {
    AppSettings.openAppSettings(type: AppSettingsType.notification, asAnotherTask: true);
  }

  @override
  void navigateToPersonalInfo() {
    currentRouter?.push(const PersonalInfoScreenRoute());
  }

  @override
  void navigateToPrivacyPolicy() {
    WiseLauncher.launchUrl(url: SettingsFeature.flavors.privacyPolicyUrl, onCannotLaunchUrl: () {});
  }

  @override
  void navigateToTermsAndConditions() {
    WiseLauncher.launchUrl(url: SettingsFeature.flavors.termsAndConditionsUrl, onCannotLaunchUrl: () {});
  }

  @override
  void navigateToAppLanguage() {
    AppSettings.openAppSettings(type: AppSettingsType.appLocale, asAnotherTask: true);
  }

  @override
  void completeSettingsScreen() {
    currentRouter?.pop();
  }
}

final settingsNavigationManagerProvider = Provider<SettingsNavigationManager>((ref) => SettingsNavigationManagerImpl(ref: ref));
