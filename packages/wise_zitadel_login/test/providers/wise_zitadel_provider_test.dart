import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/misc.dart';
import 'package:test/test.dart';
import 'package:wise_zitadel_login/src/repository/auth_repository.dart';
import 'package:wise_zitadel_login/wise_zitadel_login.dart';

import '../utils/test_options.dart';

void main() {
  test('Can read wiseZitadelOptionsProvider when it is overridden', () {
    final container = ProviderContainer(
      overrides: [wiseZitadelOptionsProvider.overrideWithValue(testOptions())],
    );
    addTearDown(container.dispose);

    expect(
      container.read(wiseZitadelOptionsProvider),
      isA<WiseZitadelOptions>(),
    );
  });

  test('Throws exception when not overridden', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(
      () => container.read(wiseZitadelOptionsProvider),
      throwsA(isA<ProviderException>()),
    );
  });

  test('wiseZitadelAuthenticatorProvider builds a repository from options', () {
    final options = testOptions();
    final container = ProviderContainer(
      overrides: [wiseZitadelOptionsProvider.overrideWithValue(options)],
    );
    addTearDown(container.dispose);

    final authenticator = container.read(wiseZitadelAuthenticatorProvider);

    expect(authenticator, isA<AuthenticationRepository>());
    expect((authenticator as AuthenticationRepository).options, options);
  });
}
