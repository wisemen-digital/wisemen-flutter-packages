import 'dart:async';

import 'package:wise_zitadel_login/wise_zitadel_login.dart';
import 'package:wiseclient/wiseclient.dart' show OAuth2Token;

/// A [WiseZitadelAuthenticator] that records its calls instead of running the
/// real authorization code flow.
class FakeAuthenticator implements WiseZitadelAuthenticator {
  /// Constructor for [FakeAuthenticator]
  ///
  /// Pass a [completer] to keep the login pending until the test completes it.
  FakeAuthenticator({this.token, this.completer, this.resumedToken});

  /// The token returned by [login]
  final OAuth2Token? token;

  /// The token returned by the first [prepare], as a web login that finished
  /// in an earlier page load would return it
  final OAuth2Token? resumedToken;

  /// Completes the pending [login] call, if given
  final Completer<OAuth2Token?>? completer;

  /// The login types [login] was called with, in order
  final List<ZitadelLoginType?> loginCalls = [];

  /// The number of times [prepare] was called
  int prepareCalls = 0;

  /// Whether [dispose] was called
  bool disposed = false;

  @override
  Future<OAuth2Token?> prepare() async {
    prepareCalls++;
    return prepareCalls == 1 ? resumedToken : null;
  }

  @override
  Future<OAuth2Token?> login([ZitadelLoginType? type]) {
    loginCalls.add(type);
    return completer?.future ?? Future.value(token);
  }

  @override
  Future<void> dispose() async {
    disposed = true;
  }
}
