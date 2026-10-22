import 'dart:convert' show jsonDecode;

import 'package:fresh_dio/fresh_dio.dart';

import '../exceptions/token_parse_exception.dart';

/// [OAuth2TokenFromString] to get token from secure storage
extension OAuth2TokenFromString on String {
  /// Returns [OAuth2Token] from [String]
  ///
  /// Throws a [TokenParseException] when the string is not a valid token.
  OAuth2Token get toOAuth2Token {
    final Object? tokenMap;
    try {
      tokenMap = jsonDecode(this);
    } on FormatException catch (e) {
      throw TokenParseException('invalid json: ${e.message}');
    }
    if (tokenMap is! Map<String, dynamic>) {
      throw TokenParseException('expected a json object');
    }
    final accessToken = tokenMap['accessToken'];
    if (accessToken is! String) {
      throw TokenParseException('missing accessToken');
    }
    final issuedAt = tokenMap._field<String>('issuedAt');
    final parsedIssuedAt = issuedAt != null
        ? DateTime.tryParse(issuedAt)
        : null;
    if (issuedAt != null && parsedIssuedAt == null) {
      throw TokenParseException('invalid issuedAt: $issuedAt');
    }
    return OAuth2Token(
      accessToken: accessToken,
      refreshToken: tokenMap._field<String>('refreshToken'),
      tokenType: tokenMap._field<String>('tokenType'),
      scope: tokenMap._field<String>('scope'),
      expiresIn: tokenMap._field<int>('expiresIn'),
      issuedAt: parsedIssuedAt,
    );
  }
}

extension on Map<String, dynamic> {
  /// Returns the optional field [key], throwing a [TokenParseException] when it
  /// is present but not a [T]
  T? _field<T>(String key) {
    final value = this[key];
    if (value != null && value is! T) {
      throw TokenParseException('invalid $key: $value');
    }
    return value as T?;
  }
}
