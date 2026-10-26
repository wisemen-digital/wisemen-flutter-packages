import 'package:fresh_dio/fresh_dio.dart';

import '../secure_token_storage/fresh_secure_token_storage.dart';

/// Creates a [Fresh] interceptor to refresh oauth tokens
///
/// [httpClient] sends the refresh request and retries the failed request.
/// Configure it like the client it serves; it must not contain this
/// interceptor itself.
Fresh<OAuth2Token> getFreshInterceptor({
  required Future<OAuth2Token> Function(OAuth2Token?, Dio) refreshFunction,
  ShouldRefreshBeforeRequest<OAuth2Token>? shouldRefreshBeforeRequest,
  TokenStorage<OAuth2Token>? tokenStorage,
  Dio? httpClient,
}) {
  return Fresh.oAuth2(
    tokenStorage: tokenStorage ?? FreshSecureTokenStorage(),
    refreshToken: refreshFunction,
    shouldRefreshBeforeRequest: shouldRefreshBeforeRequest,
    httpClient: httpClient,
  );
}
