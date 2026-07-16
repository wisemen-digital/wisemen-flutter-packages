import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shared.dart';

class SharedFeature {
  static late Provider<AppSettingsRepository> appSettingsRepository;

  static void init({
    required Provider<AppSettingsRepository> settingsRepository,
  }) {
    appSettingsRepository = settingsRepository;
  }
}
