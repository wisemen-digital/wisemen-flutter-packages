import 'package:dio/dio.dart';

import '../fresh/fresh.dart';
import '../secure_token_storage/fresh_secure_token_storage.dart';

/// Creates a [Fresh] interceptor to refresh oauth tokens
Fresh<OAuth2Token> getFreshInterceptor({
  required Future<OAuth2Token> Function(OAuth2Token?, Dio) refreshFunction,
  required void Function(Object, StackTrace) refreshErrorHandler,
  required Duration refreshBuffer,
  int refreshCacheInSeconds = 10,
}) {
  return Fresh.oAuth2(
    tokenStorage: FreshSecureTokenStorage(),
    refreshErrorHandler: refreshErrorHandler,
    refreshBuffer: refreshBuffer,
    refreshToken: (token, httpClient) {
      return _TokenRefreshHandler(
        token: token,
        dio: httpClient,
        refreshCacheInSeconds: refreshCacheInSeconds,
      ).refresh(refreshFunction);
    },
  );
}

class _TokenRefreshHandler {
  _TokenRefreshHandler({
    required this.token,
    required this.dio,
    this.refreshCacheInSeconds = 10,
  });

  final OAuth2Token? token;
  final Dio dio;
  final int refreshCacheInSeconds;

  static Future<OAuth2Token>? currentRefreshFunction;

  Future<OAuth2Token> refresh(
    Future<OAuth2Token> Function(OAuth2Token?, Dio) refreshFunction,
  ) {
    if (currentRefreshFunction == null) {
      final future = refreshFunction(token, dio);
      currentRefreshFunction = future;

      future.whenComplete(() {
        Future.delayed(
          Duration(seconds: refreshCacheInSeconds),
          () => currentRefreshFunction = null,
        );
      });
    }
    return currentRefreshFunction!;
  }
}
