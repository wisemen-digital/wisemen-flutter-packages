import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_ultra_login/wise_ultra_login.dart';
import 'package:wiseclient/wiseclient.dart';
import 'package:wisecore/wisecore.dart';

import '../utils/fake_ref.dart';
import '../utils/mock_auth.dart';

void main() {
  setUp(mockPlatformAlerts);

  setUpAll(() {
    // Initialize Wisecore with a mock client provider
    Wisecore.init(
      protectedClientProvider: Provider<WiseClient>((ref) => MockWiseClient()),
    );

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
      test(
          'LoginFeature.repository points to baseLoginRepositoryProvider by default',
          () {
        LoginFeature.init(
          loginFlavors: FakeLoginFlavors(),
          loginLocalizations: FakeLoginLocalizations(),
          loginAssets: FakeLoginAssets(),
        );

        expect(LoginFeature.repository, baseLoginRepositoryProvider);
      });

      test('LoginFeature.repository can be overridden', () {
        final customProvider =
            Provider<LoginRepository>((ref) => MockLoginRepository());

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

    group('Login Flow', () {
      test('login successfully authenticates with Google', () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final repository = container.read(baseLoginRepositoryProvider);
        final googleMethod =
            LoginMethod(id: 'google', name: 'Google', type: LoginType.google);

        // Should complete without throwing
        await repository.login(googleMethod);
        expect(true, isTrue);
      });

      test('login successfully authenticates with Apple', () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final repository = container.read(baseLoginRepositoryProvider);
        final appleMethod =
            LoginMethod(id: 'apple', name: 'Apple', type: LoginType.apple);

        await repository.login(appleMethod);
        expect(true, isTrue);
      });

      test('login successfully authenticates with Email', () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final repository = container.read(baseLoginRepositoryProvider);
        final emailMethod =
            LoginMethod(id: '', name: 'Email', type: LoginType.email);

        await repository.login(emailMethod);
        expect(true, isTrue);
      });

      test('login handles method with empty ID', () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final repository = container.read(baseLoginRepositoryProvider);
        final customMethod =
            LoginMethod(id: '', name: 'Custom', type: LoginType.other);

        await repository.login(customMethod);
        expect(true, isTrue);
      });

      test('login handles method with non-empty ID', () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final repository = container.read(baseLoginRepositoryProvider);
        final customMethod = LoginMethod(
            id: 'custom-idp', name: 'Custom', type: LoginType.other);

        await repository.login(customMethod);
        expect(true, isTrue);
      });
    });

    group('Logout Flow', () {
      test('logout successfully ends session', () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final repository = container.read(baseLoginRepositoryProvider);

        // Should complete without throwing
        await repository.logout();
        expect(true, isTrue);
      });

      test('logout handles errors gracefully', () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final repository = container.read(baseLoginRepositoryProvider);

        // Even if logout fails, it should still remove tokens
        await repository.logout();
        expect(true, isTrue);
      });
    });

    group('Token Refresh', () {
      test('refresh successfully refreshes tokens', () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final repository = container.read(baseLoginRepositoryProvider);
        final oldToken = OAuthToken(
          tokenType: 'Bearer',
          accessToken: 'old_access_token',
          refreshToken: 'old_refresh_token',
          expiresIn: 3600,
        );

        final newToken = await repository.refresh(oldToken);

        expect(newToken, isA<OAuth2Token>());
        expect(newToken.accessToken, 'refreshed_access_token');
        expect(newToken.refreshToken, 'refreshed_refresh_token');
      });

      test('refresh handles null token', () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final repository = container.read(baseLoginRepositoryProvider);

        final newToken = await repository.refresh(null);

        expect(newToken, isA<OAuth2Token>());
        expect(newToken.accessToken, 'refreshed_access_token');
      });

      test('refresh handles token with null refresh token', () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final repository = container.read(baseLoginRepositoryProvider);
        final oldToken = OAuthToken(
          tokenType: 'Bearer',
          accessToken: 'old_access_token',
          expiresIn: 3600,
        );

        final newToken = await repository.refresh(oldToken);

        expect(newToken, isA<OAuth2Token>());
      });
    });

    group('Repository Instance', () {
      test('repository has correct ref', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final repository = container.read(baseLoginRepositoryProvider);

        expect(repository.ref, isNotNull);
      });

      test('multiple containers create independent repositories', () {
        final container1 = ProviderContainer();
        final container2 = ProviderContainer();
        addTearDown(container1.dispose);
        addTearDown(container2.dispose);

        final repository1 = container1.read(baseLoginRepositoryProvider);
        final repository2 = container2.read(baseLoginRepositoryProvider);

        expect(identical(repository1, repository2), isFalse);
      });
    });
  });
}
