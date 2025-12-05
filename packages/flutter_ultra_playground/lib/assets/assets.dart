import 'package:wise_ultra_login/wise_ultra_login.dart';
import 'package:wise_ultra_settings/wise_ultra_settings.dart';
import 'package:wise_ultra_update/wise_ultra_update.dart';

import '../flavors.dart';

abstract class AppAssets {
  // Splash Screen
  static const splashImage = 'assets/images/splash_logo.png';
  static const apple = 'assets/icons/apple.svg';
  static const google = 'assets/icons/google.svg';
  static const email = 'assets/icons/email.svg';
  static const chevronRight = 'assets/icons/chevron_right.svg';
}

class FeatureAssets implements LoginAssets, SettingsAssets, UpdateAssets {
  @override
  String get apple => AppAssets.apple;

  @override
  String get google => AppAssets.google;

  @override
  String get email => AppAssets.email;

  @override
  String get splashImage => AppAssets.splashImage;

  @override
  String get chevronRight => AppAssets.chevronRight;

  @override
  String? get avatar => F.config?.localAvatar;
}
