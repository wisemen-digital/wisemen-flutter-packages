// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SupportedLoginTypes)
const supportedLoginTypesProvider = SupportedLoginTypesProvider._();

final class SupportedLoginTypesProvider
    extends $NotifierProvider<SupportedLoginTypes, List<LoginMethod>> {
  const SupportedLoginTypesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supportedLoginTypesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supportedLoginTypesHash();

  @$internal
  @override
  SupportedLoginTypes create() => SupportedLoginTypes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<LoginMethod> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<LoginMethod>>(value),
    );
  }
}

String _$supportedLoginTypesHash() =>
    r'dac71b6611873938050b2382041202c0e5fba8e6';

abstract class _$SupportedLoginTypes extends $Notifier<List<LoginMethod>> {
  List<LoginMethod> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<LoginMethod>, List<LoginMethod>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<LoginMethod>, List<LoginMethod>>,
              List<LoginMethod>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(SelectedLoginMethod)
const selectedLoginMethodProvider = SelectedLoginMethodProvider._();

final class SelectedLoginMethodProvider
    extends $NotifierProvider<SelectedLoginMethod, LoginMethod?> {
  const SelectedLoginMethodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedLoginMethodProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedLoginMethodHash();

  @$internal
  @override
  SelectedLoginMethod create() => SelectedLoginMethod();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoginMethod? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoginMethod?>(value),
    );
  }
}

String _$selectedLoginMethodHash() =>
    r'7cf9bd4978061c83f797108e84773cf99e534bac';

abstract class _$SelectedLoginMethod extends $Notifier<LoginMethod?> {
  LoginMethod? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<LoginMethod?, LoginMethod?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LoginMethod?, LoginMethod?>,
              LoginMethod?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
