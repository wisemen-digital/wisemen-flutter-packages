import 'dart:async' show Zone;
import 'dart:convert' show jsonEncode;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'map_from_token_extension.dart';
import 'token_from_string_extension.dart';

/// [FreshSecureTokenStorage] to store and keep tokens on device, implements [TokenStorage]
class FreshSecureTokenStorage implements TokenStorage<OAuth2Token> {
  /// Variable token (usually Oauth) [_token]
  OAuth2Token? _token;

  /// [FlutterSecureStorage] to save token on device
  final storage = const FlutterSecureStorage(
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  /// String to save to [FlutterSecureStorage]
  final storageIdentifier = 'OAUTH_TOKEN_STORAGE';

  @override
  Future<void> delete() async {
    _token = null;
    await storage.delete(key: storageIdentifier);
  }

  @override
  Future<OAuth2Token?> read() async {
    if (_token != null) return _token;
    try {
      final tokenFromStorage = await storage.read(key: storageIdentifier);
      return tokenFromStorage?.toOAuth2Token;
    } on Exception catch (error, stackTrace) {
      await _deleteUnreadableToken();
      Zone.current.handleUncaughtError(error, stackTrace);
      return null;
    }
  }

  Future<void> _deleteUnreadableToken() async {
    try {
      await storage.delete(key: storageIdentifier);
    } on Exception {
      // The read error is already being reported, and a token that can't be
      // read can't authenticate anyone either.
    }
  }

  @override
  Future<void> write(OAuth2Token token) async {
    _token = token;
    await storage.write(
      key: storageIdentifier,
      value: jsonEncode(token.toMap()),
    );
  }
}
