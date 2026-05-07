---
applyTo: '**/widgets/**'
description: 'Flutter widgets architecture for reusable UI components. Use when: creating reusable widgets, building feature-specific widgets, implementing shared components, structuring widget files. Keywords: Widget, StatelessWidget, ConsumerWidget, shared widgets, feature widgets, CustomPainter, Semantics, accessibility.'
---

# Flutter Widgets Guidelines

Widgets are reusable UI components organized by scope: shared widgets for app-wide use, feature widgets for feature-specific components.

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     WIDGET LAYER                            │
│  Reusable UI components (StatelessWidget, ConsumerWidget)   │
├─────────────────────────────────────────────────────────────┤
│  SHARED WIDGETS              │  FEATURE WIDGETS             │
│  lib/features/shared/widgets │  lib/features/*/widgets      │
│  App-wide components         │  Feature-specific components │
│  PrimaryButton, EmptyState   │  ItemCard, ItemListTile      │
└─────────────────────────────────────────────────────────────┘
```

## Widget Organization

| Scope | Location | Purpose | Example |
|-------|----------|---------|---------|
| Shared | `lib/features/shared/widgets/` | App-wide reusable components | `PrimaryButton`, `EmptyState` |
| Feature | `lib/features/[feature]/widgets/` | Feature-specific components | `ItemListTile`, `ItemCard` |

## File Structure

```
lib/features/
├── shared/
│   └── widgets/
│       ├── widgets.dart              # Barrel export
│       ├── primary_button.dart       # Reusable button
│       ├── empty_state.dart          # Empty state view
│       └── info_tile.dart            # Info display tile
└── [feature]/
    └── widgets/
        ├── widgets.dart              # Barrel export
        ├── [feature]_app_bar.dart    # Feature app bar
        ├── [item]_list_tile.dart     # List item widget
        └── [item]_card.dart          # Card widget
```

## Basic Widget Pattern

Use `StatelessWidget` for simple widgets without state or Riverpod.

```dart
import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    required this.title,
    required this.value,
    this.icon,
  });

  final String title;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) Icon(icon, color: context.fgColor.primary),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.label),
            Text(value, style: context.normal),
          ],
        ),
      ],
    );
  }
}
```

## Consumer Widget Pattern

Use `ConsumerWidget` when widget needs Riverpod state.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemListTile extends ConsumerWidget {
  const ItemListTile({
    super.key,
    required this.itemId,
  });

  final String itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(itemProvider(itemId));
    
    return ListTile(
      title: Text(item.name, style: context.normal),
      subtitle: Text(item.status.label, style: context.label),
      leading: Icon(
        Icons.info,
        color: item.status.color(context),
      ),
      onTap: () => NavigationManager(context).navigateToItemDetail(itemId),
    );
  }
}
```

## Button Widget Pattern

Include loading states, disabled states, and accessibility.

```dart
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
    this.semanticLabel,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final String? semanticLabel;

  static const Size SIZE = Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? text,
      button: true,
      enabled: !isDisabled,
      child: ElevatedButton(
        onPressed: isDisabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.fgColor.brandPrimary,
          foregroundColor: context.textColor.primaryOnBrand,
          disabledBackgroundColor: context.bgColor.disabledSubtle,
          minimumSize: SIZE,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SIZE.height),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(text, style: context.button),
      ),
    );
  }
}
```

## App Bar Widget Pattern

Feature-specific app bars as separate widgets.

```dart
class ItemsAppBar extends ConsumerWidget {
  const ItemsAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      title: Text(S.of(context).items, style: context.title),
      floating: true,
      actions: [
        IconButton(
          icon: Icon(Icons.filter_list, color: context.fgColor.primary),
          onPressed: () => _showFilterSheet(context),
        ),
      ],
    );
  }

  void _showFilterSheet(BuildContext context) {
    WoltModalSheet.show(
      context: context,
      pageListBuilder: (context) => [
        const ItemsFilterScreen().build(context),
      ],
    );
  }
}
```

## List Item Widget Pattern

Consistent list items with navigation.

```dart
class ItemListTile extends StatelessWidget {
  const ItemListTile({
    super.key,
    required this.item,
    this.onTap,
  });

  final Item item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: item.name,
      button: onTap != null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Sizes.s),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.m),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: context.bgColor.brandPrimary,
                child: Icon(item.icon, color: context.fgColor.brandPrimary),
              ),
              const SizedBox(width: Sizes.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: context.normal),
                    Text(item.type.label, style: context.label),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: context.fgColor.tertiary),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Empty State Widget Pattern

Reusable empty state for lists and views.

```dart
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.action,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.l),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 64,
                color: context.fgColor.tertiary,
              ),
            const SizedBox(height: Sizes.m),
            Text(
              title,
              style: context.title,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: Sizes.s),
              Text(
                subtitle!,
                style: context.label,
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: Sizes.l),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
```

## Icon Button Pattern

Flat icon button with custom styling.

```dart
class FlatIconButton extends StatelessWidget {
  const FlatIconButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    required this.semanticLabel,
  });

  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: Material(
        color: backgroundColor ?? context.bgColor.secondary,
        borderRadius: BorderRadius.circular(Sizes.s),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(Sizes.s),
          child: Padding(
            padding: const EdgeInsets.all(Sizes.xs),
            child: child,
          ),
        ),
      ),
    );
  }
}
```

## Barrel Export

Export all widgets from a single file.

```dart
// lib/features/shared/widgets/widgets.dart
export 'empty_state.dart';
export 'flat_icon_button.dart';
export 'info_tile.dart';
export 'primary_button.dart';
export 'text_field.dart';
```

## Best Practices

1. **Use theme extensions** — Always use `context.textColor`, `context.bgColor`, etc.
2. **Include Semantics** — Add accessibility labels for interactive widgets
3. **Const constructors** — Use `const` for better performance
4. **Named parameters** — Use required named parameters for clarity
5. **Extract magic numbers** — Use `static const` for sizes and dimensions
6. **Handle loading/disabled states** — Buttons should support both states
7. **Barrel exports** — Always export from `widgets.dart`
8. **Single responsibility** — Each widget should do one thing well
9. **Use Consumer selectively** — Only use `ConsumerWidget` when Riverpod is needed
10. **Document public API** — Add doc comments for public widgets
