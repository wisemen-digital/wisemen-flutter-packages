import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_ultra_login/wise_ultra_login.dart';
import 'package:wiseclient/wiseclient.dart';

import '../utils/fake_ref.dart';
import '../utils/mock_auth.dart';

class MockLoginRepositoryWithTracking implements LoginRepository {
  int loginCallCount = 0;
  int logoutCallCount = 0;
  LoginMethod? lastLoginMethod;
  bool shouldThrowOnLogin = false;
  bool shouldThrowOnLogout = false;

  @override
  List<LoginMethod> getSupportedLoginMethods() {
    return FakeLoginFlavors().loginMethods;
  }

  @override
  Future<void> login(LoginMethod method) async {
    loginCallCount++;
    lastLoginMethod = method;
    if (shouldThrowOnLogin) {
      throw Exception('Login failed');
    }
  }

  @override
  Future<void> logout() async {
    logoutCallCount++;
    if (shouldThrowOnLogout) {
      throw Exception('Logout failed');
    }
  }

  @override
  Future<OAuth2Token> refresh(OAuth2Token? token) async {
    return OAuthToken(
      tokenType: 'Bearer',
      accessToken: 'mock_access_token',
      refreshToken: 'mock_refresh_token',
      expiresIn: 3600,
    );
  }
}

void main() {
  setUp(mockPlatformAlerts);

  group('LoginController', () {
    late MockLoginRepositoryWithTracking mockRepository;
    late ProviderContainer container;

    setUp(() {
      mockRepository = MockLoginRepositoryWithTracking();

      LoginFeature.init(
        loginFlavors: FakeLoginFlavors(),
        loginLocalizations: FakeLoginLocalizations(),
        loginAssets: FakeLoginAssets(),
        loginRepository: Provider<LoginRepository>((ref) => mockRepository),
      );

      container = ProviderContainer();

      // Reset platform alert response for each test
      resetPlatformAlertResponse();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is AsyncValue with null data', () async {
      final state = await container.read(loginControllerProvider.future);
      expect(state, isNull);
    });

    test('login calls repository with correct method', () async {
      final method = LoginMethod(
        id: 'google',
        name: 'Google',
        type: LoginType.google,
      );

      await container.read(loginControllerProvider.notifier).login(method);

      expect(mockRepository.loginCallCount, 1);
      expect(mockRepository.lastLoginMethod, method);
    });

    test('login updates selected login method during operation', () async {
      final method = LoginMethod(
        id: 'google',
        name: 'Google',
        type: LoginType.google,
      );

      // Initial state should be null
      expect(container.read(selectedLoginMethodProvider), isNull);

      await container.read(loginControllerProvider.notifier).login(method);

      // After completion, selected method should be cleared again
      expect(container.read(selectedLoginMethodProvider), isNull);
    });

    test('logout calls repository logout', () async {
      await container.read(loginControllerProvider.notifier).logout();

      expect(mockRepository.logoutCallCount, 1);
    });

    test('logout clears selected login method in finally block', () async {
      // Set a selected method
      final method = LoginMethod(
        id: 'google',
        name: 'Google',
        type: LoginType.google,
      );
      container.read(selectedLoginMethodProvider.notifier).changeValue(method);
      expect(container.read(selectedLoginMethodProvider), method);

      await container.read(loginControllerProvider.notifier).logout();

      // Selected method should be cleared after logout
      expect(container.read(selectedLoginMethodProvider), isNull);
    });

    test('login handles errors and updates state', () async {
      mockRepository.shouldThrowOnLogin = true;

      final method = LoginMethod(
        id: 'google',
        name: 'Google',
        type: LoginType.google,
      );

      await container.read(loginControllerProvider.notifier).login(method);

      // State should be in error state
      final state = container.read(loginControllerProvider);
      expect(state.hasError, isTrue);
      expect(state.error.toString(), contains('Login failed'));
    });

    test('login clears selected method even when error occurs', () async {
      mockRepository.shouldThrowOnLogin = true;

      final method = LoginMethod(
        id: 'google',
        name: 'Google',
        type: LoginType.google,
      );

      await container.read(loginControllerProvider.notifier).login(method);

      // Selected method should be cleared in finally block
      expect(container.read(selectedLoginMethodProvider), isNull);
    });

    test('logout handles errors and updates state', () async {
      mockRepository.shouldThrowOnLogout = true;

      await container.read(loginControllerProvider.notifier).logout();

      // State should be in error state
      final state = container.read(loginControllerProvider);
      expect(state.hasError, isTrue);
      expect(state.error.toString(), contains('Logout failed'));
    });

    test('logout clears selected method even when error occurs', () async {
      mockRepository.shouldThrowOnLogout = true;

      // Set a selected method
      final method = LoginMethod(
        id: 'google',
        name: 'Google',
        type: LoginType.google,
      );
      container.read(selectedLoginMethodProvider.notifier).changeValue(method);

      await container.read(loginControllerProvider.notifier).logout();

      // Selected method should be cleared in finally block
      expect(container.read(selectedLoginMethodProvider), isNull);
    });

    test('logout with needsConfirmation flag completes', () async {
      // Test that logout with confirmation parameter completes without error
      // Note: Full platform alert behavior tested in integration tests
      await container.read(loginControllerProvider.notifier).logout(needsConfirmation: true);

      // Logout should eventually be called (platform mock returns positive by default)
      expect(mockRepository.logoutCallCount, greaterThan(0));
    });
  });
}
