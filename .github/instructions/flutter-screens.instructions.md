---
applyTo: '**/screens/**'
description: 'Flutter screens architecture for views, dialogs, and bottom sheets. Use when: creating screens, implementing dialogs, building bottom sheets, using auto_route annotations, structuring feature screens. Keywords: RoutePage, Screen, Dialog, BottomSheet, Modal, WoltModalSheet, ConsumerWidget, HookConsumerWidget, Scaffold.'
---

# Flutter Screens Guidelines

Screens are the main UI entry points for features. They use `@RoutePage()` annotation for navigation and follow consistent patterns for different display types.

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     SCREEN LAYER                            │
│  @RoutePage() annotated widgets (ConsumerWidget)            │
├─────────────────────────────────────────────────────────────┤
│  Full Screens    │  Bottom Sheets   │  Dialogs/Modals       │
│  AdaptiveRoute   │  BottomSheetRoute│  WoltModalSheet       │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                    PROVIDER LAYER                           │
│  State management via Riverpod (ref.watch, ref.read)        │
└─────────────────────────────────────────────────────────────┘
```

## Screen Types

| Type | Purpose | Route Type | Example |
|------|---------|------------|---------|
| Screen | Full-page view | `AdaptiveRoute` | `LoginScreen`, `DashboardScreen` |
| Detail Screen | Item detail view | `AdaptiveRoute` | `ItemDetailScreen` |
| Bottom Sheet | Modal overlay | `AdaptiveBottomSheetRoute` | `SettingsScreen` |
| Nested Bottom Sheet | Bottom sheet with navigation | `AdaptiveBottomSheetRoute` + children | `FeatureRouterScreen` |
| Filter Sheet | Filterable modal | `WoltModalSheet` | `ItemsFilterScreen` |

## File Structure

```
lib/features/[feature]/
└── screens/
    ├── screens.dart              # Barrel export
    ├── [feature]_screen.dart     # Main screen
    ├── [feature]_router_screen.dart # Router for nested navigation
    ├── [item]_detail_screen.dart # Detail screen
    └── all_[items]_screen.dart   # List screen
```

## Basic Screen Pattern

Use `@RoutePage()` annotation and extend `ConsumerWidget` or `HookConsumerWidget`.

```dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ItemsScreen extends ConsumerWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Screen content
          ],
        ),
      ),
    );
  }
}
```

## Screen with Hooks

Use `HookConsumerWidget` when you need lifecycle hooks (focus nodes, controllers, animations).

```dart
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();
    final passwordController = useTextEditingController();
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              focusNode: emailFocusNode,
              onSubmitted: (_) => FocusScope.of(context).requestFocus(passwordFocusNode),
            ),
            TextField(
              focusNode: passwordFocusNode,
              controller: passwordController,
            ),
          ],
        ),
      ),
    );
  }
}
```

## Screen with Parameters

Screens can receive parameters via route arguments.

```dart
@RoutePage()
class ItemDetailScreen extends ConsumerWidget {
  const ItemDetailScreen({
    super.key,
    required this.itemId,
  });

  final String itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(itemDetailProvider(itemId));
    
    return Scaffold(
      body: item.when(
        data: (data) => ItemDetailContent(item: data),
        loading: () => const CircularProgressIndicator(),
        error: (e, _) => ErrorWidget(e),
      ),
    );
  }
}
```

## Custom Scaffold Pattern

Use a custom scaffold for consistent layout across screens.

```dart
@RoutePage()
class ItemsScreen extends ConsumerWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      slivers: [
        const ItemsAppBar(),
        const SliverToBoxAdapter(child: gapHM),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.s),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                // Content
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizeUtils.bottomSpacing(context, withAppBar: true),
        ),
      ],
    );
  }
}
```

## Pop Scope Handling

Handle back navigation behavior with `PopScope`.

```dart
@RoutePage()
class ItemsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        // Custom back handling
        ref.read(tabControllerProvider).setActiveIndex(0);
      },
      child: Scaffold(
        // ...
      ),
    );
  }
}
```

## Modal Bottom Sheets

Use `WoltModalSheet` for complex modal dialogs with sliver content.

```dart
class ItemsFilterScreen {
  const ItemsFilterScreen();

  SliverWoltModalSheetPage build(BuildContext context) {
    return SliverWoltModalSheetPage(
      backgroundColor: context.bgColor.secondary,
      surfaceTintColor: context.bgColor.secondary,
      leadingNavBarWidget: Padding(
        padding: const EdgeInsetsDirectional.only(start: Sizes.s, top: 6),
        child: Consumer(
          builder: (context, ref, _) => TextButton(
            onPressed: () => ref.read(filtersProvider.notifier).reset(),
            child: Text(S.of(context).clearAll),
          ),
        ),
      ),
      trailingNavBarWidget: Padding(
        padding: const EdgeInsetsDirectional.only(end: 4, top: 6),
        child: IconButton(
          onPressed: context.router.maybePop,
          icon: Icon(Icons.close_rounded),
        ),
      ),
      stickyActionBar: Material(
        color: context.bgColor.secondary,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.m),
          child: PrimaryButton(
            text: S.of(context).applyFilter,
            onPressed: () {
              ref.read(pagingController).refresh();
              context.router.maybePop();
            },
          ),
        ),
      ),
      navBarHeight: kToolbarHeight,
      enableDrag: false,
      hasSabGradient: false,
      mainContentSliversBuilder: (context) => [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(Sizes.m),
            child: FiltersContent(),
          ),
        ),
      ],
    );
  }
}
```

## Nested Navigation in Bottom Sheets

Use `AdaptiveBottomSheetRoute` with child routes for bottom sheets that contain multiple navigable screens. This pattern requires a router screen that wraps an `AutoRouter`.

### Router Screen

Create a router screen that serves as the navigation container:

```dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'FeatureRouter')
class FeatureRouterScreen extends StatelessWidget {
  const FeatureRouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
```

The `name` parameter in `@RoutePage()` creates a custom route name (`FeatureRouter`) instead of the default generated name.

### Route Configuration

Configure the bottom sheet route with nested children in your router:

```dart
AdaptiveBottomSheetRoute(
  path: '/feature',
  page: FeatureRouter.page,
  title: (context, data) => S.of(context).feature,
  children: [
    AdaptiveRoute(
      path: 'overview',
      initial: true,  // Default child route
      page: FeatureOverviewScreenRoute.page,
      title: (context, data) => S.of(context).feature,
    ),
    AdaptiveRoute(
      path: 'settings',
      page: FeatureSettingsScreenRoute.page,
      title: (context, data) => S.of(context).settings,
    ),
    AdaptiveRoute(
      path: 'edit',
      page: FeatureEditScreenRoute.page,
      title: (context, data) => S.of(context).edit,
    ),
  ],
),
```

### Key Points

- **Router screen**: Use `AutoRouter()` widget to render child routes
- **Custom route name**: Use `@RoutePage(name: 'FeatureRouter')` for clarity
- **Initial route**: Mark one child with `initial: true` as the default screen
- **Navigation**: Child screens can navigate to siblings using `context.router.push()`

## Splash Screen

Simple stateless screen for app initialization.

```dart
@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.fgColor.brandPrimary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppAssets.splashImage, fit: BoxFit.cover),
          Image.asset(AppAssets.splashLogo, fit: BoxFit.scaleDown),
        ],
      ),
    );
  }
}
```

## Barrel Export

Export all screens from a single file.

```dart
// lib/features/my_feature/screens/screens.dart
export 'all_items_screen.dart';
export 'item_detail_screen.dart';
export 'items_screen.dart';
```

## Best Practices

1. **Use `@RoutePage()` annotation** — Required for auto_route code generation
2. **Prefer `ConsumerWidget`** — Use `HookConsumerWidget` only when hooks are needed
3. **Keep screens thin** — Delegate logic to providers and widgets
4. **Use semantic naming** — `[Feature]Screen`, `[Item]DetailScreen`, `All[Items]Screen`
5. **Handle loading states** — Use `.when()` pattern for async data
6. **Consistent spacing** — Use `SizeUtils.bottomSpacing()` for safe area padding
7. **Barrel exports** — Always export from `screens.dart`
8. **Use theme extensions** — Access colors via `context.bgColor`, `context.textColor`
