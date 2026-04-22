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
│                        UI Layer                              │
│    (Screens, Widgets, Providers)                            │
├─────────────────────────────────────────────────────────────┤
│                    Repository Layer                          │
│    (Data orchestration, caching, stream management)         │
├─────────────────────────────────────────────────────────────┤
│              Network Layer          Database Layer           │
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
import '../../my_feature.dart';
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

The following instruction files provide detailed guidance for specific areas. They are automatically loaded when working with matching files:

| Area | Instruction File | Applies To |
|------|------------------|------------|
| Project Structure | `project-structure.instructions.md` | `lib/**` |
| Feature Structure | `feature-structure.instructions.md` | `lib/features/**` |
| State Management | `providers.instructions.md` | `**/*provider*.dart` |
| Domain Models | `models.instructions.md` | `lib/**/models/**` |
| Repositories | `repositories.instructions.md` | `**/*repository*.dart` |
| Network Layer | `network.instructions.md` | `lib/network/**` |
| Database Layer | `database.instructions.md` | `lib/database/**` |

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
