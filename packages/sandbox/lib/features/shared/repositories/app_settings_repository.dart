import 'package:wise_theming/wise_theming.dart';

abstract interface class AppSettingsRepository {
  Stream<WiseTheme?> get selectedTheme;
  Future<void> updateSelectedTheme(WiseTheme theme);

  Stream<bool> get devMode;
  Future<void> updateDevMode(bool devMode);
}
