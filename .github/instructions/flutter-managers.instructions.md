---
applyTo: '**/managers/**'
description: 'Flutter managers architecture for feature decoupling. Use when: creating navigation managers, widget managers, implementing cross-feature communication, setting up feature initialization. Keywords: NavigationManager, WidgetManager, Feature decoupling, cross-feature communication, abstract interface, Provider, dependency injection.'
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
│   └── items_widget_manager.dart
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
// lib/features/my_feature/managers/widget_manager.dart
import 'package:flutter/widgets.dart';

abstract interface class ItemsWidgetManager {
  Widget itemRelatedWidget(String itemId);
}
```

### Concrete Implementation (in widget_managers)

```dart
// lib/widget_managers/items_widget_manager.dart
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemsWidgetManagerImpl implements ItemsWidgetManager {
  @override
  Widget itemRelatedWidget(String itemId) {
    return ItemRelatedList(itemId: itemId);
  }
}

final itemsWidgetManagerProvider = Provider<ItemsWidgetManager>(
  (ref) => ItemsWidgetManagerImpl(),
);
```

## Context-Based Navigation Manager

For simple navigation within a feature, use a context-based manager.

```dart
// lib/features/my_feature/managers/navigation_manager.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

class NavigationManager {
  const NavigationManager(this.context);
  final BuildContext context;

  void navigateToItemDetail(String itemId) {
    context.router.push(ItemDetailScreenRoute(itemId: itemId));
  }

  void navigateToAllItems() {
    context.router.push(const AllItemsScreenRoute());
  }
}
```

## Usage in Widgets

### Using Navigation Manager

```dart
// In controller/notifier — business logic calls navigation manager
@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {}

  Future<void> login() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).login();
      await ref.read(LoginFeature.loginNavigationManager).onFinishLogin();
    });
  }
}

// In screen — UI triggers controller
class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => ref.read(loginControllerProvider.notifier).login(),
      child: Text('Login'),
    );
  }
}
```

### Using Widget Manager

```dart
class ItemDetailScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Widget from another feature via manager
        ref.read(MyFeature.itemsWidgetManager).itemRelatedWidget(itemId),
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
