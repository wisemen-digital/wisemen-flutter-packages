import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:oidc/oidc.dart';
import 'package:wiseclient/wiseclient.dart' show OAuthToken;

import '../options.dart';
import '../types/zitadel_login_type.dart';

/// Starts the Zitadel login flow for a [ZitadelLoginType].
///
/// Implement this to replace the login flow in tests, the login screen reads
/// its implementation from the `wiseZitadelAuthenticatorProvider`.
abstract interface class WiseZitadelAuthenticator {
  /// Prepares everything [login] needs, so that it can start the flow without
  /// waiting first. The login screen calls this when it is shown.
  ///
  /// Returns a token when a login that was started before is finished by this
  /// call instead of by [login]. On the web the authorization server sends the
  /// user back to a fresh page load, so the [login] call that started the flow
  /// is gone by the time its result arrives and this is the only place the
  /// token can surface. Everywhere else this returns `null`.
  Future<OAuthToken?> prepare();

  /// Logs in with organization id, optionally [type] and returns the resulting token, or `null` when the
  /// authorization server did not return a usable token.
  ///
  /// On the web this never returns: the flow navigates the page away and its
  /// token comes back through [prepare] on the next page load.
  Future<OAuthToken?> login([ZitadelLoginType? type]);

  /// Releases the resources held by the authenticator.
  Future<void> dispose();
}

/// [AuthenticationRepository] handles the login process using [OidcUserManager]
///
/// The manager is only used to run the authorization code flow: it keeps no
/// session past the flow and refreshes nothing. The [OAuthToken] it returns is
/// handed to the app, which stays the single owner of storing and refreshing
/// it. Running a second refresh here would race the app's own one, and with
/// refresh token rotation enabled the loser of that race is logged out.
class AuthenticationRepository implements WiseZitadelAuthenticator {
  /// Constructor for [AuthenticationRepository]
  AuthenticationRepository({
    required this.options,
    this.isWeb = kIsWeb,
  });

  /// The scopes requested on every login
  static const _baseScopes = ['openid', 'profile', 'email', 'offline_access'];

  /// The (usually flavored) Zitadel configuration
  final WiseZitadelOptions options;

  /// Whether the app runs on the web, which selects the redirect URL
  final bool isWeb;

  OidcUserManager? _manager;
  Future<OidcUserManager>? _pendingManager;
  OAuthToken? _resumedToken;

  /// The discovery document URL of the Zitadel instance
  static Uri discoveryUriFor({required WiseZitadelOptions options}) {
    return OidcUtils.getOpenIdConfigWellKnownUri(
      Uri.parse(options.zitadelBaseUrl),
    );
  }

  /// The redirect URL the authorization server sends the user back to
  ///
  /// For web platforms, we use `http://website-url.com/redirect.html`, which is
  /// the page that hands the result back to the app.
  /// For mobile platforms, we use the app's bundle id as a custom scheme.
  static Uri redirectUriFor({
    required WiseZitadelOptions options,
    required bool isWeb,
  }) {
    if (isWeb) {
      return Uri.base.replace(path: 'redirect.html');
    }
    return Uri(scheme: options.bundleId, path: '/');
  }

  /// The scopes to request for [type]
  ///
  /// Zitadel selects the organization and the identity provider through
  /// scopes, so a login type without an idp logs in through Zitadel itself.
  static List<String> scopesFor({
    required WiseZitadelOptions options,
    ZitadelLoginType? type,
  }) {
    return [
      ..._baseScopes,
      'urn:zitadel:iam:org:id:${options.organizationId}',
      if (type != null && type.idp.isNotEmpty)
        'urn:zitadel:iam:org:idp:id:${type.idp}',
    ];
  }

  /// The platform options used for the login flow
  ///
  /// Web runs the flow in the app's own tab
  /// ([OidcPlatformSpecificOptions_Web_NavigationMode.samePage]) rather than in
  /// a second one. A popup or a new tab has to be handed its result over a
  /// `BroadcastChannel`, and reaching back into the opener is exactly what
  /// cross-origin isolation is there to stop: an app that sets COOP/COEP (for
  /// `SharedArrayBuffer`, or because its host sets them) severs that handle and
  /// the login hangs. Navigating this tab needs no cross-window handle at all.
  ///
  /// The cost is a page load in the middle of the flow, which is why the flow
  /// state has to outlive the isolate, see [WiseZitadelOptions.store].
  static OidcPlatformSpecificOptions get platformOptions {
    return const OidcPlatformSpecificOptions(
      web: OidcPlatformSpecificOptions_Web(
        navigationMode: OidcPlatformSpecificOptions_Web_NavigationMode.samePage,
      ),
    );
  }

  /// The [OidcUserManagerSettings] used for the login flow
  static OidcUserManagerSettings settingsFor({
    required WiseZitadelOptions options,
    required bool isWeb,
  }) {
    return OidcUserManagerSettings(
      redirectUri: redirectUriFor(options: options, isWeb: isWeb),
      scope: scopesFor(options: options),
      options: platformOptions,
      // The app refreshes the token it receives, see the class documentation.
      refreshBefore: (token) => null,
    );
  }

  /// Maps the token of an [OidcUser] onto the [OAuthToken] of `wiseclient`
  ///
  /// Returns `null` when either token is missing, since the app cannot keep a
  /// session alive without both.
  static OAuthToken? tokenFrom(OidcToken token) {
    final accessToken = token.accessToken;
    final refreshToken = token.refreshToken;
    if (accessToken == null || refreshToken == null) {
      return null;
    }
    return OAuthToken(
      accessToken: accessToken,
      refreshToken: refreshToken,
      tokenType: token.tokenType,
      expiresIn: token.expiresIn?.inSeconds,
      scope: token.scope?.join(' '),
      issuedAt: token.creationTime,
    );
  }

  @override
  Future<OAuthToken?> prepare() async {
    await _ensureManager();
    // Handed out once: a second [prepare] on the same authenticator is a
    // rebuild of the login screen, not a second login.
    final resumed = _resumedToken;
    _resumedToken = null;
    return resumed;
  }

  @override
  Future<OAuthToken?> login([ZitadelLoginType? type]) {
    // Deliberately not awaited when the manager is ready: `oidc` opens the
    // login tab synchronously, and browsers only allow that inside the task of
    // the tap that asked for it. An await here would lose that user gesture and
    // the tab would be blocked, which is why the screen calls [prepare] first.
    final manager = _manager;
    if (manager != null) {
      return _loginWith(manager, type);
    }
    return _ensureManager().then((manager) => _loginWith(manager, type));
  }

  Future<OAuthToken?> _loginWith(
    OidcUserManager manager,
    ZitadelLoginType? type,
  ) async {
    final user = await manager.loginAuthorizationCodeFlow(
      scopeOverride: scopesFor(options: options, type: type),
      // Where `redirect.html` sends the browser once it has parked the
      // response. Without it that page has nowhere to go and the user is left
      // looking at it.
      originalUri: isWeb ? Uri.base : null,
      // The manager holds no session of its own, so a previous login must not
      // pin the next one to the same user.
      includeIdTokenHintFromCurrentUser: false,
    );

    if (isWeb && user == null) {
      // `samePage` has navigated this tab away and returns no user: the flow
      // continues in the page load that comes back, and [prepare] finishes it
      // there. Completing here instead would report the started login to the
      // app as one that produced no token, i.e. as a failure.
      return Completer<OAuthToken?>().future;
    }

    final token = user?.token;
    if (token == null) {
      return null;
    }
    return tokenFrom(token);
  }

  @override
  Future<void> dispose() async {
    final manager = _manager;
    _manager = null;
    _pendingManager = null;
    _resumedToken = null;
    await manager?.dispose();
  }

  /// Creates and initializes the manager on the first login, and reuses it
  /// afterwards so the discovery document is only fetched once.
  Future<OidcUserManager> _ensureManager() async {
    final pending = _pendingManager;
    if (pending != null) {
      return pending;
    }

    final created = _createManager();
    _pendingManager = created;
    try {
      return await created;
    } catch (_) {
      // A failed initialization must not poison the next login attempt.
      _pendingManager = null;
      rethrow;
    }
  }

  Future<OidcUserManager> _createManager() async {
    final store = options.store ?? OidcMemoryStore();
    if (isWeb && store is OidcMemoryStore) {
      throw StateError(
        'The web login navigates this tab away and comes back to a new page '
        'load, so an in-memory store loses the flow before it can finish. '
        'Pass a persistent one through WiseZitadelOptions.store, see its '
        'documentation.',
      );
    }
    await store.init();
    // Asked before `init()`, which is what consumes it: a parked authorization
    // response is the only thing that makes the user `init()` restores a login
    // this app just completed rather than a leftover from an earlier one.
    final hasPendingResponse =
        (await store.getStatesWithResponses()).isNotEmpty;

    final manager = OidcUserManager.lazy(
      discoveryDocumentUri: discoveryUriFor(options: options),
      clientCredentials: OidcClientAuthentication.none(
        clientId: options.applicationId,
      ),
      store: store,
      settings: settingsFor(options: options, isWeb: isWeb),
    );
    await manager.init();

    if (hasPendingResponse) {
      final token = manager.currentUser?.token;
      _resumedToken = token == null ? null : tokenFrom(token);
    }
    // The store survives the page load on web, the session must not: the app
    // owns the token from here on, and a rotated refresh token left behind in
    // browser storage is a logout waiting to happen.
    await manager.forgetUser();

    _manager = manager;
    return manager;
  }
}
