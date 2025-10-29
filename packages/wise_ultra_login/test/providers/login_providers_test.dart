import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_ultra_login/wise_ultra_login.dart';

import '../utils/fake_ref.dart';

void main() {
  setUpAll(() {
    LoginFeature.init(
      loginFlavors: FakeLoginFlavors(),
      loginLocalizations: FakeLoginLocalizations(),
      loginAssets: FakeLoginAssets(),
      loginRepository: Provider<LoginRepository>((ref) => MockLoginRepository()),
    );
  });

  group('SupportedLoginTypesProvider', () {
    test('returns list of supported login methods', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final supportedTypes = container.read(supportedLoginTypesProvider);

      expect(supportedTypes, isA<List<LoginMethod>>());
      expect(supportedTypes.length, 3);
      expect(supportedTypes[0].type, LoginType.google);
      expect(supportedTypes[1].type, LoginType.apple);
      expect(supportedTypes[2].type, LoginType.email);
    });

    test('returns same methods from LoginFlavors', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final supportedTypes = container.read(supportedLoginTypesProvider);
      final expectedMethods = FakeLoginFlavors().loginMethods;

      expect(supportedTypes.length, expectedMethods.length);
      for (var i = 0; i < supportedTypes.length; i++) {
        expect(supportedTypes[i].id, expectedMethods[i].id);
        expect(supportedTypes[i].name, expectedMethods[i].name);
        expect(supportedTypes[i].type, expectedMethods[i].type);
      }
    });
  });

  group('SelectedLoginMethodProvider', () {
    test('initial value is null', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final selectedMethod = container.read(selectedLoginMethodProvider);

      expect(selectedMethod, isNull);
    });

    test('changeValue updates the selected method', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final method = LoginMethod(
        id: 'google',
        name: 'Google',
        type: LoginType.google,
      );

      container
          .read(selectedLoginMethodProvider.notifier)
          .changeValue(method);

      final selectedMethod = container.read(selectedLoginMethodProvider);
      expect(selectedMethod, method);
      expect(selectedMethod?.id, 'google');
      expect(selectedMethod?.type, LoginType.google);
    });

    test('changeValue can clear the selected method', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final method = LoginMethod(
        id: 'google',
        name: 'Google',
        type: LoginType.google,
      );

      // Set a method
      container
          .read(selectedLoginMethodProvider.notifier)
          .changeValue(method);
      expect(container.read(selectedLoginMethodProvider), method);

      // Clear it
      container.read(selectedLoginMethodProvider.notifier).changeValue(null);
      expect(container.read(selectedLoginMethodProvider), isNull);
    });

    test('can change from one method to another', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final googleMethod = LoginMethod(
        id: 'google',
        name: 'Google',
        type: LoginType.google,
      );
      final appleMethod = LoginMethod(
        id: 'apple',
        name: 'Apple',
        type: LoginType.apple,
      );

      // Set Google
      container
          .read(selectedLoginMethodProvider.notifier)
          .changeValue(googleMethod);
      expect(
        container.read(selectedLoginMethodProvider),
        googleMethod,
      );

      // Change to Apple
      container
          .read(selectedLoginMethodProvider.notifier)
          .changeValue(appleMethod);
      expect(
        container.read(selectedLoginMethodProvider),
        appleMethod,
      );
    });
  });
}
