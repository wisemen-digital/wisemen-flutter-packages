import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'settings.dart';

class SettingsFeature {
  static late AutoDisposeProvider<SettingsRepository> settingsRepository;

  static void init({
    required AutoDisposeProvider<SettingsRepository> repository,
  }) {
    settingsRepository = repository;
  }
}
