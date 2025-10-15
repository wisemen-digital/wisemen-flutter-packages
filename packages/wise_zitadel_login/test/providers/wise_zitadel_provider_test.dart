import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/misc.dart';
import 'package:test/test.dart';
import 'package:wise_zitadel_login/wise_zitadel_login.dart';

import '../utils/fake_ref.dart';

void main() {
  test('Can call wiseZitadelOptionsProvider using ref', () {
    final ref = FakeRef();
    final options = ref.read(wiseZitadelOptionsProvider);

    expect(options, isA<WiseZitadelOptions>());
  });

  test('Throws exception when not overridden', () {
    final container = ProviderContainer();
    expect(
      () => container.read(wiseZitadelOptionsProvider),
      throwsA(isA<ProviderException>()),
    );
  });
}
