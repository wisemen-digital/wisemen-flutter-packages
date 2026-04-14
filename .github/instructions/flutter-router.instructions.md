---
applyTo: 'lib/router/**'
description: 'Flutter router architecture using auto_route for navigation. Use when: setting up navigation, creating routes, implementing guards, building nested navigation, configuring route observers. Keywords: AppRouter, AutoRoute, AutoRouteGuard, StackRouter, TabRouter, AdaptiveRoute, CustomRoute, route guards, navigation.'
---

# Flutter Router Guidelines

Navigation is handled via `auto_route` package with centralized router configuration, guards for access control, and observers for logging.

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     APP ROUTER                              │
│  Central route configuration (app_router.dart)              │
│  Defines all routes, guards, and nesting                    │
└─────────────────────────────────────────────────────────────┘
                            │
         ┌──────────────────┼──────────────────┐
         ▼                  ▼                  ▼
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│     GUARDS      │ │    MANAGERS     │ │    OBSERVERS    │
│ Access control  │ │ Navigation logic│ │ Route logging   │
└─────────────────┘ └─────────────────┘ └─────────────────┘
```

## File Structure

```
lib/router/
├── app_router.dart           # Route configuration
├── app_router.gr.dart        # Generated routes (auto_route)
├── app_router_service.dart   # Router provider
├── app_router_service.g.dart # Generated provider
├── route_observer.dart       # Route change logging
├── guards/
│   ├── guards.dart           # Barrel export
│   ├── auth_guard.dart       # Authentication guard
│   └── dashboard_guard.dart  # Dashboard access guard
├── managers/
│   ├── managers.dart         # Barrel export
│   ├── auth_navigation_manager.dart
│   └── dashboard_navigation_manager.dart
└── utils/
    ├── utils.dart            # Barrel export
    └── adaptive_bottom_sheet_route.dart
```

## Router Configuration

Define routes using `@AutoRouterConfig` annotation.

```dart
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_router.gr.dart';
import 'guards/guards.dart';
import 'utils/utils.dart';

@AutoRouterConfig(replaceInRouteName: '')
class AppRouter extends RootStackRouter {
  late Ref ref;

  late final List<AutoRoute> routes = [
    // Initial route with auth guard
    CustomRoute(
      path: '/',
      page: SplashScreenRoute.page,
      initial: true,
      guards: [AuthGuard(ref: ref)],
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
    
    // Login
    AdaptiveRoute(
      path: '/login',
      page: LoginScreenRoute.page,
    ),
    
    // Dashboard with nested routes
    AdaptiveRoute(
      page: DashboardRouter.page,
      guards: [DashboardGuard(ref: ref)],
      children: [
        AdaptiveRoute(
          page: DashboardScreenRoute.page,
          path: '',
          initial: true,
        ),
        AdaptiveRoute(
          page: ItemsScreenRoute.page,
          path: 'items',
        ),
        AdaptiveRoute(
          path: 'chat',
          page: ChatScreenRoute.page,
          meta: const {'hideBottomBar': true},
        ),
      ],
    ),
    
    // Detail routes
    AdaptiveRoute(
      path: '/item-detail',
      page: ItemDetailScreenRoute.page,
    ),
    
    // Bottom sheet route
    AdaptiveBottomSheetRoute(
      path: '/settings',
      page: SettingsScreenRoute.page,
    ),
  ];
}
```

## Router Service Provider

Provide router instance via Riverpod.

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'app_router.dart';

part 'app_router_service.g.dart';

@Riverpod(keepAlive: true)
Raw<AppRouter> appRouterService(Ref ref) {
  return AppRouter()..ref = ref;
}
```

## Route Types

| Route Type | Use Case | Example |
|------------|----------|---------|
| `AdaptiveRoute` | Standard screen | Most screens |
| `CustomRoute` | Custom transitions | Splash screen |
| `AdaptiveBottomSheetRoute` | Modal bottom sheet | Settings |
| `AutoRoute` | Default navigation | Simple screens |

## Route Guards

Guards control access to routes based on conditions.

### Auth Guard

```dart
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthGuard extends AutoRouteGuard {
  final Ref ref;
  AuthGuard({required this.ref});

  AuthenticationStatus? previousStatus;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final token = await secureStorage.read(key: tokenKey);
    var status = await ref.read(authClientProvider).authenticationStatus.first;
    
    if (previousStatus == status) return;
    previousStatus = status;

    switch (status) {
      case AuthenticationStatus.initial:
        resolver.next();
      case AuthenticationStatus.unauthenticated:
        router.replace(const LoginScreenRoute());
      case AuthenticationStatus.authenticated:
        await ref.read(userProvider.notifier).loadUser();
        router.replace(const DashboardRouter());
    }
  }
}
```

### Feature Guard

```dart
class DashboardGuard extends AutoRouteGuard {
  final Ref ref;
  DashboardGuard({required this.ref});

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final hasAccess = ref.read(userProvider).hasFeatureAccess;
    
    if (hasAccess) {
      resolver.next();
    } else {
      router.replace(const LoginScreenRoute());
    }
  }
}
```

## Route Observer

Log route changes for debugging.

```dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppRouterObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint('New route pushed: ${route.settings.name}');
    if (previousRoute == null) {
      // First route - remove splash screen
      FlutterNativeSplash.remove();
    }
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    debugPrint('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    debugPrint('Tab route re-visited: ${route.name}');
  }
}
```

## Custom Route Types

### Adaptive Bottom Sheet Route

Platform-specific bottom sheet presentation.

```dart
class AdaptiveBottomSheetRoute<R> extends CustomRoute {
  AdaptiveBottomSheetRoute({
    required super.page,
    super.path,
    super.guards,
    super.children,
    bool Function()? swipeToDismiss,
    // ... other params
  }) : super(
    customRouteBuilder: <T>(
      BuildContext context,
      Widget child,
      AutoRoutePage<T> page,
    ) {
      if (Platform.isIOS) {
        return CupertinoSheetRoute<T>(
          builder: (_) => MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: child,
          ),
          settings: page,
        );
      } else {
        return ModalBottomSheetRoute<T>(
          useSafeArea: true,
          builder: (_) => child,
          settings: page,
          isScrollControlled: true,
          isDismissible: swipeToDismiss?.call() ?? true,
        );
      }
    },
    barrierDismissible: swipeToDismiss?.call() ?? true,
  );
}
```

## Navigation Patterns

### Basic Navigation

```dart
// Push new route
context.router.push(const ItemDetailScreenRoute(itemId: '123'));

// Replace current route
context.router.replace(const DashboardRouter());

// Pop current route
context.router.pop();

// Pop to specific route
context.router.popUntilRouteWithName(DashboardRouter.name);
```

### From Provider (cross-feature)

```dart
class AuthNavigationManager implements LoginNavigationManager {
  const AuthNavigationManager(this.ref);
  final Ref ref;

  StackRouter? get currentRouter =>
      ref.read(appRouterServiceProvider).navigatorKey.currentContext?.router;

  @override
  Future<void> onFinishLogin() async {
    currentRouter?.replace(const DashboardRouter());
  }
}
```

### Programmatic Navigation with Delay

```dart
Future<void> navigateAfterAnimation() async {
  currentRouter?.popUntilRouteWithName(DashboardRouter.name);
  
  // Wait for animation to complete
  int attempts = 0;
  while (attempts < 20) {
    await Future.delayed(const Duration(milliseconds: 100));
    if (currentRouter?.current.name == DashboardRouter.name) break;
    attempts++;
  }
  
  currentRouter?.push(ItemDetailScreenRoute(itemId: targetId));
}
```

## Route Metadata

Pass metadata to routes for conditional behavior.

```dart
// In router configuration
AdaptiveRoute(
  path: 'chat',
  page: ChatScreenRoute.page,
  meta: const {'hideBottomBar': true},
),

// In widget
Widget build(BuildContext context) {
  final hideBottomBar = context.router.current.meta['hideBottomBar'] == true;
  
  return Scaffold(
    bottomNavigationBar: hideBottomBar ? null : BottomNavBar(),
  );
}
```

## Best Practices

1. **Use guards for access control** — Don't check auth in screens
2. **Centralize route definitions** — All routes in `app_router.dart`
3. **Use `AdaptiveRoute`** — Platform-appropriate transitions
4. **Ref for cross-feature navigation** — Access router via provider
5. **Context for in-screen navigation** — Simple pushes from widgets
6. **Generate routes** — Run `dart run build_runner build` after changes
7. **Use route observers** — Debug navigation flow in development
8. **Group nested routes** — Use child routes for tab-based navigation
9. **Barrel exports** — Export guards and managers from index files
10. **Type-safe routes** — Use generated route classes, not strings
