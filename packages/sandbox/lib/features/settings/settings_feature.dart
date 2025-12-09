import 'package:sandbox/repositories/settings_repository.dart';

class SettingsFeature {
  static late SettingsRepositoryImplProvider settingsRepository;

  static void init({
    required SettingsRepositoryImplProvider repository,
  }) {
    settingsRepository = repository;
  }
}
