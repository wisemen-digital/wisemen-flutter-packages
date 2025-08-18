import 'package:dio/dio.dart';

import '../fresh/fresh.dart';
import '../secure_token_storage/fresh_secure_token_storage.dart';

/// Creates a [Fresh] interceptor to refresh oauth tokens
Fresh<OAuth2Token> getFreshInterceptor({
  required Future<OAuth2Token> Function(OAuth2Token?, Dio) refreshFunction,
}) {
  return Fresh.oAuth2(
    tokenStorage: FreshSecureTokenStorage(),
    refreshToken: (token, httpClient) {
      return _TokenRefreshHandler(
        token: token,
        dio: httpClient,
      ).refresh(refreshFunction);
    },
  );
}

class _TokenRefreshHandler {
  _TokenRefreshHandler({required this.token, required this.dio});

  final OAuth2Token? token;
  final Dio dio;

  static Future<OAuth2Token>? currentRefreshFunction;

  static const refreshCompleteTimeout = 10;

  Future<OAuth2Token> refresh(
    Future<OAuth2Token> Function(OAuth2Token?, Dio) refreshFunction,
  ) {
    if (currentRefreshFunction == null) {
      final future = refreshFunction(token, dio);
      currentRefreshFunction = future;

      future.whenComplete(() {
        Future.delayed(const Duration(seconds: refreshCompleteTimeout), () => currentRefreshFunction = null);
      });
    }
    return currentRefreshFunction!;
  }
}
