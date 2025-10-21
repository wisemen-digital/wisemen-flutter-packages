# wise_ultra_login

A Zitadel OAuth2-based authentication package for Wisemen Flutter applications in the context of the ULTRA system.

[![pub package](https://img.shields.io/badge/pub-v1.0.0-blue)](https://pub.dev/packages/wise_ultra_login)

## Features

- **Multiple Authentication Methods**: Support for Apple, Google, Email, and custom identity providers
- **OAuth2/OIDC Integration**: Full Zitadel integration with OpenID Connect flow
- **Secure Token Management**: Uses `flutter_secure_storage` for secure ID token persistence
- **Token Refresh**: Automatic token refresh capability with comprehensive error handling
- **Logout with Confirmation**: Optional logout confirmation dialog with platform-specific styling
- **Loading State Management**: Per-method loading indicators during authentication
- **Custom Branding**: Support for custom splash images, localizations, and assets
- **Cross-Platform Support**: Works on Web, iOS, and Android

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  wise_ultra_login:
    git:
      url: https://github.com/wisemen-digital/wisemen-flutter-packages.git
      ref: main
      path: packages/wise_ultra_login
```

Then run:

```bash
flutter pub get
```

## Platform Setup

### iOS Configuration

Add the following to your `Info.plist`:

```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLName</key>
    <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
    </array>
  </dict>
</array>
```

For Sign in with Apple, enable the capability in Xcode:
1. Open your project in Xcode
2. Select your target
3. Go to "Signing & Capabilities"
4. Click "+ Capability"
5. Add "Sign in with Apple"

### Android Configuration

Add the following intent filter to your `AndroidManifest.xml` inside the `<activity>` tag:

```xml
<intent-filter>
  <action android:name="android.intent.action.VIEW" />
  <category android:name="android.intent.category.DEFAULT" />
  <category android:name="android.intent.category.BROWSABLE" />
  <data android:scheme="YOUR_BUNDLE_ID" />
</intent-filter>
```

Replace `YOUR_BUNDLE_ID` with your actual bundle ID.

### Web Configuration

For web support, the redirect URI should be: `{base_url}/auth.html`

Ensure your Zitadel application is configured with the correct redirect URI and CORS settings.

## Usage

### 1. Implement Required Interfaces

You must implement three interfaces to configure the login feature:

#### LoginFlavors

Provides OAuth2 and application configuration:

```dart
class AppLoginFlavors implements LoginFlavors {
  @override
  String get authenticationUrl => 'https://auth.example.com';

  @override
  String get bundleId => 'com.example.myapp';

  @override
  String get clientID => 'my-client-id@myproject';

  @override
  String get organizationID => '123456789';

  @override
  List<LoginMethod> get loginMethods => [
    LoginMethod(id: 'google-idp', name: 'Google', type: LoginType.google),
    LoginMethod(id: 'apple-idp', name: 'Apple', type: LoginType.apple),
    LoginMethod(id: 'email-idp', name: 'Email', type: LoginType.email),
  ];

  @override
  String get splashImage => 'https://example.com/splash.jpg';
}
```

#### LoginLocalizations

Provides localized strings for the UI:

```dart
class AppLoginLocalizations implements LoginLocalizations {
  @override
  String get logout => 'Log Out';

  @override
  String get logoutWarning => 'Are you sure you want to log out?';

  @override
  String get cancel => 'Cancel';

  @override
  String loginTitle(BuildContext context) => 'Welcome';

  @override
  String loginSubtitle(BuildContext context) => 'Sign in to continue';

  @override
  String loginMethod(BuildContext context, String value) => 'Sign in with $value';

  @override
  String email(BuildContext context) => 'Email';
}
```

#### LoginAssets

Provides paths to images and icons:

```dart
class AppLoginAssets implements LoginAssets {
  @override
  String get splashImage => 'assets/images/login_splash.png';

  @override
  String get google => 'assets/icons/google.svg';

  @override
  String get apple => 'assets/icons/apple.svg';

  @override
  String get email => 'assets/icons/email.svg';
}
```

### 2. Initialize the Package

Initialize `LoginFeature` before using any login functionality, typically in your `main()` function:

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  LoginFeature.init(
    loginLocalizations: AppLoginLocalizations(),
    loginAssets: AppLoginAssets(),
    loginFlavors: AppLoginFlavors(),
  );

  runApp(const MyApp());
}
```

### 3. Add LoginScreen to Your App

Use the `LoginScreen` widget in your navigation flow:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => LoginScreen(
      belowTitleHeader: Text('Welcome back!'),
      footer: TermsAndConditionsWidget(),
    ),
  ),
);
```

The `LoginScreen` widget accepts optional customization:
- `belowTitleHeader`: Widget displayed below the title and subtitle
- `footer`: Widget displayed at the bottom of the login options

### 4. Handle Login and Logout

Access login functionality through the `LoginController`:

```dart
// Login with a specific method
final loginMethod = LoginMethod(
  id: 'google-idp',
  name: 'Google',
  type: LoginType.google,
);
await ref.read(loginControllerProvider.notifier).login(loginMethod);

// Logout with confirmation dialog
await ref.read(loginControllerProvider.notifier).logout(needsConfirmation: true);

// Logout without confirmation
await ref.read(loginControllerProvider.notifier).logout();
```

### 5. Watch Authentication State

Monitor authentication state in your UI:

```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(loginControllerProvider);

    return authState.when(
      data: (_) => Text('Logged in successfully'),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Login failed: $error'),
    );
  }
}
```

## Architecture

### Package Structure

```
wise_ultra_login/
├── lib/
│   ├── wise_ultra_login.dart           # Main barrel export
│   └── src/features/login/
│       ├── login_feature.dart          # Feature configuration
│       ├── screens/
│       │   └── login_screen.dart       # Main UI component
│       ├── controllers/
│       │   └── login_controller.dart   # State management (Riverpod)
│       ├── providers/
│       │   └── login_providers.dart    # Riverpod providers
│       ├── repository/
│       │   ├── login_repository.dart   # Abstract interface
│       │   └── base_login_repository.dart # Zitadel implementation
│       ├── models/
│       │   └── login_method.dart       # Authentication method model
│       ├── enums/
│       │   └── login_type.dart         # Login type enumeration
│       ├── flavors/
│       │   └── login_flavors.dart      # Configuration interface
│       ├── localizations/
│       │   └── login_localizations.dart # Localization interface
│       └── assets/
│           └── login_assets.dart       # Assets interface
```

### Data Flow

```
User initiates login
    ↓
LoginScreen displays supported methods
    ↓
User selects method → LoginController.login()
    ↓
BaseLoginRepository handles OAuth2 flow via flutter_appauth
    ↓
Zitadel OIDC server authorization
    ↓
Token received and stored securely
    ↓
Token registered with Wisecore.protectedClientProvider
    ↓
LoginScreen updates state → user authenticated
```

### Token Refresh Flow

```
Protected HTTP request made
    ↓
Token expired (401/400 response)
    ↓
BaseLoginRepository.refresh() called
    ↓
Refresh token sent to Zitadel
    ↓
New token received → Wisecore.protectedClientProvider updated
    ↓
Request retried OR logout on failure
```

## API Reference

### LoginFeature

Central configuration class for the login feature.

```dart
LoginFeature.init({
  required LoginLocalizations loginLocalizations,
  required LoginAssets loginAssets,
  required LoginFlavors loginFlavors,
  Provider<LoginRepository>? loginRepository,
});
```

### LoginScreen

Main login screen widget with animated UI and multiple authentication options.

```dart
LoginScreen({
  Widget? belowTitleHeader,
  Widget? footer,
})
```

### LoginController

Riverpod controller for managing authentication operations.

**Methods:**
- `login(LoginMethod method)`: Initiates OAuth2 login flow
- `logout({bool needsConfirmation = false})`: Logs out with optional confirmation

### LoginMethod

Represents a single authentication method.

```dart
LoginMethod({
  required String id,
  required String name,
  required LoginType type,
})
```

**Methods:**
- `getTitle(BuildContext context)`: Returns localized display title
- `getIconAsset()`: Returns SVG icon path or null

### LoginType

Enumeration of supported authentication types:
- `LoginType.apple`: Sign in with Apple
- `LoginType.google`: Sign in with Google
- `LoginType.email`: Email/password authentication
- `LoginType.other`: Custom identity provider

### LoginRepository

Abstract interface for authentication operations.

**Methods:**
- `getSupportedLoginMethods()`: Returns available login methods
- `login(LoginMethod method)`: Performs OAuth2 authorization
- `logout()`: Ends session and revokes tokens
- `refresh(OAuth2Token? token)`: Refreshes expired access token

## Custom Repository Implementation

You can provide a custom repository implementation for advanced scenarios:

```dart
class CustomLoginRepository implements LoginRepository {
  @override
  List<LoginMethod> getSupportedLoginMethods() {
    // Custom implementation
  }

  @override
  Future<void> login(LoginMethod method) async {
    // Custom OAuth2 flow
  }

  @override
  Future<void> logout() async {
    // Custom logout logic
  }

  @override
  Future<OAuth2Token> refresh(OAuth2Token? token) async {
    // Custom token refresh
  }
}

// Initialize with custom repository
LoginFeature.init(
  loginRepository: Provider((ref) => CustomLoginRepository()),
  loginLocalizations: AppLoginLocalizations(),
  loginAssets: AppLoginAssets(),
  loginFlavors: AppLoginFlavors(),
);
```

## Dependencies

This package depends on:

- `flutter`: Flutter SDK
- `wisecore`: Core Wisemen utilities and HTTP client
- `wise_theming`: Wisemen theming system
- `wisewidgetslibrary`: Wisemen widget library
- `flutter_appauth`: OAuth2/OIDC native implementation
- `flutter_custom_tabs`: Custom browser tabs for auth flow
- `riverpod`: Reactive state management
- `wiseclient`: HTTP client with token management
- `flutter_svg`: SVG rendering for icons
- `flutter_platform_alert`: Native platform dialogs

## License

Copyright (c) Wisemen. All rights reserved.

## Support

For issues, questions, or contributions, please contact the Wisemen development team.
