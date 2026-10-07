import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../options.dart';
import '../repository/auth_repository.dart';

/// A provider for the [WiseZitadelOptions] instance. Needs to be overridden in main
final wiseZitadelOptionsProvider = Provider<WiseZitadelOptions>(
  (ref) => throw UnimplementedError(
    'Make sure to override this container with the actual values from flavours',
  ),
);

/// A provider for the [WiseZitadelAuthenticator] used by the login screen
///
/// Override it with a fake in tests to skip the browser based login flow.
final wiseZitadelAuthenticatorProvider = Provider<WiseZitadelAuthenticator>((
  ref,
) {
  final authenticator = AuthenticationRepository(
    options: ref.watch(wiseZitadelOptionsProvider),
  );
  ref.onDispose(authenticator.dispose);
  return authenticator;
});
