import 'dart:convert' show jsonDecode;

import '../token_model/oauth_token.dart';

/// [OAuthTokenFromString] to get token from secure storage
extension OAuthTokenFromString on String {
  /// Returns [OAuthToken] from [String]
  OAuthToken get toOAuthToken {
    final dynamic tokenMap = jsonDecode(this);
    return OAuthToken(
      accessToken: (tokenMap as Map)['accessToken'] as String,
      refreshToken: tokenMap['refreshToken'] as String?,
      tokenType: tokenMap['tokenType'] as String?,
      scope: tokenMap['scope'] as String?,
      expiresIn: tokenMap['expiresIn'] as int?,
    );
  }
}
