import 'package:fresh_dio/fresh_dio.dart';

/// Extension to parse an [OAuth2Token] from a decoded json [Map]
extension OAuth2TokenFromMap on Map<String, dynamic> {
  /// Returns [OAuth2Token] from snake cased json, as returned by most OAuth
  /// servers. [OAuth2Token.issuedAt] defaults to now when absent.
  OAuth2Token toOAuth2TokenFromSnakeCase() {
    return OAuth2Token(
      accessToken: this['access_token'] as String,
      tokenType: this['token_type'] as String?,
      expiresIn: this['expires_in'] as int?,
      refreshToken: this['refresh_token'] as String?,
      scope: this['scope'] as String?,
      issuedAt: this['issued_at'] != null
          ? DateTime.parse(this['issued_at'] as String)
          : DateTime.now(),
    );
  }

  /// Returns [OAuth2Token] from camel cased json.
  /// [OAuth2Token.issuedAt] defaults to now when absent.
  OAuth2Token toOAuth2TokenFromCamelCase() {
    return OAuth2Token(
      accessToken: this['accessToken'] as String,
      tokenType: this['tokenType'] as String?,
      expiresIn: this['expiresIn'] as int?,
      refreshToken: this['refreshToken'] as String?,
      scope: this['scope'] as String?,
      issuedAt: this['issuedAt'] != null
          ? DateTime.parse(this['issuedAt'] as String)
          : DateTime.now(),
    );
  }
}
