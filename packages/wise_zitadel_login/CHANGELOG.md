# 1.2.0

- The web login runs in the app's own tab (`samePage`) instead of opening a
  second one, so it no longer needs to reach back into an opener window and
  works in a cross-origin isolated app
- Added `WiseZitadelOptions.store`, which the flow keeps its authorization state
  in. It is in-memory when left out; a web app has to pass a persistent one,
  since the redirect brings a page load with it
- `WiseZitadelAuthenticator.prepare` returns a `Future<OAuthToken?>` and yields
  the token of a web login that finished in an earlier page load.
  `WiseLoginScreen` reports it through `onLoginSuccess`

# 1.1.0

- `login` no longer requires a `ZitadelLoginType`: uses only organization id by default

# 1.0.1

- Reverted redirect url to redirect.html from auth.html

# 1.0.0

- Replaced `flutter_appauth` with `oidc` for the login flow, adding web support
- Added `wiseZitadelAuthenticatorProvider`, which the login screen runs its login
  flow through and which can be overridden with a fake in tests
- `login` method moved from `ZitadelLoginType` to `WiseZitadelAuthenticator`

# 0.0.3

- Updated dependencies

# 0.0.2

- Updated riverpod dependencies

# 0.0.1

- Initial release
