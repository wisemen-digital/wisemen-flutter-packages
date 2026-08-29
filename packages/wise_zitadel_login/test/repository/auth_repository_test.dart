import 'package:flutter_test/flutter_test.dart';
import 'package:oidc/oidc.dart';
import 'package:wise_zitadel_login/src/repository/auth_repository.dart';
import 'package:wise_zitadel_login/wise_zitadel_login.dart';
import 'package:wiseclient/wiseclient.dart' show OAuthToken;

import '../utils/test_options.dart';

void main() {
  group('scopesFor', () {
    test('always requests the openid scopes and the organization scope', () {
      final scopes = AuthenticationRepository.scopesFor(
        options: testOptions(),
      );

      expect(scopes, [
        'openid',
        'profile',
        'email',
        'offline_access',
        'urn:zitadel:iam:org:id:org_id',
      ]);
    });

    test('appends the idp scope for a login type with an idp', () {
      final scopes = AuthenticationRepository.scopesFor(
        options: testOptions(),
        type: testLoginType,
      );

      expect(scopes.last, 'urn:zitadel:iam:org:idp:id:idp_id');
    });

    test('omits the idp scope for a login type without an idp', () {
      final scopes = AuthenticationRepository.scopesFor(
        options: testOptions(),
        type: const ZitadelLoginType(
          buttonText: 'Internal',
          iconSvgString: '',
          idp: '',
        ),
      );

      expect(
        scopes.any((scope) => scope.startsWith('urn:zitadel:iam:org:idp:id:')),
        isFalse,
      );
    });
  });

  group('discoveryUriFor', () {
    test('points at the well known openid configuration', () {
      final uri = AuthenticationRepository.discoveryUriFor(
        options: testOptions(),
      );

      expect(
        uri.toString(),
        'https://zitadel.example.com/.well-known/openid-configuration',
      );
    });

    test('does not double the slash on a base url with a trailing slash', () {
      final uri = AuthenticationRepository.discoveryUriFor(
        options: testOptions(zitadelBaseUrl: 'https://zitadel.example.com/'),
      );

      expect(
        uri.toString(),
        'https://zitadel.example.com/.well-known/openid-configuration',
      );
    });
  });

  group('redirectUriFor', () {
    test('uses the bundle id as scheme on native platforms', () {
      final uri = AuthenticationRepository.redirectUriFor(
        options: testOptions(),
        isWeb: false,
      );

      expect(uri.toString(), 'com.example.app:/');
    });

    test('uses the redirect.html page of the current origin on web', () {
      final uri = AuthenticationRepository.redirectUriFor(
        options: testOptions(),
        isWeb: true,
      );

      expect(uri, Uri.base.replace(path: 'redirect.html'));
    });
  });

  group('settingsFor', () {
    test('disables the automatic refresh of the oidc manager', () {
      final settings = AuthenticationRepository.settingsFor(
        options: testOptions(),
        isWeb: false,
      );

      expect(
        settings.refreshBefore?.call(
          OidcToken(creationTime: DateTime.now(), accessToken: 'access'),
        ),
        isNull,
      );
    });

    test('uses the redirect uri and the base scopes', () {
      final settings = AuthenticationRepository.settingsFor(
        options: testOptions(),
        isWeb: false,
      );

      expect(settings.redirectUri.toString(), 'com.example.app:/');
      expect(
        settings.scope,
        AuthenticationRepository.scopesFor(
          options: testOptions(),
        ),
      );
    });
  });

  group('tokenFrom', () {
    test('maps an oidc token onto an OAuthToken', () {
      final creationTime = DateTime.utc(2026, 8, 29, 12);
      final token = AuthenticationRepository.tokenFrom(
        OidcToken(
          creationTime: creationTime,
          accessToken: 'access',
          refreshToken: 'refresh',
          tokenType: 'Bearer',
          expiresIn: const Duration(hours: 1),
          scope: const ['openid', 'profile'],
        ),
      );

      expect(token, isA<OAuthToken>());
      expect(token!.accessToken, 'access');
      expect(token.refreshToken, 'refresh');
      expect(token.tokenType, 'Bearer');
      expect(token.expiresIn, 3600);
      expect(token.scope, 'openid profile');
      expect(token.issuedAt, creationTime);
    });

    test('returns null when the response has no refresh token', () {
      final token = AuthenticationRepository.tokenFrom(
        OidcToken(
          creationTime: DateTime.now(),
          accessToken: 'access',
        ),
      );

      expect(token, isNull);
    });

    test('returns null when the response has no access token', () {
      final token = AuthenticationRepository.tokenFrom(
        OidcToken(
          creationTime: DateTime.now(),
          refreshToken: 'refresh',
        ),
      );

      expect(token, isNull);
    });
  });
}
