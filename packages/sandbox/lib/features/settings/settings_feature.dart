import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'settings.dart';

class SettingsFeature {
  static late Provider<SettingsRepository> settingsRepository;

  static void init({
    required Provider<SettingsRepository> repository,
  }) {
    settingsRepository = repository;
  }
}
