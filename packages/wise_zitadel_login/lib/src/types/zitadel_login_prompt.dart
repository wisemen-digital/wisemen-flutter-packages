import 'package:oidc/oidc.dart' show OidcConstants_AuthorizeRequest_Prompt;

/// What the authorization server asks the user before it returns a token
///
/// Zitadel keeps a session of its own in the browser the login runs in, so a
/// user who logged in before is usually sent straight back with a new token
/// without ever seeing a screen. This is the OIDC `prompt` parameter, which is
/// what overrides that.
///
/// Leaving `WiseZitadelOptions.prompt` out sends no `prompt` at all and lets
/// Zitadel reuse that session.
enum ZitadelLoginPrompt {
  /// Authenticate again, even when a Zitadel session is still open
  ///
  /// This is what makes every login start from the credentials screen.
  login(OidcConstants_AuthorizeRequest_Prompt.login),

  /// Ask which account to continue with
  ///
  /// Shows the account picker for a user with more than one session, rather
  /// than the credentials screen.
  selectAccount(OidcConstants_AuthorizeRequest_Prompt.selectAccount),

  /// Ask the user to consent to the requested scopes again
  consent(OidcConstants_AuthorizeRequest_Prompt.consent);

  const ZitadelLoginPrompt(this.value);

  /// The value sent as the `prompt` parameter of the authorization request
  final String value;
}
