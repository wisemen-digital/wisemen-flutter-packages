---
applyTo: "lib/features/**"
description: "Use when creating new features, adding screens/widgets to features, or understanding feature organization. Covers the standard feature folder structure, barrel exports, feature initialization, and the shared feature pattern."
---

# Feature Structure

## Standard Feature Layout

Each feature is a self-contained module with consistent internal structure:

```
features/my_feature/
├── my_feature.dart              # Barrel export (public API)
├── my_feature_feature.dart      # Feature class with init()
│
├── models/                      # Domain models for this feature
│   ├── models.dart              # Barrel export
│   └── my_model.dart
│
├── enums/                       # Feature-specific enums
│   └── my_status.dart
│
├── providers/                   # Riverpod providers
│   ├── providers.dart           # Barrel export
│   ├── my_providers.dart        # Provider definitions
│   └── my_providers.g.dart      # Generated code
│
├── repositories/                # Repository interface
│   └── my_repository.dart       # Abstract interface only
│
├── screens/                     # Full-page widgets
│   ├── screens.dart             # Barrel export
│   ├── my_list_screen.dart
│   └── my_detail_screen.dart
│
├── widgets/                     # Reusable UI components
│   ├── widgets.dart             # Barrel export
│   └── my_card.dart
│
└── managers/                    # Complex state management helpers (optional)
    └── my_state_manager.dart
```

## Barrel Export Pattern

Each folder has a barrel file exporting its public API:

```dart
// features/my_feature/my_feature.dart
export 'enums/my_status.dart';
export 'models/models.dart';
export 'providers/providers.dart';
export 'repositories/my_repository.dart';
export 'screens/screens.dart';
export 'widgets/widgets.dart';
export 'my_feature_feature.dart';
```

## Feature Class Pattern

Each feature has a feature class that holds static references to its dependencies:

```dart
// features/my_feature/my_feature_feature.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'repositories/my_repository.dart';

class MyFeature {
  MyFeature._();

  static late final Provider<MyRepository> myRepository;

  static void init({required Provider<MyRepository> repository}) {
    myRepository = repository;
  }
}
```

## Feature Initialization

Features are registered in `feature_init_util.dart`:

```dart
void initFeatures() {
  MyFeature.init(repository: myRepositoryProvider);
  // ... other features
}
```

This pattern allows:
- Repository implementation to live outside the feature
- Easy testing with mock repositories
- Clear dependency declaration

## Repository Interface in Features

Features define **interfaces only** — implementations live in `lib/repository/`:

```dart
// features/my_feature/repositories/my_repository.dart
abstract class MyRepository {
  Stream<List<MyModel>> watchItems();
  Future<void> fetchItems();
  Future<void> fetchItemById({required String id});
}
```

## Screens vs Widgets

| Type | Purpose | Location |
|------|---------|----------|
| **Screen** | Full-page route destination | `screens/` |
| **Widget** | Reusable component | `widgets/` |

Screens are `ConsumerWidget` or `ConsumerStatefulWidget`:

```dart
@RoutePage()
class MyListScreen extends ConsumerWidget {
  const MyListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ...
  }
}
```

## The Shared Feature

`features/shared/` contains cross-feature utilities:

```
features/shared/
├── enums/           # App-wide enums
├── models/          # Shared domain models
├── providers/       # Utility providers
├── utils/           # Helper functions
└── widgets/         # Common UI components
```

**No screens or repositories** — shared is purely utility code.

## Creating a New Feature Checklist

1. Create feature folder: `lib/features/my_feature/`
2. Create barrel export: `my_feature.dart`
3. Create feature class: `my_feature_feature.dart` with `init()` method
4. Add repository interface: `repositories/my_repository.dart`
5. Add repository implementation: `lib/repository/repositories/my_repository_impl.dart`
6. Register in `feature_init_util.dart`
7. Add providers in `providers/` with `@riverpod` annotations
8. Create screens in `screens/`
9. Add routes to `app_router.dart`

## Feature Naming Convention

| Item | Convention | Example |
|------|------------|---------|
| Folder | `snake_case` | `my_feature/` |
| Barrel export | `feature_name.dart` | `my_feature.dart` |
| Feature class | `PascalCase + Feature` | `MyFeatureFeature` |
| Feature file | `feature_name_feature.dart` | `my_feature_feature.dart` |
