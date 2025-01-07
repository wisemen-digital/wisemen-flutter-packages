import 'package:fresh_dio/fresh_dio.dart';

/// OAuth2Token extended with some factories
class OAuthToken extends OAuth2Token {
  /// Constructor that calls super arguments
  OAuthToken({
    required super.accessToken,
    super.expiresIn,
    super.refreshToken,
    super.scope,
    super.tokenType,
  });

  /// [OAuthToken] factory to get token from snake cased json
  factory OAuthToken.fromSnakeCase(Map<String, dynamic> map) {
    return OAuthToken(
      accessToken: map['access_token'] as String,
      tokenType: map['token_type'] != null ? map['token_type'] as String : null,
      expiresIn: map['expires_in'] != null ? map['expires_in'] as int : null,
      refreshToken:
          map['refresh_token'] != null ? map['refresh_token'] as String : null,
      scope: map['scope'] != null ? map['scope'] as String : null,
    );
  }

  /// [OAuthToken] factory to get token from snake cased json
  factory OAuthToken.fromCamelCasing(Map<String, dynamic> map) {
    return OAuthToken(
      accessToken: map['accessToken'] as String,
      tokenType: map['tokenType'] != null ? map['tokenType'] as String : null,
      expiresIn: map['expiresIn'] != null ? map['expiresIn'] as int : null,
      refreshToken:
          map['refreshToken'] != null ? map['refreshToken'] as String : null,
      scope: map['scope'] != null ? map['scope'] as String : null,
    );
  }
}
