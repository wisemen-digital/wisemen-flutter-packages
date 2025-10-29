// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
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

@ProviderFor(AppVersion)
const appVersionProvider = AppVersionProvider._();

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
final class AppVersionProvider
    extends $AsyncNotifierProvider<AppVersion, String> {
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
  const AppVersionProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appVersionProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appVersionHash();

  @$internal
  @override
  AppVersion create() => AppVersion();
}

String _$appVersionHash() => r'c56158d93a85054a37cf336d0b010128cda7af95';

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

abstract class _$AppVersion extends $AsyncNotifier<String> {
  FutureOr<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String>, String>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<String>, String>,
        AsyncValue<String>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
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

@ProviderFor(ThemeModeNotifier)
const themeModeProvider = ThemeModeNotifierProvider._();

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
final class ThemeModeNotifierProvider
    extends $AsyncNotifierProvider<ThemeModeNotifier, ThemeMode> {
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
  const ThemeModeNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'themeModeProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$themeModeNotifierHash();

  @$internal
  @override
  ThemeModeNotifier create() => ThemeModeNotifier();
}

String _$themeModeNotifierHash() => r'140c83375d30446cdc821aec4cdc9c2a5af93f3d';

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

abstract class _$ThemeModeNotifier extends $AsyncNotifier<ThemeMode> {
  FutureOr<ThemeMode> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ThemeMode>, ThemeMode>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<ThemeMode>, ThemeMode>,
        AsyncValue<ThemeMode>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(CurrentUser)
const currentUserProvider = CurrentUserProvider._();

final class CurrentUserProvider
    extends $StreamNotifierProvider<CurrentUser, User?> {
  const CurrentUserProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'currentUserProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  CurrentUser create() => CurrentUser();
}

String _$currentUserHash() => r'8a37126d2ec5ba62c1b8c5baae77efb30fe429ad';

abstract class _$CurrentUser extends $StreamNotifier<User?> {
  Stream<User?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<User?>, User?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<User?>, User?>,
        AsyncValue<User?>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(HasEditedUser)
const hasEditedUserProvider = HasEditedUserProvider._();

final class HasEditedUserProvider
    extends $NotifierProvider<HasEditedUser, bool> {
  const HasEditedUserProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'hasEditedUserProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$hasEditedUserHash();

  @$internal
  @override
  HasEditedUser create() => HasEditedUser();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$hasEditedUserHash() => r'4dec26cf817e5e260f00541471590939df2d7f14';

abstract class _$HasEditedUser extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(FirstName)
const firstNameProvider = FirstNameProvider._();

final class FirstNameProvider extends $NotifierProvider<FirstName, String?> {
  const FirstNameProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'firstNameProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firstNameHash();

  @$internal
  @override
  FirstName create() => FirstName();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$firstNameHash() => r'b526ee09dc23808f07ef7ccfb6436dc5f85d50b8';

abstract class _$FirstName extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<String?, String?>, String?, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(LastName)
const lastNameProvider = LastNameProvider._();

final class LastNameProvider extends $NotifierProvider<LastName, String?> {
  const LastNameProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'lastNameProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$lastNameHash();

  @$internal
  @override
  LastName create() => LastName();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$lastNameHash() => r'04a427273b222e7cd6679aea4b093093b139beff';

abstract class _$LastName extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<String?, String?>, String?, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DateOfBirth)
const dateOfBirthProvider = DateOfBirthProvider._();

final class DateOfBirthProvider
    extends $NotifierProvider<DateOfBirth, DateTime?> {
  const DateOfBirthProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'dateOfBirthProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$dateOfBirthHash();

  @$internal
  @override
  DateOfBirth create() => DateOfBirth();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime?>(value),
    );
  }
}

String _$dateOfBirthHash() => r'671f85e49c14fe1188732905c1f712606cb1bdca';

abstract class _$DateOfBirth extends $Notifier<DateTime?> {
  DateTime? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DateTime?, DateTime?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<DateTime?, DateTime?>, DateTime?, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
