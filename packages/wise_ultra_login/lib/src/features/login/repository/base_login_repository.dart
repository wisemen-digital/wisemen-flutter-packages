// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wiseclient/wiseclient.dart';
import 'package:wisecore/wisecore.dart';

import '../login.dart';

/// Default implementation of [LoginRepository] using Zitadel OAuth2/OIDC.
///
/// This implementation uses `flutter_appauth` to handle the OAuth2 authorization
/// code flow with PKCE, integrating with Zitadel for authentication. It manages
/// secure token storage, automatic token refresh, and session lifecycle.
///
/// The repository:
/// - Performs OAuth2 authorization with Zitadel OIDC discovery
/// - Stores ID tokens securely using flutter_secure_storage
/// - Registers access/refresh tokens with the Wisecore HTTP client
/// - Handles token refresh when tokens expire
/// - Manages logout and token revocation
///
/// This is the default repository used by [LoginFeature] unless a custom
/// implementation is provided during initialization.
class BaseLoginRepository implements LoginRepository {
  /// Creates a new BaseLoginRepository.
  ///
  /// Parameters:
  /// - [ref]: Riverpod ref for accessing providers and managing HTTP client state
  BaseLoginRepository({required this.ref});

  /// Riverpod ref for accessing providers.
  final Ref ref;

  /// Instance of FlutterAppAuth for OAuth2 operations.
  static const FlutterAppAuth _appAuth = FlutterAppAuth();

  /// Secure storage for persisting ID tokens.
  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();

  /// Storage key for the ID token in secure storage.
  // ignore: constant_identifier_names
  static const String ID_TOKEN_STORAGE_KEY = 'ID_TOKEN';

  /// Constructs the OAuth2 redirect URI based on the current platform.
  ///
  /// For web: Returns `{base_url}/auth.html`
  /// For mobile: Returns `{bundleId}:/` where bundleId is from [LoginFlavors]
  Uri? get _redirectUri {
    final callbackUrlScheme = LoginFeature.flavors.bundleId;

    final webCallbackUrl = Uri.base.replace(path: 'auth.html');

    return kIsWeb ? webCallbackUrl : Uri(scheme: callbackUrlScheme, path: '/');
  }

  /// The Zitadel OIDC discovery document URI.
  ///
  /// This URI is used to automatically discover OAuth2 endpoints (authorization,
  /// token, userinfo, etc.) from the Zitadel server.
  final _discoveryDocumentUri = Uri.parse('${LoginFeature.flavors.authenticationUrl}/.well-known/openid-configuration');

  /// Returns the list of authentication methods configured in [LoginFlavors].
  ///
  /// This implementation simply delegates to [LoginFlavors.loginMethods].
  @override
  List<LoginMethod> getSupportedLoginMethods() {
    return LoginFeature.flavors.loginMethods;
  }

  /// Initiates OAuth2 authorization flow with Zitadel for the specified method.
  ///
  /// This method performs the following steps:
  /// 1. Opens browser/custom tab with Zitadel authorization page
  /// 2. User authenticates with the selected identity provider
  /// 3. Receives authorization code via redirect URI
  /// 4. Exchanges code for access token, refresh token, and ID token
  /// 5. Stores ID token securely for logout
  /// 6. Registers tokens with Wisecore HTTP client for API requests
  ///
  /// Parameters:
  /// - [method]: The authentication method/identity provider to use
  ///
  /// Throws [Exception] if authorization fails or is cancelled by the user.
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
        await ref.read(Wisecore.protectedClientProvider).setFreshToken(token: token);
      }
      return;
    } catch (e) {
      rethrow;
    }
  }

  /// Ends the user session and revokes all tokens.
  ///
  /// This method performs the following steps:
  /// 1. Retrieves the stored ID token
  /// 2. Calls Zitadel's end session endpoint (opens browser for logout)
  /// 3. Closes the custom tab after a delay
  /// 4. Deletes the stored ID token
  /// 5. Removes tokens from the Wisecore HTTP client
  ///
  /// Note: This method completes even if the end session call fails,
  /// ensuring tokens are always removed locally.
  @override
  Future<void> logout() async {
    try {
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
    } catch (e) {
      rethrow;
    }

    await ref.read(Wisecore.protectedClientProvider).removeFreshToken();
  }

  /// Refreshes an expired access token using the refresh token.
  ///
  /// This method is called automatically by the Wisecore HTTP client when
  /// it receives a 401 or 400 response indicating token expiration.
  ///
  /// The method performs the following steps:
  /// 1. Extracts the refresh token from the current token
  /// 2. Calls Zitadel's token endpoint to exchange refresh token for new tokens
  /// 3. Updates the Wisecore HTTP client with the new tokens
  /// 4. Returns the new token for the HTTP client to use
  ///
  /// If refresh fails due to invalid/expired refresh token (401/400 response
  /// or FlutterAppAuth 'token_failed' error), automatically logs out the user
  /// and throws [RevokeTokenException].
  ///
  /// Parameters:
  /// - [token]: The current OAuth2Token containing the refresh token
  ///
  /// Returns a new [OAuth2Token] with fresh access and ID tokens.
  ///
  /// Throws:
  /// - [RevokeTokenException] if the refresh token is invalid or expired
  /// - [Exception] for other errors during the refresh process
  @override
  Future<OAuth2Token> refresh(OAuth2Token? token) async {
    final refreshToken = token?.refreshToken ?? '';

    try {
      const appAuth = FlutterAppAuth();

      final discoveryDocumentUri = Uri.parse('${LoginFeature.flavors.authenticationUrl}/.well-known/openid-configuration');

      final response = await appAuth.token(
        TokenRequest(
          LoginFeature.flavors.clientID,
          _redirectUri.toString(),
          refreshToken: refreshToken,
          discoveryUrl: discoveryDocumentUri.toString(),
          scopes: [
            'openid',
            'profile',
            'email',
            'offline_access',
            'urn:zitadel:iam:org:id:${LoginFeature.flavors.organizationID}',
          ],
        ),
      );

      final token = OAuthToken(
        tokenType: response.tokenType,
        accessToken: response.accessToken!,
        refreshToken: response.refreshToken,
        expiresIn: response.accessTokenExpirationDateTime!.difference(DateTime.now()).inSeconds,
      );

      await ref.read(Wisecore.protectedClientProvider).setFreshToken(token: token);

      return token;
    } on DioException catch (e) {
      if ([401, 400].any(
        (element) => element == e.response?.statusCode,
      )) {
        await logout();
        throw RevokeTokenException();
      } else {
        rethrow;
      }
    } on FlutterAppAuthPlatformException catch (e) {
      if (e.code == 'token_failed') {
        await logout();
        throw RevokeTokenException();
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }
}

/// Provider for the default [BaseLoginRepository] implementation.
///
/// This provider creates and manages the lifecycle of [BaseLoginRepository],
/// which handles OAuth2 authentication with Zitadel.
///
/// This is the default repository used by [LoginFeature] unless a custom
/// repository provider is specified during initialization.
///
/// Example of using a custom repository:
/// ```dart
/// LoginFeature.init(
///   loginRepository: myCustomRepositoryProvider,
///   loginLocalizations: AppLoginLocalizations(),
///   loginAssets: AppLoginAssets(),
///   loginFlavors: AppLoginFlavors(),
/// );
/// ```
final baseLoginRepositoryProvider = Provider<BaseLoginRepository>((ref) => BaseLoginRepository(ref: ref));
