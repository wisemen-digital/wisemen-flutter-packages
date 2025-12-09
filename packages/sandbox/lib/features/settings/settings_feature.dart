import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/repositories/settings_repository.dart';
import 'settings.dart';

class SettingsFeature {
  static late SettingsRepositoryImplProvider settingsRepository;

  static void init({
    required SettingsRepositoryImplProvider repository,
  }) {
    settingsRepository = repository;
  }
}
