import 'package:fresh_dio/fresh_dio.dart';

import '../secure_token_storage/fresh_secure_token_storage.dart';

/// Creates a [Fresh] interceptor to refresh oauth tokens
Fresh<OAuth2Token> getFreshInterceptor({
  required Future<OAuth2Token> Function(OAuth2Token?, Dio) refreshFunction,
  ShouldRefreshBeforeRequest<OAuth2Token>? shouldRefreshBeforeRequest,
  TokenStorage<OAuth2Token>? tokenStorage,
}) {
  return Fresh.oAuth2(
    tokenStorage: tokenStorage ?? FreshSecureTokenStorage(),
    refreshToken: refreshFunction,
    shouldRefreshBeforeRequest: shouldRefreshBeforeRequest,
  );
}
