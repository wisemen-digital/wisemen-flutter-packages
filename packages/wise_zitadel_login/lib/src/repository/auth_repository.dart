import 'package:flutter/foundation.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:wiseclient/wiseclient.dart' show OAuthToken;

import '../options.dart';
import '../types/zitadel_login_type.dart';

/// [AuthenticationRepository] handles the login process
class AuthenticationRepository {
  static const FlutterAppAuth _appAuth = FlutterAppAuth();

  /// Zitadel login using [FlutterAppAuth]
  static Future<OAuthToken?> login({
    required WiseZitadelOptions options,
    required ZitadelLoginType type,
  }) async {
    try {
      final discoveryDocumentUri = Uri.parse(
        '${options.zitadelBaseUrl}/.well-known/openid-configuration',
      );

      /// This will be the current url of the page + /auth.html added to it.
      final webCallbackUrl = Uri.base.replace(path: 'auth.html');

      /// for web platforms, we use http://website-url.com/auth.html
      /// for mobile platforms, we use `com.zitadel.zitadelflutter:/`
      final redirectUri = kIsWeb
          ? webCallbackUrl
          : Uri(
              scheme: options.bundleId,
              path: '/',
            );

      final response = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          options.applicationId,
          redirectUri.toString(),
          discoveryUrl: discoveryDocumentUri.toString(),
          scopes: [
            'openid',
            'profile',
            'email',
            'offline_access',
            'urn:zitadel:iam:org:id:${options.organizationId}',
            if (type.idp.isNotEmpty) 'urn:zitadel:iam:org:idp:id:${type.idp}',
          ],
        ),
      );

      if (response.accessToken != null && response.refreshToken != null) {
        return OAuthToken(
          tokenType: response.tokenType,
          accessToken: response.accessToken!,
          refreshToken: response.refreshToken,
          expiresIn: response.accessTokenExpirationDateTime!
              .difference(DateTime.now())
              .inSeconds,
        );
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
