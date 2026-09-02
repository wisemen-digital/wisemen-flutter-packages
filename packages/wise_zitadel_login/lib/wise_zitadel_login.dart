/// Wise Zitadel Login package
library wise_zitadel_login;

// The pieces of `oidc` an app needs to give `WiseZitadelOptions.store` a store
// of its own. The store a web app wants, `OidcWebStore`, is not among them: it
// lives in `oidc_web_core`, which only compiles for the web, so a web app adds
// that package itself rather than through this one.
export 'package:oidc/oidc.dart'
    show OidcMemoryStore, OidcReadOnlyStore, OidcStore, OidcStoreNamespace;

export 'src/options.dart';
export 'src/providers/wise_zitadel_provider.dart';
export 'src/repository/auth_repository.dart' show WiseZitadelAuthenticator;
export 'src/routes/wise_login_screen_route.dart';
export 'src/screens/wise_login_screen.dart';
export 'src/types/zitadel_login_type.dart';
