# Wise Ultra Update

A Flutter package for managing app update notifications with customizable UI and behavior.

## Features

- 🔄 **Automatic Update Checking**: Checks for app updates on app launch and resume
- 🎨 **Customizable UI**: Fully customizable update dialog with theming support
- 🔧 **Flexible Configuration**: Support for required and optional updates
- 📱 **Platform Agnostic**: Works on iOS and Android
- 🧪 **Well Tested**: 87.4% test coverage with 106 passing tests
- 🏗️ **Clean Architecture**: Built with Riverpod for state management

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  wise_ultra_update: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

### 1. Initialize the Update Feature

First, initialize the update feature in your app's main function:

```dart
import 'package:wise_ultra_update/wise_ultra_update.dart';

void main() {
  // Initialize the update feature
  UpdateFeature.init(
    updateLocalizations: MyUpdateLocalizations(),
    updateAssets: MyUpdateAssets(),
    updateNavigationManager: Provider((ref) => MyUpdateNavigationManager()),
  );
  
  runApp(MyApp());
}
```

### 2. Implement Required Interfaces

#### Update Localizations

```dart
class MyUpdateLocalizations implements UpdateLocalizations {
  @override
  String get newUpdateAvailableTitle => 'Update Available';

  @override
  String get newUpdateAvailableSubtitle => 'A new version of the app is available';

  @override
  String get installUpdate => 'Update Now';

  @override
  String get illDoThisLater => 'Later';
}
```

#### Update Assets

```dart
class MyUpdateAssets implements UpdateAssets {
  @override
  String? get avatar => 'assets/images/app_icon.png'; // Optional
}
```

#### Update Navigation Manager

```dart
class MyUpdateNavigationManager implements UpdateNavigationManager {
  @override
  void installUpdate() {
    // Navigate to app store or trigger update process
    // Example: launch app store URL
  }

  @override
  void installLater() {
    // Handle "later" action (usually just dismiss)
  }
}
```

### 3. Wrap Your App with UpdateWrapper

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: UpdateWrapper(
          child: MyHomePage(),
        ),
      ),
    );
  }
}
```

## Advanced Usage

### Manual Update Check

You can manually trigger an update check:

```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        await UpdateController.showUpdateDialogIfNeeded(context, ref);
      },
      child: Text('Check for Updates'),
    );
  }
}
```

### Custom Update Repository

You can provide your own update repository implementation:

```dart
class MyUpdateRepository implements UpdateRepository {
  @override
  Future<(bool, bool)> checkNeedsUpdate() async {
    // Your custom update checking logic
    // Returns (needsUpdate, isRequired)
    return (true, false);
  }
}

// Initialize with custom repository
UpdateFeature.init(
  updateLocalizations: MyUpdateLocalizations(),
  updateAssets: MyUpdateAssets(),
  updateNavigationManager: Provider((ref) => MyUpdateNavigationManager()),
  updateRepository: Provider((ref) => MyUpdateRepository()),
);
```

### Direct Widget Usage

You can also use the update widget directly:

```dart
UpdateWidget(
  isRequired: true, // or false for optional updates
)
```

## API Reference

### Core Classes

#### `UpdateFeature`
Main entry point for initializing the update feature.

```dart
static void init({
  required UpdateLocalizations updateLocalizations,
  required UpdateAssets updateAssets,
  required Provider<UpdateNavigationManager> updateNavigationManager,
  Provider<UpdateRepository>? updateRepository,
})
```

#### `UpdateWrapper`
Widget that automatically checks for updates and shows dialogs.

```dart
UpdateWrapper({
  required Widget child,
  Key? key,
})
```

#### `UpdateController`
Controller for manually triggering update checks.

```dart
static Future<void> showUpdateDialogIfNeeded(
  BuildContext context,
  WidgetRef ref,
)
```

### Interfaces

#### `UpdateLocalizations`
Interface for providing localized strings.

```dart
abstract class UpdateLocalizations {
  String get newUpdateAvailableTitle;
  String get newUpdateAvailableSubtitle;
  String get installUpdate;
  String get illDoThisLater;
}
```

#### `UpdateAssets`
Interface for providing assets like icons.

```dart
abstract class UpdateAssets {
  String? get avatar;
}
```

#### `UpdateNavigationManager`
Interface for handling navigation actions.

```dart
abstract class UpdateNavigationManager {
  void installUpdate();
  void installLater();
}
```

#### `UpdateRepository`
Interface for custom update checking logic.

```dart
abstract class UpdateRepository {
  Future<(bool, bool)> checkNeedsUpdate();
}
```

## Version Comparison

The package includes a robust version comparison function:

```dart
bool isVersionLower(String current, String latest)
```

This function:
- Handles semantic versioning (e.g., "1.2.3")
- Supports different version lengths
- Handles non-numeric parts gracefully
- Properly compares multi-digit version numbers

## Behavior

### Update Check Triggers
- App launch (when `UpdateWrapper` is first built)
- App resume (when app comes back from background)

### Update Dialog Logic
- **Required Updates**: Always shown, no "Later" button
- **Optional Updates**: Shown once per session, includes "Later" button
- **No Updates**: No dialog shown

### State Management
The package uses Riverpod for state management and includes:
- `hasShownUpdateProvider`: Tracks whether an optional update dialog has been shown

## Testing

The package is thoroughly tested with 87.4% coverage. Run tests with:

```bash
flutter test --coverage
```

## Dependencies

- `flutter`: SDK
- `hooks_riverpod`: State management
- `package_info_plus`: Getting app version
- `wisecore`: Network requests
- `wise_theming`: UI theming

## Contributing

Contributions are welcome! Please read the contributing guidelines before submitting PRs.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
