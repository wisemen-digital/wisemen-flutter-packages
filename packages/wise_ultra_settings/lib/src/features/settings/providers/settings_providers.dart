import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../settings.dart';

part 'settings_providers.g.dart';

/// Provider that fetches and provides the current app version.
///
/// Returns a formatted string with the version number and build number
/// in the format "version (buildNumber)", e.g., "1.0.0 (42)".
///
/// This provider is used by [BaseSettingsItem.appVersion] to display
/// the app version in the settings screen.
///
/// Example usage:
/// ```dart
/// final version = ref.watch(appVersionProvider);
/// version.when(
///   data: (v) => Text('Version: $v'),
///   loading: () => CircularProgressIndicator(),
///   error: (e, _) => Text('Error: $e'),
/// );
/// ```
@riverpod
class AppVersion extends _$AppVersion {
  @override
  Future<String> build() async {
    final info = await PackageInfo.fromPlatform();

    return '${info.version} (${info.buildNumber})';
  }
}

/// Provider that manages the app's theme mode with persistence.
///
/// Stores the user's theme preference (light, dark, or system) in
/// SharedPreferences and provides it throughout the app. The theme mode
/// persists across app restarts.
///
/// This provider is used by [AppThemeScreen] to display and change
/// the app's theme mode.
///
/// Example usage:
/// ```dart
/// // Read the current theme mode
/// final themeMode = ref.watch(themeModeProvider);
///
/// // Change the theme mode
/// ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.dark);
/// ```
@Riverpod(keepAlive: true)
class ThemeModeNotifier extends _$ThemeModeNotifier {
  static const String _themeModeKey = 'theme_mode';

  @override
  Future<ThemeMode> build() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString(_themeModeKey);

    if (themeModeString == null) {
      return ThemeMode.system;
    }

    return ThemeMode.values.firstWhere(
      (mode) => mode.toString() == themeModeString,
      orElse: () => ThemeMode.system,
    );
  }

  /// Sets and persists the app's theme mode.
  ///
  /// Updates the theme mode in SharedPreferences and notifies all listeners
  /// of the change. The new theme will be applied immediately.
  ///
  /// Parameters:
  /// - [mode]: The new theme mode to apply (light, dark, or system)
  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, mode.toString());
    state = AsyncValue.data(mode);
  }
}

@Riverpod(keepAlive: true)
class CurrentUser extends _$CurrentUser {
  @override
  Stream<User?> build() {
    ref.read(SettingsFeature.repository).refreshCurrentUser();
    return ref.watch(SettingsFeature.repository).watchCurrentUser();
  }
}

@riverpod
class HasEditedUser extends _$HasEditedUser {
  @override
  bool build() {
    return false;
  }

  void changeValue(bool value) {
    state = value;
  }
}

@riverpod
class FirstName extends _$FirstName {
  @override
  String? build() {
    return ref.read(currentUserProvider).value?.firstName;
  }

  String? changeValue(String? val) {
    ref.read(hasEditedUserProvider.notifier).changeValue(true);
    return state = val;
  }
}

@riverpod
class LastName extends _$LastName {
  @override
  String? build() {
    return ref.read(currentUserProvider).value?.lastName;
  }

  String? changeValue(String? val) {
    ref.read(hasEditedUserProvider.notifier).changeValue(true);
    return state = val;
  }
}

@riverpod
class DateOfBirth extends _$DateOfBirth {
  @override
  DateTime? build() {
    return ref.read(currentUserProvider).value?.birthDate;
  }

  DateTime? changeValue(DateTime? val) {
    ref.read(hasEditedUserProvider.notifier).changeValue(true);
    return state = val;
  }
}
