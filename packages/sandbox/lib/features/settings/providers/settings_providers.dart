import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wisecore/wisecore.dart';

import '../settings.dart';

part 'settings_providers.g.dart';

class SettingsProviders {
  static var themeMode = settingsControllerProvider;
  static var profile = userProfileProviderProvider;
  static var notificationSettings = notificationSettingsProvider;
}

@riverpod
class ThemeModeStream extends _$ThemeModeStream {
  @override
  Stream<ThemeMode> build() {
    return ref.watch(SettingsFeature.settingsRepository).watchThemeMode();
  }
}

@riverpod
class SwitchValue extends _$SwitchValue {
  @override
  bool build() {
    return false;
  }

  bool changeValue(bool val) => state = val;
}

@riverpod
class UserProfileProvider extends _$UserProfileProvider with LoadingStreamProvider<Profile> {
  @override
  Stream<Profile> build() {
    refresh();
    return ref.watch(SettingsFeature.settingsRepository).watchProfile();
  }

  @override
  Future<void> onError(Object error, StackTrace stackTrace) async {
    SentryUtil.captureException(
      exception: error,
      stackTrace: stackTrace,
      ref: ref,
    );
  }

  @override
  Future<void> refreshFunction() async {
    await ref.watch(SettingsFeature.settingsRepository).refreshProfile();
  }
}

@riverpod
class NotificationSettings extends _$NotificationSettings {
  @override
  FutureOr<List<NotificationSetting>> build() async {
    return await ref.read(SettingsFeature.settingsRepository).getNotificationSettings();
  }

  void updateSetting(NotificationSettingType type, bool value) {
    var settings = [...?state.value];
    final index = settings.indexWhere((setting) => setting.type == type);

    settings[index] = NotificationSetting(type: type, setting: value);

    state = AsyncValue.data(settings);
  }

  Map<String, List<NotificationSetting>> groupNotificationSettingsBySection() {
    BuildContext? context = ref.read(appRouterServiceProvider).navigatorKey.currentContext;

    if (context == null) {
      return {};
    }

    final settings = state.value ?? [];
    final Map<String, List<NotificationSetting>> groupedSettings = {};

    for (var setting in settings) {
      final section = setting.type.getSection(context);

      if (section != null) {
        groupedSettings.putIfAbsent(section, () => []);
        groupedSettings[section]!.add(setting);
      }
    }

    return groupedSettings;
  }
}
