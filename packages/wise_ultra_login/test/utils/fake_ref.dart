import 'package:flutter/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wise_ultra_login/wise_ultra_login.dart';
import 'package:wiseclient/wiseclient.dart';

int loginCalls = 0;

class FakeLoginFlavors implements LoginFlavors {
  @override
  String get authenticationUrl => 'https://auth.example.com';

  @override
  String get bundleId => 'com.example.app';

  @override
  String get clientID => 'test_client_id';

  @override
  String get organizationID => 'test_org_id';

  @override
  List<LoginMethod> get loginMethods => [
        LoginMethod(id: 'google', name: 'Google', type: LoginType.google),
        LoginMethod(id: 'apple', name: 'Apple', type: LoginType.apple),
        LoginMethod(id: 'email', name: 'Email', type: LoginType.email),
      ];

  @override
  String get splashImage => ''; // Empty to avoid network image loading in tests
}

class FakeLoginLocalizations implements LoginLocalizations {
  @override
  String get cancel => 'Cancel';

  @override
  String get logout => 'Logout';

  @override
  String get logoutWarning => 'Are you sure you want to logout?';

  @override
  String email(BuildContext context) => 'Email';

  @override
  String loginMethod(BuildContext context, String value) =>
      'Sign in with $value';

  @override
  String loginSubtitle(BuildContext context) => 'Choose your login method';

  @override
  String loginTitle(BuildContext context) => 'Welcome';
}

class FakeLoginAssets implements LoginAssets {
  @override
  String get apple => 'test/fixtures/test_icon.svg';

  @override
  String get email => 'test/fixtures/test_icon.svg';

  @override
  String get google => 'test/fixtures/test_icon.svg';

  @override
  String get splashImage => 'test/fixtures/test_image.png';
}

class MockLoginRepository extends Mock implements LoginRepository {
  @override
  List<LoginMethod> getSupportedLoginMethods() {
    return FakeLoginFlavors().loginMethods;
  }

  @override
  Future<void> login(LoginMethod method) async {
    loginCalls++;
    return;
  }

  @override
  Future<void> logout() async {
    return;
  }

  @override
  Future<OAuth2Token> refresh(OAuth2Token? token) async {
    return OAuthToken(
      tokenType: 'Bearer',
      accessToken: 'refreshed_access_token',
      refreshToken: 'refreshed_refresh_token',
      expiresIn: 3600,
    );
  }
}

class MockWiseClient extends Mock implements WiseClient {
  @override
  Future<void> setFreshToken({required OAuth2Token token}) async {
    // Mock implementation
  }

  @override
  Future<void> removeFreshToken() async {
    // Mock implementation
  }
}
