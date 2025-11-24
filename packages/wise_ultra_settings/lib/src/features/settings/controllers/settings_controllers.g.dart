// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SettingsControllers)
const settingsControllersProvider = SettingsControllersProvider._();

final class SettingsControllersProvider
    extends $AsyncNotifierProvider<SettingsControllers, dynamic> {
  const SettingsControllersProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'settingsControllersProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$settingsControllersHash();

  @$internal
  @override
  SettingsControllers create() => SettingsControllers();
}

String _$settingsControllersHash() =>
    r'c63845ee7e7a5462c41765b816d2e9531a0d2310';

abstract class _$SettingsControllers extends $AsyncNotifier<dynamic> {
  FutureOr<dynamic> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<dynamic>, dynamic>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<dynamic>, dynamic>,
        AsyncValue<dynamic>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
