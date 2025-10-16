import 'package:flutter/foundation.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wiseclient/wiseclient.dart';
import 'package:wisecore/wisecore.dart';

import '../login.dart';

class BaseLoginRepository implements LoginRepository {
  BaseLoginRepository({required this.ref});
  final Ref ref;

  static const FlutterAppAuth _appAuth = FlutterAppAuth();
  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();

  static const String ID_TOKEN_STORAGE_KEY = 'ID_TOKEN';

  Uri? get _redirectUri {
    final callbackUrlScheme = LoginFeature.flavors.bundleId;

    final webCallbackUrl = Uri.base.replace(path: 'auth.html');

    return kIsWeb ? webCallbackUrl : Uri(scheme: callbackUrlScheme, path: '/');
  }

  final _discoveryDocumentUri = Uri.parse('${LoginFeature.flavors.authenticationUrl}/.well-known/openid-configuration');

  @override
  List<LoginMethod> getSupportedLoginMethods() {
    return LoginFeature.flavors.loginMethods;
  }

  @override
  Future<void> login(LoginMethod method) async {
    try {
      final response = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          LoginFeature.flavors.clientID,
          _redirectUri.toString(),
          discoveryUrl: _discoveryDocumentUri.toString(),
          scopes: [
            'openid',
            'profile',
            'email',
            'offline_access',
            'urn:zitadel:iam:org:id:${LoginFeature.flavors.organizationID}',
            if (method.id.isNotEmpty) 'urn:zitadel:iam:org:idp:id:${method.id}',
          ],
        ),
      );

      if (response.idToken != null) {
        await _flutterSecureStorage.write(key: ID_TOKEN_STORAGE_KEY, value: response.idToken);
      }

      if (response.accessToken != null && response.refreshToken != null) {
        final token = OAuthToken(
          tokenType: response.tokenType,
          accessToken: response.accessToken!,
          refreshToken: response.refreshToken,
          expiresIn: response.accessTokenExpirationDateTime!.difference(DateTime.now()).inSeconds,
        );
        ref.read(Wisecore.protectedClientProvider).setFreshToken(token: token);
      }
      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    final idToken = await _flutterSecureStorage.read(key: ID_TOKEN_STORAGE_KEY);

    Future.delayed(const Duration(seconds: 2), () async {
      await closeCustomTabs();
      await _flutterSecureStorage.delete(key: ID_TOKEN_STORAGE_KEY);
    });

    await _appAuth.endSession(
      EndSessionRequest(
        idTokenHint: idToken,
        postLogoutRedirectUrl: _redirectUri.toString(),
        discoveryUrl: _discoveryDocumentUri.toString(),
        externalUserAgent: ExternalUserAgent.sfSafariViewController,
      ),
    );

    ref.read(Wisecore.protectedClientProvider).removeFreshToken();
  }
}

final baseLoginRepositoryProvider = Provider<BaseLoginRepository>((ref) => BaseLoginRepository(ref: ref));
