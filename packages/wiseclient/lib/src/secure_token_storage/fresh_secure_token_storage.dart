import 'dart:convert' show jsonEncode;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wiseclient/src/token_model/oauth_token.dart';
import '../fresh/fresh.dart';
import 'map_from_token_extension.dart';
import 'token_from_string_extension.dart';

/// [FreshSecureTokenStorage] to store and keep tokens on device, implements [TokenStorage]
class FreshSecureTokenStorage implements TokenStorage<OAuthToken> {
  /// Variable token (usually Oauth) [_token]
  OAuthToken? _token;

  /// [FlutterSecureStorage] to save token on device
  final storage = const FlutterSecureStorage();

  /// String to save to [FlutterSecureStorage]
  final storageIdentifier = 'OAUTH_TOKEN';

  @override
  Future<void> delete() async {
    _token = null;
    await storage.delete(key: storageIdentifier);
  }

  @override
  Future<OAuthToken?> read() async {
    if (_token != null) return _token;
    final tokenFromStorage = await storage.read(key: storageIdentifier);
    if (tokenFromStorage != null) {
      return tokenFromStorage.toOAuthToken;
    } else {
      return null;
    }
  }

  @override
  Future<void> write(OAuthToken token) async {
    _token = token;
    await storage.write(
      key: storageIdentifier,
      value: jsonEncode(token.toMap()),
    );
  }
}
