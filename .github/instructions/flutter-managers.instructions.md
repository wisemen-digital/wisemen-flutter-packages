---
description: 'Flutter managers architecture for feature decoupling. Use when: creating navigation managers, widget managers, implementing cross-feature communication, setting up feature initialization. Keywords: NavigationManager, WidgetManager, Feature decoupling, cross-feature communication, abstract interface, Provider, dependency injection.'
applyTo: '**/managers/**'
---

# Flutter Managers Guidelines

Managers provide cross-feature communication by abstracting navigation and widget dependencies. This enables features to remain independent while still interacting with each other.

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     APP LAYER                               │
│  feature_init_util.dart (wires implementations to features) │
└─────────────────────────────────────────────────────────────┘
                            │
         ┌──────────────────┴──────────────────┐
         ▼                                     ▼
┌─────────────────────────┐     ┌─────────────────────────────┐
│    ROUTER LAYER         │     │    WIDGET MANAGERS LAYER    │
│  Concrete implementations│     │  Concrete implementations   │
│  of navigation managers │     │  of widget managers         │
│  (lib/router/managers/) │     │  (lib/widget_managers/)     │
└─────────────────────────┘     └─────────────────────────────┘
         │                                     │
         └──────────────────┬──────────────────┘
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                    FEATURE LAYER                            │
│  Abstract interfaces defined in features/*/managers/        │
│  Feature doesn't know about implementations                 │
└─────────────────────────────────────────────────────────────┘
```

## Manager Types

| Type | Purpose | Location (Abstract) | Location (Implementation) |
|------|---------|---------------------|---------------------------|
| `NavigationManager` | Handle navigation between features | `features/*/managers/` | `lib/router/managers/` |
| `WidgetManager` | Provide widgets from other features | `features/*/managers/` | `lib/widget_managers/` |

## File Structure

```
lib/
├── feature_init_util.dart           # Wires all managers at app startup
├── router/
│   └── managers/
│       ├── managers.dart            # Barrel export
│       ├── auth_navigation_manager.dart
│       └── dashboard_navigation_manager.dart
├── widget_managers/
│   ├── widget_managers.dart         # Barrel export
│   └── assets_widget_manager.dart
└── features/
    └── login/
        ├── login_feature.dart       # Feature initialization class
        └── managers/
            ├── managers.dart        # Barrel export
            └── login_navigation_manager.dart  # Abstract interface
```

## Navigation Managers

Abstract interface in feature, concrete implementation in router layer.

### Abstract Interface (in feature)

```dart
// lib/features/login/managers/login_navigation_manager.dart
abstract interface class LoginNavigationManager {
  Future<void> onFinishLogin();
}
```

### Concrete Implementation (in router)

```dart
// lib/router/managers/auth_navigation_manager.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNavigationManager implements LoginNavigationManager {
  const AuthNavigationManager(this.ref);
  final Ref ref;

  StackRouter? get currentRouter => 
      ref.read(appRouterServiceProvider).navigatorKey.currentContext?.router;

  @override
  Future<void> onFinishLogin() async {
    await ref.read(pushNotificationServiceProvider).initializePushNotifications();
    currentRouter?.replace(const DashboardRouter());
  }
}

final authNavigationManagerProvider = Provider<AuthNavigationManager>(
  (ref) => AuthNavigationManager(ref),
);
```

## Widget Managers

Allow features to display widgets from other features without direct dependencies.

### Abstract Interface (in feature)

```dart
// lib/features/assets/managers/widget_manager.dart
import 'package:flutter/widgets.dart';

abstract interface class AssetsWidgetManager {
  Widget assetThreatsWidget(String assetId);
}
```

### Concrete Implementation (in widget_managers)

```dart
// lib/widget_managers/assets_widget_manager.dart
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssetsWidgetManagerImpl implements AssetsWidgetManager {
  @override
  Widget assetThreatsWidget(String assetId) {
    return AssetThreatsList(assetId: assetId);
  }
}

final assetsWidgetManagerProvider = Provider<AssetsWidgetManager>(
  (ref) => AssetsWidgetManagerImpl(),
);
```

## Context-Based Navigation Manager

For simple navigation within a feature, use a context-based manager.

```dart
// lib/features/assets/managers/navigation_manager.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

class NavigationManager {
  const NavigationManager(this.context);
  final BuildContext context;

  void navigateToAssetDetail(String assetId) {
    context.router.push(AssetDetailScreenRoute(assetId: assetId));
  }

  void navigateToAllAssets() {
    context.router.push(const AllAssetsScreenRoute());
  }
}
```

## Feature Initialization

Features declare their dependencies via static providers, wired at app startup.

### Feature Class

```dart
// lib/features/login/login_feature.dart
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginFeature {
  static late Provider<LoginNavigationManager> loginNavigationManager;
  static late Provider<LoginRepository> loginRepository;

  static void init({
    required Provider<LoginNavigationManager> navigationManager,
    required Provider<LoginRepository> repository,
  }) {
    loginNavigationManager = navigationManager;
    loginRepository = repository;
  }
}
```

### App Initialization

```dart
// lib/feature_init_util.dart
void initFeatures() {
  LoginFeature.init(
    navigationManager: authNavigationManagerProvider,
    repository: authRepositoryProvider,
  );
  AssetsFeature.init(
    repository: assetsRepositoryImplProvider,
    widgetManager: assetsWidgetManagerProvider,
  );
  // ... more features
}
```

## Usage in Widgets

### Using Navigation Manager

```dart
class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        await performLogin();
        await ref.read(LoginFeature.loginNavigationManager).onFinishLogin();
      },
      child: Text('Login'),
    );
  }
}
```

### Using Widget Manager

```dart
class AssetDetailScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Widget from another feature via manager
        ref.read(AssetsFeature.assetsWidgetManager).assetThreatsWidget(assetId),
      ],
    );
  }
}
```

## Best Practices

1. **Use abstract interfaces** — Define contracts in features, implementations elsewhere
2. **Keep features independent** — Features should not import other feature code directly
3. **Use Riverpod providers** — All managers should be provided via Riverpod
4. **Initialize at startup** — Wire all managers in `initFeatures()` before `runApp()`
5. **Barrel exports** — Use `managers.dart` files to export all managers in a folder
6. **Ref for cross-feature navigation** — Use `Ref` to access router service
7. **Context for in-feature navigation** — Simple navigation can use `BuildContext`
