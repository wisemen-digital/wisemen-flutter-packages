---
description: 'Flutter screens architecture for views, dialogs, and bottom sheets. Use when: creating screens, implementing dialogs, building bottom sheets, using auto_route annotations, structuring feature screens. Keywords: RoutePage, Screen, Dialog, BottomSheet, Modal, WoltModalSheet, ConsumerWidget, HookConsumerWidget, Scaffold.'
applyTo: '**/screens/**'
---

# Flutter Screens Guidelines

Screens are the main UI entry points for features. They use `@RoutePage()` annotation for navigation and follow consistent patterns for different display types.

## Screen Types

| Type | Purpose | Route Type | Example |
|------|---------|------------|---------|
| Screen | Full-page view | `AdaptiveRoute` | `LoginScreen`, `DashboardScreen` |
| Detail Screen | Item detail view | `AdaptiveRoute` | `ThreatDetailScreen`, `AssetDetailScreen` |
| Bottom Sheet | Modal overlay | `AdaptiveBottomSheetRoute` | `SettingsScreen` |
| Filter Sheet | Filterable modal | `WoltModalSheet` | `ThreatsFilterScreen` |

## File Structure

```
lib/features/[feature]/
└── screens/
    ├── screens.dart              # Barrel export
    ├── [feature]_screen.dart     # Main screen
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
class ThreatsScreen extends ConsumerWidget {
  const ThreatsScreen({super.key});

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
    final passwordFocusNode = useListenable(useFocusNode());
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
class ThreatDetailScreen extends ConsumerWidget {
  const ThreatDetailScreen({
    super.key,
    required this.threatId,
  });

  final String threatId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final threat = ref.watch(threatDetailProvider(threatId));
    
    return Scaffold(
      body: threat.when(
        data: (data) => ThreatDetailContent(threat: data),
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
class ThreatsScreen extends ConsumerWidget {
  const ThreatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SecutecScaffold(
      slivers: [
        const ThreatsAppBar(),
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
class ThreatsScreen extends ConsumerWidget {
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
class ThreatsFilterScreen {
  const ThreatsFilterScreen();

  SliverWoltModalSheetPage build(BuildContext context) {
    return SliverWoltModalSheetPage(
      backgroundColor: context.bgColor.secondary,
      surfaceTintColor: context.bgColor.secondary,
      leadingNavBarWidget: Padding(
        padding: const EdgeInsetsDirectional.only(start: Sizes.s, top: 6),
        child: Consumer(
          builder: (context, ref, _) => TextButton(
            onPressed: () => ref.read(filtersProvider.notifier).reset(),
            child: Text('Clear All'),
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
            text: 'Apply Filter',
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
          Image.asset(AppAssets.splashImage.path, fit: BoxFit.cover),
          Image.asset(AppAssets.splashLogo.path, fit: BoxFit.scaleDown),
        ],
      ),
    );
  }
}
```

## Barrel Export

Export all screens from a single file.

```dart
// lib/features/threats/screens/screens.dart
export 'all_threats_screen.dart';
export 'threat_detail_screen.dart';
export 'threats_screen.dart';
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
