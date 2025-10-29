import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_ultra_login/wise_ultra_login.dart';

import '../utils/fake_ref.dart';
import '../utils/mock_auth.dart';

void main() {
  setUp(mockPlatformAlerts);

  setUpAll(() {
    LoginFeature.init(
      loginFlavors: FakeLoginFlavors(),
      loginLocalizations: FakeLoginLocalizations(),
      loginAssets: FakeLoginAssets(),
    );
  });

  group('BaseLoginRepository', () {
    test('baseLoginRepositoryProvider creates repository', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final repository = container.read(baseLoginRepositoryProvider);

      expect(repository, isA<BaseLoginRepository>());
    });

    test('baseLoginRepositoryProvider returns same instance', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final repository1 = container.read(baseLoginRepositoryProvider);
      final repository2 = container.read(baseLoginRepositoryProvider);

      expect(identical(repository1, repository2), isTrue);
    });

    test('getSupportedLoginMethods returns methods from flavors', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final repository = container.read(baseLoginRepositoryProvider);
      final methods = repository.getSupportedLoginMethods();

      expect(methods, isA<List<LoginMethod>>());
      expect(methods.length, 3);
      expect(methods[0].type, LoginType.google);
      expect(methods[1].type, LoginType.apple);
      expect(methods[2].type, LoginType.email);
    });

    test('getSupportedLoginMethods matches LoginFlavors configuration', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final repository = container.read(baseLoginRepositoryProvider);
      final methods = repository.getSupportedLoginMethods();
      final expectedMethods = FakeLoginFlavors().loginMethods;

      expect(methods.length, expectedMethods.length);
      for (var i = 0; i < methods.length; i++) {
        expect(methods[i].id, expectedMethods[i].id);
        expect(methods[i].name, expectedMethods[i].name);
        expect(methods[i].type, expectedMethods[i].type);
      }
    });

    group('Integration with LoginFeature', () {
      test('LoginFeature.repository points to baseLoginRepositoryProvider by default',
          () {
        LoginFeature.init(
          loginFlavors: FakeLoginFlavors(),
          loginLocalizations: FakeLoginLocalizations(),
          loginAssets: FakeLoginAssets(),
        );

        expect(LoginFeature.repository, baseLoginRepositoryProvider);
      });

      test('LoginFeature.repository can be overridden', () {
        final customProvider = Provider<LoginRepository>((ref) => MockLoginRepository());

        LoginFeature.init(
          loginFlavors: FakeLoginFlavors(),
          loginLocalizations: FakeLoginLocalizations(),
          loginAssets: FakeLoginAssets(),
          loginRepository: customProvider,
        );

        expect(LoginFeature.repository, customProvider);
        expect(LoginFeature.repository, isNot(baseLoginRepositoryProvider));
      });
    });

    group('OAuth2 Configuration', () {
      test('repository uses correct authentication URL from flavors', () {
        final flavors = FakeLoginFlavors();
        expect(flavors.authenticationUrl, 'https://auth.example.com');
      });

      test('repository uses correct client ID from flavors', () {
        final flavors = FakeLoginFlavors();
        expect(flavors.clientID, 'test_client_id');
      });

      test('repository uses correct organization ID from flavors', () {
        final flavors = FakeLoginFlavors();
        expect(flavors.organizationID, 'test_org_id');
      });

      test('repository uses correct bundle ID from flavors', () {
        final flavors = FakeLoginFlavors();
        expect(flavors.bundleId, 'com.example.app');
      });
    });

  });
}
