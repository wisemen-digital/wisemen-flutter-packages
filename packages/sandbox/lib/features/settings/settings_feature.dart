import 'settings.dart';

class SettingsFeature {
  // ignore: strict_raw_type
  static late dynamic settingsRepository;

  static void init({
    required dynamic repository,
  }) {
    settingsRepository = repository;
  }
}
