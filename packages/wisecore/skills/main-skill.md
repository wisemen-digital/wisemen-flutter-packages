# Flutter Project Guidelines

## Overview

This is a Flutter application following a **feature-based clean architecture** with clear separation of concerns. The architecture uses:

- **Riverpod** for state management with code generation
- **Drift** for local SQLite database with reactive queries
- **Auto Route** for type-safe navigation
- **Feature-based organization** with modular, self-contained features

## Architecture Layers

```
┌─────────────────────────────────────────────────────────────┐
│                        UI Layer                             │
│    (Screens, Widgets, Providers)                            │
├─────────────────────────────────────────────────────────────┤
│                    Repository Layer                         │
│    (Data orchestration, caching, stream management)         │
├─────────────────────────────────────────────────────────────┤
│              Network Layer          Database Layer          │
│    (Services, DTOs, Mappers)    (DAOs, Tables, Models)      │
└─────────────────────────────────────────────────────────────┘
```

### Data Flow

1. **Fetch**: UI triggers repository → Service fetches from API → Returns DTO
2. **Transform**: DTO mapper converts to database companion
3. **Store**: DAO inserts into local database
4. **Watch**: Repository returns stream from DAO
5. **Display**: Stream maps database objects to feature models → UI updates

## Code Style

### General Conventions

- Use `const` constructors wherever possible
- Prefer immutable data classes
- Use barrel exports (`feature.dart`) to expose public APIs
- Follow the single responsibility principle
- Keep files focused and small
- Catch errors with `catch (e)` or `catch (e, stackTrace)` — never `on Object catch (e)` (identical, just noisier). Use `on SpecificType` only when handling that type specifically, and capture the stack trace when logging or forwarding the error
- Model payload-less states as `static const` singletons, not const constructors (`FeedbackStatus.idle`, not `FeedbackStatus.idle()`). Keep constructors only for variants that carry data
- Use Flutter's callback typedefs — `VoidCallback` for `void Function()`, `ValueChanged<T>` for `void Function(T)` — instead of writing the raw function type
- Give void, side-effecting methods a block body (`{ … }`), not `=>`. An arrow returns its expression, so `void f() => _x = v;` silently returns the assigned value into `void` — a statement body reads as "does", not "returns"

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Features | `snake_case` folder | `lib/features/my_feature/` |
| Screens | `_screen.dart` suffix | `item_list_screen.dart` |
| Widgets | `_widget.dart` suffix (optional) | `item_card.dart` |
| Providers | `_providers.dart` suffix | `item_providers.dart` |
| Repositories | `_repository.dart` suffix | `item_repository.dart` |
| Services | `_service.dart` suffix | `item_service.dart` |
| DTOs | `_dto.dart` suffix | `item_dto.dart` |
| DAOs | `_dao.dart` suffix | `item_dao.dart` |

### Import Organization

```dart
// 1. Dart SDK
import 'dart:async';

// 2. Flutter
import 'package:flutter/material.dart';

// 3. External packages
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 4. Internal packages (relative imports)
import '../my_feature.dart';
```

## Key Patterns

### Riverpod Providers

Use `@riverpod` annotation with code generation:

```dart
@riverpod
class MyNotifier extends _$MyNotifier {
  @override
  FutureOr<MyState> build() {
    // Initial state
  }
}
```

### Repository Pattern

Repositories implement feature interfaces and orchestrate data flow:

```dart
class MyRepositoryImpl implements MyRepository {
  const MyRepositoryImpl({required this.ref});
  final Ref ref;

  @override
  Stream<List<MyModel>> watchItems() {
    return ref.watch(myDaoProvider).watchAll()
        .map((items) => items.map((e) => e.toFeatureModel()).toList());
  }
}
```

### DTO Pattern

Use `json_serializable` with snake_case conversion:

```dart
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MyDTO implements BaseDTO {
  // ...
}
```

## Specialized Instructions

The following files provide detailed guidance for specific areas. **IMPORTANT**: Read the relevant file before working in that area.

@.claude/skills/wisecore_database.md
@.claude/skills/wisecore_flutter-managers.md
@.claude/skills/wisecore_flutter-router.md
@.claude/skills/wisecore_flutter-screens.md
@.claude/skills/wisecore_flutter-theming.md
@.claude/skills/wisecore_flutter-widgets.md
@.claude/skills/wisecore_feature-structure.md
@.claude/skills/wisecore_models.md
@.claude/skills/wisecore_network.md
@.claude/skills/wisecore_project-structure.md
@.claude/skills/wisecore_providers.md
@.claude/skills/wisecore_repositories.md


## Build Commands

```bash
# Install dependencies
flutter pub get

# Run code generation (required after model/provider changes)
dart run build_runner build --delete-conflicting-outputs

# Run code generation in watch mode
dart run build_runner watch --delete-conflicting-outputs

# Run tests
flutter test

# Analyze code
flutter analyze
```

## Dependencies Overview

### Core

- `flutter_riverpod` / `riverpod_annotation` — State management
- `drift` / `drift_flutter` — Local database
- `auto_route` — Navigation
- `json_annotation` — JSON serialization

### Code Generation (dev)

- `riverpod_generator` — Riverpod code generation
- `json_serializable` — JSON serialization code generation
- `drift_dev` — Drift code generation
- `auto_route_generator` — Route code generation
- `build_runner` — Code generation runner

### Adding Dependencies

Prefer pure-Dart / lightweight packages by default. Native plugins cost build time, have platform-support gaps (unsupported on some older or non-standard devices), and need permissions — so weigh that against the benefit rather than avoiding them reflexively. Be strictest for general-purpose packages reused across projects; within a single app, use a native plugin when it's genuinely the best option — just not for a nice-to-have.
