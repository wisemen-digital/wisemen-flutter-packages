import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listenable_stream/listenable_stream.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wisecore/wisecore.dart';

class AppSettingsService {
  AppSettingsService({required this.ref}) {
    _themeController.value = getTheme;
    _devModeController.value = getDevMode;
  }

  final Ref ref;
  late final _sharedPreferences = ref.read(sharedPreferencesProvider);

  static const _themeId = 'theme';
  static const _devModeId = 'devMode';

  static final _supportedThemes = supportedThemes;

  //* Theme
  final ValueNotifier<WiseTheme?> _themeController = ValueNotifier<WiseTheme?>(null);
  Stream<WiseTheme?> get theme => _themeController.toValueStream(replayValue: true);

  Future<void> updateTheme(WiseTheme theme) async {
    await _sharedPreferences.setString(_themeId, theme.identifier);
    _themeController.value = theme;
  }

  WiseTheme? get getTheme {
    final themeString = _sharedPreferences.getString(_themeId);
    if (themeString == null) {
      return null;
    }
    return _supportedThemes.firstWhereOrNull((e) => e.identifier == themeString);
  }

  //* Dev mode
  final ValueNotifier<bool> _devModeController = ValueNotifier<bool>(false);
  Stream<bool> get devMode => _devModeController.toValueStream(replayValue: true);

  Future<void> updateDevMode(bool devMode) async {
    await _sharedPreferences.setBool(_devModeId, devMode);
    _devModeController.value = devMode;
  }

  bool get getDevMode {
    return _sharedPreferences.getBool(_devModeId) ?? false;
  }
}

final appSettingsService = Provider<AppSettingsService>(
  (ref) => AppSettingsService(ref: ref),
);
