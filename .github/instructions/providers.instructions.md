---
applyTo: '**/*provider*.dart'
description: 'Use when creating Riverpod providers, working with state management, or understanding provider patterns. Covers @riverpod annotation, provider types (Stream, Notifier, AsyncNotifier), code generation, and provider organization.'
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
├── my_providers.dart          # Provider definitions
└── my_providers.g.dart        # Generated code (never edit)
```

## Provider Class Pattern

Organize providers using a static accessor class:

```dart
// my_providers.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../my_feature.dart';

part 'my_providers.g.dart';

class MyProviders {
  static var items = itemsStreamProviderProvider;
  static var itemDetail = itemDetailProviderProvider;
  static var filters = filtersNotifierProvider;
}
```

This allows clean access: `ref.watch(MyProviders.items)`

## Stream Providers

For reactive data that updates over time (most common for database watches):

```dart
@riverpod
class ItemsStreamProvider extends _$ItemsStreamProvider {
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
class ItemDetailProvider extends _$ItemDetailProvider {
  @override
  FutureOr<MyItem?> build({required String id}) async {
    return ref.watch(MyFeature.myRepository).watchItemById(id: id).first;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    await ref.read(MyFeature.myRepository).fetchItemById(id: id);
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

## Loading State Mixin Pattern

Create mixins for common loading patterns:

```dart
mixin LoadingStreamProvider<T> on AutoDisposeStreamNotifier<T> {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> withLoading(Future<void> Function() action) async {
    _isLoading = true;
    try {
      await action();
    } finally {
      _isLoading = false;
    }
  }
}

@riverpod
class ItemsProvider extends _$ItemsProvider with LoadingStreamProvider<List<MyItem>> {
  @override
  Stream<List<MyItem>> build() {
    return ref.watch(MyFeature.myRepository).watchItems();
  }

  Future<void> refresh() async {
    await withLoading(() => ref.read(MyFeature.myRepository).fetchItems());
  }
}
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
6. **Use `keepAlive: true` sparingly** — only for global state (auth, settings)

## Common Provider Types Summary

| Type | Use Case | Annotation |
|------|----------|------------|
| Stream | Reactive database watches | `@riverpod` with `Stream<T> build()` |
| Async | API calls, async init | `@riverpod` with `FutureOr<T> build()` |
| Sync | UI state, filters | `@riverpod` with `T build()` |
| KeepAlive | Global state | `@Riverpod(keepAlive: true)` |
