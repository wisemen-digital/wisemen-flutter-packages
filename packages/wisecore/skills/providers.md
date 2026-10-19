---
applyTo: '**/*provider*.dart,**/*controller*.dart'
description: 'Use when creating Riverpod providers or controllers, working with state management, or understanding provider patterns. Covers @riverpod annotation, provider types (Stream, Notifier, AsyncNotifier), controllers for form submission, code generation, and provider organization.'
---

# Providers Guidelines

## Overview

State management uses **Riverpod** with code generation via `@riverpod` annotation. All providers generate companion `.g.dart` files.

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      UI LAYER                               │
│  ref.watch(provider) / ref.read(provider)                   │
└─────────────────────────────────────────────────────────────┘
                            ▲
┌─────────────────────────────────────────────────────────────┐
│                   PROVIDER LAYER                            │
├─────────────────────────────────────────────────────────────┤
│  StreamProvider   │  AsyncNotifier   │  Notifier            │
│  Database watches │  Async mutations │  Sync state          │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                  REPOSITORY LAYER                           │
│  Data orchestration (fetch, watch, transform)               │
└─────────────────────────────────────────────────────────────┘
```

## File Structure

```
features/my_feature/providers/
├── providers.dart             # Barrel export
├── my_providers.dart          # All providers of the feature, as separate providers in one file
├── my_providers.g.dart        # Generated code (never edit)
├── my_controller.dart         # Controller (only when the feature has user actions)
└── my_controller.g.dart       # Generated code (never edit)
```

All of a feature's providers live in one `[feature]_providers.dart` — each one
still a separate, small provider — and the controller gets its own
`[feature]_controller.dart`. Spreading providers over many files makes a feature
harder to scan. A flow with clearly separate steps can have one controller file
per step.

## Provider Class Pattern

Organize providers using a static accessor class:

```dart
// my_providers.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../my_feature.dart';

part 'my_providers.g.dart';

class MyProviders {
  static var items = itemsStreamNotifierProvider;
  static var itemDetail = itemDetailNotifierProvider;
  static var filters = filtersNotifierProvider;
  static var form = myFormNotifierProvider;
  static var controller = myControllerProvider;
}
```

This allows clean access: `ref.watch(MyProviders.items)`

## Controllers

A controller handles user actions (submit, cancel, delete) for a screen. It owns the **submission state**: loading, success and errors.

Keep three things apart, so each stays small. A controller that holds form
data, flags and errors at once becomes hard to read and to change.

| What | Where |
|------|-------|
| Submission state (loading, error) | The controller's `AsyncValue`, set with `AsyncValue.guard` — no `isSubmitting`, `error` or `clearError` fields on a form model |
| Form data (what the user entered) | Its own provider or model |
| The screen's initial data | Its own provider, not the controller |

Show submission errors from the controller with the project's shared error
dialog (e.g. `ErrorUtils.showErrorDialog` in `listenSelf`), not with a separate
listener widget or a new feature-specific dialog. A validation error that
belongs to one input is different: show it next to that field.

A flow with clearly separate steps gets one controller per step instead of one
large controller.

```dart
// DON'T — form data, flags and errors in one state object
state = AsyncData(current.copyWith(isSubmitting: true, clearError: true));

// DO — the AsyncValue is the submission state
state = const AsyncLoading();
state = await AsyncValue.guard(() => repository.submit(form));
```

```dart
// lib/features/my_feature/providers/my_controller.dart
@riverpod
class MyController extends _$MyController {
  @override
  FutureOr<void> build() {
    listenSelf((previous, next) => ErrorUtils.showErrorDialog(next));
  }

  Future<void> submit() async {
    final form = ref.read(MyProviders.form);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(MyFeature.myRepository).submit(form),
    );
  }
}
```

**Usage in UI:**

```dart
final submission = ref.watch(MyProviders.controller);

PrimaryButton(
  text: S.of(context).submit,
  isLoading: submission.isLoading,
  onPressed: ref.read(MyProviders.controller.notifier).submit,
);
```

## Stream Providers

For reactive data that updates over time (most common for database watches):

```dart
@riverpod
class ItemsStreamNotifier extends _$ItemsStreamNotifier {
  @override
  Stream<List<MyItem>> build() {
    return ref.watch(MyFeature.myRepository).watchItems();
  }
}
```

**Usage in UI:**

```dart
final itemsAsync = ref.watch(MyProviders.items);

return itemsAsync.when(
  data: (items) => ListView.builder(...),
  loading: () => const CircularProgressIndicator(),
  error: (e, st) => ErrorWidget(e),
);
```

## Async Notifier Providers

For state with async initialization and mutation methods:

```dart
@riverpod
class ItemDetailNotifier extends _$ItemDetailNotifier {
  @override
  FutureOr<MyItem?> build({required String id}) async {
    return ref.watch(MyFeature.myRepository).getItemById(id: id);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(MyFeature.myRepository).fetchItemById(id: id);
      return ref.read(MyFeature.myRepository).getItemById(id: id);
    });
  }
}
```

## Notifier Providers

For synchronous state management:

```dart
@riverpod
class FiltersNotifier extends _$FiltersNotifier {
  @override
  MyFilters build() {
    return const MyFilters();
  }

  void updateStatus(StatusEnum status) {
    state = state.copyWith(status: status);
  }

  void reset() {
    state = const MyFilters();
  }
}
```

## Provider with Parameters

Use family-style providers with build parameters:

```dart
@riverpod
class ItemDetailProvider extends _$ItemDetailProvider {
  @override
  Stream<MyItem?> build({required String id}) {
    return ref.watch(MyFeature.myRepository).watchItemById(id: id);
  }
}

// Usage
ref.watch(itemDetailProviderProvider(id: 'item-123'));
```

## KeepAlive Pattern

For providers that should persist across widget disposal:

```dart
@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  AuthStatus build() {
    return AuthStatus.unknown;
  }
}
```

## Provider Lifecycle & Auto-Disposal

Riverpod auto-disposes any provider that has no active listeners. If a provider is only ever accessed with `ref.read` and never watched, it is disposed as soon as the current build finishes. The next call to its notifier creates a **fresh instance**, silently discarding all prior state.

```dart
// BAD — provider is never watched; Riverpod disposes it after the build finishes.
// Calling .reset() creates a fresh FiltersNotifier with no prior state.
@override
Widget build(BuildContext context, WidgetRef ref) {
  return ElevatedButton(
    onPressed: () => ref.read(MyProviders.filters.notifier).reset(),
    child: const Text('Reset'),
  );
}
```

**Fix 1 — watch in `build` (preferred for feature-scoped providers):**

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  ref.watch(MyProviders.filters); // keeps provider alive while widget is mounted
  return ElevatedButton(
    onPressed: () => ref.read(MyProviders.filters.notifier).reset(),
    child: const Text('Reset'),
  );
}
```

State is discarded when the widget is unmounted — which is usually the right behavior for a screen-scoped provider.

**Fix 2 — `keepAlive` (for global/cross-feature providers):**

```dart
@Riverpod(keepAlive: true)
class FiltersNotifier extends _$FiltersNotifier { ... }
```

Use this when the provider must survive navigation (auth status, shopping cart, app-wide settings). Avoid it for feature-scoped providers — kept-alive providers never release memory.

| Scenario | Fix |
|----------|-----|
| Provider state must survive while the screen is visible | `ref.watch` in `build` |
| Provider state must survive across navigation/app session | `@Riverpod(keepAlive: true)` |

## Loading State Mixin Pattern

Use `LoadingStreamProvider` from core for providers that need loading state management with refresh functionality:

```dart
@riverpod
class ItemDetailProvider extends _$ItemDetailProvider with LoadingStreamProvider<MyItem?> {
  @override
  Stream<MyItem?> build(String itemId) {
    refresh();  // Trigger initial fetch
    return ref.watch(MyFeature.myRepository).watchItemById(itemId);
  }

  @override
  Future<void> onError(Object error, StackTrace stackTrace) async {
    // Optional: Custom error handling (logging, analytics, etc.)
    SentryUtil.captureException(
      exception: error,
      stackTrace: stackTrace,
      ref: ref,
    );
  }

  @override
  Future<void> refreshFunction() async {
    await ref.read(MyFeature.myRepository).fetchItemById(itemId);
  }
}
```

### Key Points

- **Mixin from core**: `LoadingStreamProvider<T>` handles loading state and error recovery
- **`refresh()`**: Call in `build()` to trigger initial data fetch
- **`refreshFunction()`**: Override to define the actual fetch operation
- **`onError()`**: Optional override for custom error handling (logging, Sentry, etc.)
- **Smooth UX**: Preserves existing data during refresh

**Usage in UI:**

```dart
final itemAsync = ref.watch(MyProviders.itemDetail);

return itemAsync.whenStream(
  data: (item) => RefreshIndicator(
    onRefresh: () => ref.read(MyProviders.itemDetail.notifier).refresh(),
    child: ItemDetailContent(item: item),
  ),
  loading: () => const CircularProgressIndicator(),
  error: (e, st) => ErrorWidget(e),
);
```


## Accessing Other Providers

```dart
@riverpod
class MyProvider extends _$MyProvider {
  @override
  MyState build() {
    // Watch: rebuild when dependency changes
    final filters = ref.watch(filtersNotifierProvider);
    
    // Read: one-time access (use in methods)
    final repository = ref.read(MyFeature.myRepository);
    
    return MyState(filters: filters);
  }
}
```

## Code Generation

After creating/modifying providers, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Or in watch mode:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

## Best Practices

1. **Use streams for database data** — enables reactive updates
2. **Keep providers small** — one concern per provider
3. **Use static accessor class** — cleaner imports and discoverability
4. **Prefer `ref.watch` over `ref.read`** — except in callbacks/methods
5. **Add refresh methods** — for pull-to-refresh and manual updates
6. **Watch or keepAlive to prevent auto-disposal** — a provider with no active listeners is auto-disposed; calling its methods then creates a fresh instance with no prior state. Fix: `ref.watch` in `build` for feature-scoped providers, `@Riverpod(keepAlive: true)` for global state
7. **Use `get*` for one-time reads** — instead of `watch*().first` on your own repository (see the repositories guidelines)
8. **Controller owns submission state** — loading and errors via `AsyncValue`, form data in its own provider, validation errors next to the field
9. **Providers in one file, controller in its own** — `[feature]_providers.dart` + `[feature]_controller.dart`

## Common Provider Types Summary

| Type | Use Case | Annotation |
|------|----------|------------|
| Stream | Reactive database watches | `@riverpod` with `Stream<T> build()` |
| Async | API calls, async init | `@riverpod` with `FutureOr<T> build()` |
| Sync | UI state, filters | `@riverpod` with `T build()` |
| KeepAlive | Global state | `@Riverpod(keepAlive: true)` |
