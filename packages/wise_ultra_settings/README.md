# wise_ultra_settings

A customizable settings screen package for Flutter apps using Wisemen backends in the ULTRA context. This package provides a ready-to-use settings interface with profile management, app theme selection, version information, and navigation to legal documents.

## Features

- Pre-built settings screen with customizable sections and items
- Profile management with user information display
- App theme selection (light, dark, system)
- App version display
- Navigation to privacy policy and terms & conditions
- Logout functionality
- Fully customizable sections and items through abstract interfaces
- Built with Riverpod for state management
- Integration with AutoRoute for navigation
- Localization support

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  wise_ultra_settings:
    git:
      url: https://github.com/wisemen-digital/wisemen-flutter-packages.git
      path: packages/wise_ultra_settings
```

## Getting Started

### 1. Initialize the Settings Feature

Before using the settings screen, you must initialize the `SettingsFeature` with your app-specific implementations:

```dart
import 'package:wise_ultra_settings/wise_ultra_settings.dart';

void main() {
  SettingsFeature.init(
    settingsLocalizations: YourLocalizationsImpl(),
    settingsAssets: YourAssetsImpl(),
    settingsNavigationManager: yourNavigationManagerProvider,
    settingsFlavors: YourFlavorsImpl(),
    settingsRepository: yourRepositoryProvider, // Optional
  );

  runApp(MyApp());
}
```

### 2. Implement Required Interfaces

#### SettingsLocalizations

Provide localized strings for the settings screen:

```dart
class YourLocalizationsImpl implements SettingsLocalizations {
  @override
  String get logout => 'Logout';

  @override
  String personalInfo(BuildContext context) => 'Personal Info';

  @override
  String notificationSettings(BuildContext context) => 'Notifications';

  @override
  String appTheme(BuildContext context) => 'App Theme';

  @override
  String appVersion(BuildContext context) => 'App Version';

  @override
  String termsAndConditions(BuildContext context) => 'Terms and Conditions';

  @override
  String privacyPolicy(BuildContext context) => 'Privacy Policy';

  @override
  String profileManagement(BuildContext context) => 'Profile Management';

  @override
  String appInfo(BuildContext context) => 'App Info';

  @override
  String appLanguage(BuildContext context) => 'Language';

  @override
  String lightMode(BuildContext context) => 'Light';

  @override
  String darkMode(BuildContext context) => 'Dark';

  @override
  String system(BuildContext context) => 'System';

  @override
  String done(BuildContext context) => 'Done';
}
```

#### SettingsAssets

Provide asset paths for the settings screen:

```dart
class YourAssetsImpl implements SettingsAssets {
  @override
  String get chevronRight => 'assets/icons/chevron_right.svg';
}
```

#### SettingsNavigationManager

Implement navigation logic for settings items:

```dart
@Riverpod(keepAlive: true)
class YourNavigationManager extends _$YourNavigationManager
    implements SettingsNavigationManager {

  @override
  void build() {}

  @override
  void navigateToPersonalInfo() {
    // Navigate to personal info screen
  }

  @override
  void navigateToNotifications() {
    // Navigate to notifications screen
  }

  @override
  void navigateToAppTheme() {
    // Navigate to app theme screen
  }

  @override
  void navigateToPrivacyPolicy() {
    // Open privacy policy URL or navigate to screen
  }

  @override
  void navigateToTermsAndConditions() {
    // Open terms and conditions URL or navigate to screen
  }

  @override
  void navigateToAppLanguage() {
    // Navigate to language selection screen
  }

  @override
  void logout() {
    // Handle logout logic
  }
}
```

#### SettingsFlavors

Provide URLs for legal documents:

```dart
class YourFlavorsImpl implements SettingsFlavors {
  @override
  String get privacyPolicyUrl => 'https://yourapp.com/privacy';

  @override
  String get termsAndConditionsUrl => 'https://yourapp.com/terms';
}
```

#### SettingsRepository (Optional)

If you want to display user information, implement this interface:

```dart
@Riverpod(keepAlive: true)
class YourSettingsRepository extends _$YourSettingsRepository
    implements SettingsRepository {

  @override
  Stream<User?> build() {
    return watchCurrentUser();
  }

  @override
  Stream<User?> watchCurrentUser() {
    // Return a stream of the current user
  }
}
```

### 3. Use the Settings Screen

Add the `SettingsScreen` to your AutoRoute configuration:

```dart
AutoRoute(page: SettingsRoute.page),
```

Navigate to the settings screen:

```dart
context.router.push(const SettingsRoute());
```

## Customization

### Custom Settings Sections

You can create custom settings sections by implementing the `SettingsSection` interface:

```dart
enum CustomSettingsSection implements SettingsSection {
  myCustomSection;

  @override
  List<SettingsItem> getItems() {
    return [CustomSettingsItem.customItem1, CustomSettingsItem.customItem2];
  }

  @override
  String getTitle(BuildContext context) {
    return 'My Custom Section';
  }
}
```

### Custom Settings Items

Create custom settings items by implementing the `SettingsItem` interface:

```dart
enum CustomSettingsItem implements SettingsItem {
  customItem1,
  customItem2;

  @override
  String getTitle(BuildContext context) {
    switch (this) {
      case CustomSettingsItem.customItem1:
        return 'Custom Item 1';
      case CustomSettingsItem.customItem2:
        return 'Custom Item 2';
    }
  }

  @override
  String? getTrailingText(WidgetRef ref) {
    // Return optional trailing text
    return null;
  }

  @override
  Widget? getTrailingWidget(BuildContext context) {
    // Return optional trailing widget (e.g., switch, icon)
    return null;
  }

  @override
  GestureTapCallback? onTap(WidgetRef ref) {
    return () {
      // Handle tap
    };
  }
}
```

### Custom Settings Screen

Pass your custom sections to the `SettingsScreen`:

```dart
SettingsScreen(
  sections: [
    BaseSettingsSection.profileManagement,
    CustomSettingsSection.myCustomSection,
    BaseSettingsSection.appInfo,
    BaseSettingsSection.logout,
  ],
)
```

## Base Settings

The package includes default settings sections and items:

### Base Sections

- **profileManagement**: Contains personal info, notifications, theme, and language
- **appInfo**: Contains app version, terms, and privacy policy
- **logout**: Contains the logout button

### Base Items

- **personalInfo**: Navigate to personal information screen
- **notificationSettings**: Navigate to notification settings
- **appTheme**: Navigate to theme selection (uses built-in `AppThemeScreen`)
- **appLanguage**: Navigate to language selection
- **appVersion**: Display app version (read-only)
- **privacyPolicy**: Navigate to privacy policy
- **termsAndConditions**: Navigate to terms and conditions
- **logout**: Trigger logout action

## Models

### User

The `User` model represents user information displayed in the settings screen:

```dart
final user = User(
  uuid: '123',
  firstName: 'John',
  lastName: 'Doe',
  profilePictureUrl: 'https://example.com/profile.jpg', // Optional
);
```

## Architecture

This package follows a feature-based architecture with:

- **Models**: Data classes (e.g., `User`)
- **Repositories**: Data sources (e.g., `SettingsRepository`)
- **Providers**: Riverpod state management
- **Screens**: UI screens (e.g., `SettingsScreen`, `AppThemeScreen`)
- **Widgets**: Reusable UI components
- **Enums**: Type-safe settings sections and items
- **Managers**: Navigation and business logic
- **Localizations**: Internationalization support
- **Assets**: Asset paths
- **Flavors**: Environment-specific configuration

## Dependencies

This package depends on:

- `flutter` and `flutter_riverpod`: Core Flutter and state management
- `wisecore`, `wise_theming`, `wisewidgetslibrary`, `wise_nav_bar`: Wisemen UI components
- `wiseclient`: HTTP client for API calls
- `auto_route`: Navigation
- `package_info_plus`: App version information
- `flutter_svg`: SVG asset support

## License

Copyright (c) Wisemen Digital
