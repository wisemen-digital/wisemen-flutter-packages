import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'login.dart';

class LoginFeature {
  static late Provider<LoginRepository> repository;
  static late LoginLocalizations localizations;
  static late LoginAssets assets;
  static late LoginFlavors flavors;

  static void init({
    Provider<LoginRepository>? loginRepository,
    required LoginLocalizations loginLocalizations,
    required LoginAssets loginAssets,
    required LoginFlavors loginFlavors,
  }) {
    repository = loginRepository ?? baseLoginRepositoryProvider;
    localizations = loginLocalizations;
    assets = loginAssets;
    flavors = loginFlavors;
  }
}
