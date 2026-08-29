# wise_zitadel_login

A Zitadel login package to be used with Wisemen backends. Provides a ready-made login screen with configurable identity provider buttons, built on top of [`oidc`](https://pub.dev/packages/oidc), `auto_route` and `hooks_riverpod`.

## Features

- Pre-built `WiseLoginScreen` with bottom aligned login buttons
- Multiple login types (IDPs) on one screen (e.g. Google, Apple, Microsoft, internal)
- Configurable button styling (color, text style, border radius, border)
- Loading state per login button while authenticating
- `auto_route` route (`WiseLoginScreenRoute`) ready to drop into your router
- Riverpod provider for flavored configuration
- Returns an `OAuthToken` from `wiseclient` on successful login

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  wise_zitadel_login: ^1.0.0
```

## Platform setup

The login flow runs in the platform's browser, which needs a little setup per
platform. Skip the platforms your app does not ship on.

### Android

Requires `minSdk 23` (the Flutter default is higher, so usually nothing to do)
and the redirect scheme of your app. The scheme has to match the `bundleId` you
pass to `WiseZitadelOptions`, since that is what the redirect URL is built from.

Add it to `android/app/build.gradle`:

```groovy
android {
    defaultConfig {
        minSdk = 23
        manifestPlaceholders += [oidcRedirectScheme: "com.example.app"]
    }
}
```

Nothing has to be added to `AndroidManifest.xml`: the activity that catches the
redirect ships with the `oidc` plugin and picks up the placeholder above.

### iOS

Requires iOS 13.0 or higher, which is below the Flutter minimum, so there is
usually nothing to do. The flow uses `ASWebAuthenticationSession`, so the
redirect scheme does not have to be registered in `Info.plist`.

Set the deployment target in Xcode and in `ios/Podfile` if your app is still on
an older one:

```ruby
platform :ios, '13.0'
```

### macOS

Requires macOS 10.15 or higher, and the network client entitlement, since the
token exchange is an outgoing request. Add it to **both**
`macos/Runner/DebugProfile.entitlements` and `macos/Runner/Release.entitlements`:

```xml
<key>com.apple.security.network.client</key>
<true/>
```

### Web

The browser comes back to a `redirect.html` page that hands the result to your
app over a `BroadcastChannel`. Copy
[`redirect.html`](https://github.com/Bdaya-Dev/oidc/blob/main/packages/oidc/example/web/redirect.html)
from the `oidc` example into your app's `web/` folder, so it is served at
`https://your-app.com/redirect.html`.

That page is versioned together with the `oidc` package: re-copy it whenever the
`oidc` dependency of this package moves to a new major version.

The login opens in a new browser tab, not in a chrome-less popup window. The tab
is opened during the tap on the login button, which is what keeps browsers from
blocking it, so the login screen fetches the discovery document up front.

### Zitadel

Whitelist the redirect URLs on the application in the Zitadel console:

- `com.example.app:/` for Android, iOS and macOS, with your own bundle id
- `https://your-app.com/redirect.html` for web


## Usage

### 1. Override the options provider

Override `wiseZitadelOptionsProvider` in your `ProviderScope` with your (usually flavored) Zitadel configuration:

```dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_zitadel_login/wise_zitadel_login.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: [
        wiseZitadelOptionsProvider.overrideWithValue(
          WiseZitadelOptions(
            zitadelBaseUrl: F.zitadelBaseUrl,
            bundleId: F.bundleId,
            applicationId: F.zitadelAppId,
            organizationId: F.zitadelOrganizationId,
            buttonOptions: WiseZitadelButtonOptions(
              color: (context) => context.backgroundColors.primary,
              buttonTextStyle: (context) => context.body.copyWith(
                color: context.foregroundColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            onLoginSuccess: (router, ref, token) async {
              if (token == null) {
                return;
              }
              await ref.read(appRepositoryServiceProvider).setToken(token);
              router.replace(const HomeScreenRoute());
            },
            supportedTypes: [
              const ZitadelLoginType(
                buttonText: 'Internal',
                iconSvgString: 'assets/icons/logo.svg',
                idp: '',
              ),
            ],
          ),
        ),
      ],
      child: const App(),
    ),
  );
}
```

### 2. Register the route

Add `WiseLoginScreenRoute` to your `auto_route` router:

```dart
import 'package:auto_route/auto_route.dart';
import 'package:wise_zitadel_login/wise_zitadel_login.dart';

@AutoRouterConfig(replaceInRouteName: '')
class AppRouter extends RootStackRouter {
  late final List<AutoRoute> routes = [
    CustomRoute(
      path: '/',
      page: SplashScreenRoute.page,
      guards: [AuthGuard(ref: ref)],
    ),
    CustomRoute(
      page: WiseLoginScreenRoute.page,
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
  ];
}
```

### 3. Navigate to the login screen

Redirect unauthenticated users to the login screen, for example from an `AutoRouteGuard`:

```dart
import 'package:auto_route/auto_route.dart';
import 'package:wise_zitadel_login/wise_zitadel_login.dart';
import 'package:wiseclient/wiseclient.dart' show AuthenticationStatus;

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final status = await ref.read(appRepositoryServiceProvider).authenticationStatus.first;
    switch (status) {
      case AuthenticationStatus.initial:
        resolver.next();
      case AuthenticationStatus.unauthenticated:
        resolver.redirectUntil(WiseLoginScreenRoute());
      case AuthenticationStatus.authenticated:
        resolver.redirectUntil(const HomeScreenRoute());
    }
  }
}
```

Optionally pass a `builder` to `WiseLoginScreenRoute` to render content behind the buttons, usually a brand's logo:

```dart
WiseLoginScreenRoute(
  builder: (context) => Center(
    child: Image.asset('assets/images/logo.png'),
  ),
)
```

## Tokens and refreshing

A successful login returns an `OAuthToken` from `wiseclient` and nothing else:
this package keeps no session of its own. It does not persist the login and it
never refreshes the token, that stays the job of the app (through `wiseclient`'s
`fresh` interceptor).

This is deliberate. Zitadel rotates refresh tokens, so a second component
refreshing in the background would invalidate the token the app is holding, and
whichever one refreshes last logs the user out.

## Testing

The login screen reads its login flow from `wiseZitadelAuthenticatorProvider`.
Override it with your own `WiseZitadelAuthenticator` to test screens behind the
login without opening a browser:

```dart
class FakeAuthenticator implements WiseZitadelAuthenticator {
  @override
  Future<OAuthToken?> login(ZitadelLoginType type) async =>
      OAuthToken(accessToken: 'access_token', refreshToken: 'refresh_token');

  @override
  Future<void> dispose() async {}
}

ProviderScope(
  overrides: [
    wiseZitadelAuthenticatorProvider.overrideWithValue(FakeAuthenticator()),
  ],
  child: const App(),
);
```


## Parameters

### WiseZitadelOptions

- `zitadelBaseUrl` (String, required): The base URL of your Zitadel instance
- `bundleId` (String, required): The app's bundle id, used for the redirect URL
- `applicationId` (String, required): The Zitadel application id
- `organizationId` (String, required): The Zitadel organization id
- `supportedTypes` (List\<ZitadelLoginType\>, required): The login types shown as buttons on the login screen
- `onLoginSuccess` (Function, required): Callback called after a login attempt, receives the `StackRouter`, `WidgetRef` and the (nullable) `OAuthToken`
- `buttonOptions` (WiseZitadelButtonOptions, required): Styling options for the login buttons

### WiseZitadelButtonOptions

- `color` (Color Function(BuildContext), required): The background color of the button
- `buttonTextStyle` (TextStyle Function(BuildContext), required): The text style of the button's text
- `borderRadius` (BorderRadius, default: circular 10): The border radius of the button
- `borderSide` (BorderSide?, optional): The border side of the button

### ZitadelLoginType

- `buttonText` (String, required): The text displayed in the button
- `iconSvgString` (String, required): The SVG asset used for the button icon, usually Google, Apple, Microsoft, etc.'s logo
- `idp` (String, required): The identity provider id used for the login, an empty id logs in through Zitadel itself

## Requirements

- Flutter SDK: >=3.19.5
- Dart SDK: >=3.10.0 <4.0.0
- Android: `minSdk` 23
- iOS: 13.0, macOS: 10.15

## Dependencies

- `oidc`: For the OAuth/OIDC authentication flow
- `auto_route`: For the login screen route
- `hooks_riverpod`: For state management and configuration
- `wiseclient`: For the `OAuthToken` type
- `wise_nav_bar` & `wisewidgetslibrary`: For platform aware UI components

## License

See LICENSE file for details.
