# wise_zitadel_login

A Zitadel login package to be used with Wisemen backends. Provides a ready-made login screen with configurable identity provider buttons, built on top of `flutter_appauth`, `auto_route` and `hooks_riverpod`.

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
  wise_zitadel_login: ^0.0.2
```

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
- `idp` (String, required): The identity provider id used for the login

## Requirements

- Flutter SDK: >=3.19.5
- Dart SDK: >=3.6.0 <4.0.0

## Dependencies

- `flutter_appauth`: For the OAuth/OIDC authentication flow
- `auto_route`: For the login screen route
- `hooks_riverpod`: For state management and configuration
- `wiseclient`: For the `OAuthToken` type
- `wise_nav_bar` & `wisewidgetslibrary`: For platform aware UI components

## License

See LICENSE file for details.
