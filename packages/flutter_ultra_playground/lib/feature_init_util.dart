import 'package:flutter_ultra_playground/database/database.dart';
import 'package:flutter_ultra_playground/router/managers/update_navigation_manager.dart';
import 'package:wise_ultra_login/wise_ultra_login.dart';
import 'package:wise_ultra_settings/wise_ultra_settings.dart';
import 'package:wise_ultra_update/wise_ultra_update.dart';

import 'assets/assets.dart';
import 'flavors.dart';
import 'l10n/feature_localizations.dart';
import 'router/router.dart';

void initFeatures() {
  LoginFeature.init(loginLocalizations: FeatureLocalizations(), loginAssets: FeatureAssets(), loginFlavors: F());
  SettingsFeature.init(
    settingsLocalizations: FeatureLocalizations(),
    settingsAssets: FeatureAssets(),
    settingsNavigationManager: settingsNavigationManagerProvider,
    settingsFlavors: F(),
    settingsDatabase: databaseProvider,
  );
  UpdateFeature.init(
    updateLocalizations: FeatureLocalizations(),
    updateAssets: FeatureAssets(),
    updateNavigationManager: updateNavigationManagerProvider,
  );
}
