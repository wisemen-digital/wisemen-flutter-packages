import 'package:riverpod/misc.dart';

import 'settings.dart';

class SettingsFeature {
  static late ProviderBase<SettingsRepository> settingsRepository;

  static void init({
    required ProviderBase<SettingsRepository> repository,
  }) {
    settingsRepository = repository;
  }
}
