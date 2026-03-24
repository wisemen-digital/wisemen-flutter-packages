---
applyTo: "lib/**"
description: "Use when working with project folder structure, understanding lib/ organization, or creating new top-level directories. Covers the purpose of each main folder (features, network, database, repository, router, theme) and root-level files."
---

# Project Folder Structure

## lib/ Directory Overview

```
lib/
├── app.dart                    # Root app widget (ConsumerWidget wrapping MaterialApp)
├── main.dart                   # Entry point with initialization
├── main_[flavor].dart          # Flavor-specific entry points
├── flavors.dart                # Environment configuration
├── feature_init_util.dart      # Feature initialization registry
│
├── features/                   # Feature modules (business logic + UI)
├── network/                    # API layer (services, DTOs, clients)
├── database/                   # Local storage (Drift tables, DAOs)
├── repository/                 # Shared repositories and mappers
├── router/                     # Navigation (Auto Route configuration)
├── theme/                      # App theme (colors, typography, styles)
├── l10n/                       # Localization strings
├── generated/                  # Code-generated files (l10n, assets)
├── assets/                     # Asset bundle definitions
└── widget_managers/            # Cross-feature UI state managers
```

## Directory Purposes

### features/

Self-contained feature modules. Each feature owns its screens, widgets, providers, models, and repositories.

```
features/
├── dashboard/
├── my_feature/
├── settings/
└── shared/              # Cross-feature utilities (enums, models, widgets)
```

### network/

All API communication. Organized by concern:

```
network/
├── clients/            # HTTP client providers (protected, unprotected)
├── dto/                # Data Transfer Objects per feature
├── services/           # API service classes
└── utils/              # Network utilities (pagination, base interfaces)
```

### database/

Local SQLite storage using Drift:

```
database/
├── database.dart       # Database class with migrations
├── tables/             # Table definitions
├── dao/                # Data Access Objects
├── models/             # Value objects stored as JSON
└── utils/              # Database utilities and converters
```

### repository/

Data orchestration layer bridging network and database:

```
repository/
├── repositories/       # Repository implementations
├── dto_mappers/        # DTO → Database/Feature transformations
└── table_mappers/      # Database → Feature transformations
```

### router/

Navigation setup using Auto Route:

```
router/
├── app_router.dart     # Route definitions
├── app_router.gr.dart  # Generated routes
└── guards/             # Route guards (auth, permissions)
```

### theme/

App-wide styling:

```
theme/
├── app_theme.dart      # ThemeData configuration
├── app_colors.dart     # Color palette
└── app_text_styles.dart # Typography
```

## Root Files

| File | Purpose |
|------|---------|
| `app.dart` | Root `ConsumerWidget` with `MaterialApp.router` |
| `main.dart` | Default entry point |
| `main_[flavor].dart` | Environment-specific entries (development, staging, production) |
| `flavors.dart` | `F` class with environment config (baseUrl, apiKey, etc.) |
| `feature_init_util.dart` | Registers all features with their dependencies |

## Feature Initialization Pattern

Features are initialized with their dependencies in `feature_init_util.dart`:

```dart
void initFeatures() {
  MyFeature.init(repository: myRepositoryProvider);
  DashboardFeature.init(repository: dashboardRepositoryProvider);
  // ... all features
}
```

## Barrel Export Pattern

Each directory uses a barrel file to expose its public API:

```dart
// features/my_feature/my_feature.dart
export 'models/item.dart';
export 'providers/providers.dart';
export 'screens/screens.dart';
export 'my_feature_feature.dart';
```

## When Creating New Directories

1. **New feature**: Create under `features/` following feature structure
2. **New service**: Add to `network/services/` with corresponding DTOs
3. **New table**: Add to `database/tables/` with a DAO in `database/dao/`
4. **New shared utility**: Evaluate if it belongs in `features/shared/` or a top-level folder
