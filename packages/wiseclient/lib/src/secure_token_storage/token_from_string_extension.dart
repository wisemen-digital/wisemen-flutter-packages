import 'dart:convert' show jsonDecode;

import 'package:fresh_dio/fresh_dio.dart';

/// [OAuth2TokenFromString] to get token from secure storage
extension OAuth2TokenFromString on String {
  /// Returns [OAuth2Token] from [String]
  OAuth2Token get toOAuth2Token {
    final dynamic tokenMap = jsonDecode(this);
    return OAuth2Token(
      accessToken: (tokenMap as Map)['accessToken'] as String,
      refreshToken: tokenMap['refreshToken'] as String?,
      tokenType: tokenMap['tokenType'] as String?,
      scope: tokenMap['scope'] as String?,
      expiresIn: tokenMap['expiresIn'] as int?,
      issuedAt: tokenMap['issuedAt'] != null
          ? DateTime.parse(tokenMap['issuedAt'] as String)
          : null,
    );
  }
}
