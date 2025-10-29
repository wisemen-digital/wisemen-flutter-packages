// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HasShownUpdate)
const hasShownUpdateProvider = HasShownUpdateProvider._();

final class HasShownUpdateProvider
    extends $NotifierProvider<HasShownUpdate, bool> {
  const HasShownUpdateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'hasShownUpdateProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$hasShownUpdateHash();

  @$internal
  @override
  HasShownUpdate create() => HasShownUpdate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$hasShownUpdateHash() => r'068679439a88d13aa8c9f68149e890da54db8f47';

abstract class _$HasShownUpdate extends $Notifier<bool> {
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
