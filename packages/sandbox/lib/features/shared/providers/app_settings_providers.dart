import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wise_theming/wise_theming.dart';

import '../shared_feature.dart';

part 'app_settings_providers.g.dart';

class AppSettingsProviders {
  static final themeMode = themeModeProviderProvider;
}

@riverpod
class ThemeModeProvider extends _$ThemeModeProvider {
  @override
  Stream<WiseTheme?> build() {
    return ref.watch(SharedFeature.appSettingsRepository).selectedTheme;
  }
}
