import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_ultra_update/wise_ultra_update.dart';

/// Main entry point for initializing and configuring the update feature.
class UpdateFeature {
  /// Localizations provider for update UI strings.
  static late UpdateLocalizations localizations;
  
  /// Assets provider for update UI resources.
  static late UpdateAssets assets;
  
  /// Navigation manager provider for handling update actions.
  static late Provider<UpdateNavigationManager> navigationManager;
  
  /// Repository provider for checking update availability.
  static late Provider<UpdateRepository> repository;

  /// Initializes the update feature with required dependencies.
  ///
  /// Must be called before using any update functionality, typically in main().
  ///
  /// Parameters:
  /// - [updateLocalizations]: Implementation of localized strings
  /// - [updateAssets]: Implementation of UI assets
  /// - [updateNavigationManager]: Provider for navigation handling
  /// - [updateRepository]: Optional custom repository (defaults to [baseUpdateRepositoryProvider])
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
