import '../token_model/oauth_token.dart';

/// extension to convert [OAuthTokenToMap] to [Map]
extension OAuthTokenToMap on OAuthToken {
  /// Returns [Map] from [OAuthToken]
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'tokenType': tokenType,
      'expiresIn': expiresIn,
      'refreshToken': refreshToken,
      'scope': scope,
    };
  }
}
