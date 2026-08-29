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
