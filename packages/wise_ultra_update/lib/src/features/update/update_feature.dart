import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_ultra_update/wise_ultra_update.dart';

class UpdateFeature {
  static late UpdateLocalizations localizations;
  static late UpdateAssets assets;
  static late Provider<UpdateNavigationManager> navigationManager;
  static late Provider<UpdateRepository> repository;

  static void init({
    required UpdateLocalizations updateLocalizations,
    required UpdateAssets updateAssets,
    required Provider<UpdateNavigationManager> updateNavigationManager,
    Provider<UpdateRepository>? updateRepository,
  }) {
    localizations = updateLocalizations;
    assets = updateAssets;
    navigationManager = updateNavigationManager;
    repository = updateRepository ?? baseUpdateRepositoryProvider;
  }
}
