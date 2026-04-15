---
applyTo: 'lib/**/models/**'
description: 'Use when creating domain models, understanding the three-tier model architecture (DTO, Database, Feature), or working with enums. Covers feature models, database value objects, and enum patterns.'
---

# Models Guidelines

## Three-Tier Model Architecture

The architecture uses three types of models, each serving a specific purpose:

```
┌─────────────────┐
│   Feature Model │  ← Clean domain model for UI layer
├─────────────────┤
│  Database Model │  ← Drift table object + value objects
├─────────────────┤
│       DTO       │  ← API response shape
└─────────────────┘
```

## Feature Models

Located in `lib/features/[feature]/models/`. These are clean domain models used by the UI layer.

```dart
// lib/features/my_feature/models/item.dart
class Item {
  const Item({
    required this.id,
    required this.name,
    required this.type,
    this.description,
    this.imageUrl,
  });

  final String id;
  final String name;
  final ItemType type;
  final String? description;
  final String? imageUrl;
}
```

### Feature Model Principles

- **Immutable** — use `final` fields and `const` constructors
- **No serialization logic** — no `fromJson`/`toJson`
- **Feature-specific enums** — use feature enums, not database enums
- **Optional `copyWith`** — add when mutations are needed

```dart
class Item {
  // ... fields ...

  Item copyWith({
    String? name,
    String? description,
    ItemType? type,
  }) {
    return Item(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      imageUrl: imageUrl,
    );
  }
}
```

## Database Value Objects

Located in `lib/database/models/`. These are serializable objects stored as JSON in text columns.

```dart
// lib/database/models/item/item_metadata.dart
class ItemMetadata {
  const ItemMetadata({
    required this.category,
    required this.isActive,
    this.source,
  });

  final String category;
  final bool isActive;
  final String? source;

  // JSON serialization for Drift TypeConverter
  factory ItemMetadata.fromJson(Map<String, dynamic> json) {
    return ItemMetadata(
      category: json['category'] as String,
      isActive: json['is_active'] as bool,
      source: json['source'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'is_active': isActive,
      if (source != null) 'source': source,
    };
  }

  // Drift TypeConverter
  static TypeConverter<ItemMetadata, String> get converter =>
      TypeConverter.json(
        fromJson: (json) => ItemMetadata.fromJson(json as Map<String, dynamic>),
        toJson: (meta) => meta.toJson(),
      );

  // List converter for storing arrays
  static TypeConverter<List<ItemMetadata>, String> get listConverter =>
      TypeConverter.json(
        fromJson: (json) => (json as List)
            .map((e) => ItemMetadata.fromJson(e as Map<String, dynamic>))
            .toList(),
        toJson: (list) => list.map((e) => e.toJson()).toList(),
      );
}
```

## Enum Patterns

### Feature Enums

Located in `lib/features/[feature]/enums/`. Used by UI layer.

```dart
// lib/features/my_feature/enums/item_type.dart
enum ItemType {
  typeA,
  typeB,
  typeC,
  typeD;

  String get displayName {
    return switch (this) {
      ItemType.typeA => 'Type A',
      ItemType.typeB => 'Type B',
      ItemType.typeC => 'Type C',
      ItemType.typeD => 'Type D',
    };
  }

  Color get color {
    return switch (this) {
      ItemType.typeA => Colors.green,
      ItemType.typeB => Colors.blue,
      ItemType.typeC => Colors.orange,
      ItemType.typeD => Colors.red,
    };
  }
}
```

### Database Enums

For enums stored in database columns using Drift's `intEnum`:

```dart
// lib/database/utils/enums/item_type_enum.dart
enum ItemTypeEnum implements BaseDatabaseEnum {
  typeA(0),
  typeB(1),
  typeC(2),
  typeD(3);

  const ItemTypeEnum(this.value);

  @override
  final int value;

  // Convert from API string
  static ItemTypeEnum fromString(String value) {
    return switch (value.toLowerCase()) {
      'type_a' => ItemTypeEnum.typeA,
      'type_b' => ItemTypeEnum.typeB,
      'type_c' => ItemTypeEnum.typeC,
      'type_d' => ItemTypeEnum.typeD,
      _ => ItemTypeEnum.typeA,
    };
  }
}

// Base interface for database enums
abstract class BaseDatabaseEnum {
  int get value;
}
```

### Enum Mappers

Convert between database and feature enums:

```dart
// lib/repository/table_mappers/item_type_mapper.dart
extension ItemTypeEnumMapper on ItemTypeEnum {
  ItemType toFeatureEnum() {
    return switch (this) {
      ItemTypeEnum.typeA => ItemType.typeA,
      ItemTypeEnum.typeB => ItemType.typeB,
      ItemTypeEnum.typeC => ItemType.typeC,
      ItemTypeEnum.typeD => ItemType.typeD,
    };
  }
}

extension ItemTypeMapper on ItemType {
  ItemTypeEnum toDatabaseEnum() {
    return switch (this) {
      ItemType.typeA => ItemTypeEnum.typeA,
      ItemType.typeB => ItemTypeEnum.typeB,
      ItemType.typeC => ItemTypeEnum.typeC,
      ItemType.typeD => ItemTypeEnum.typeD,
    };
  }
}
```

## Filter Models

For managing UI filter state:

```dart
// lib/features/my_feature/models/item_filter.dart
class ItemFilter {
  const ItemFilter({
    this.type,
    this.searchQuery,
    this.sortBy = ItemSortField.name,
    this.sortDirection = SortDirection.ascending,
  });

  final ItemType? type;
  final String? searchQuery;
  final ItemSortField sortBy;
  final SortDirection sortDirection;

  ItemFilter copyWith({
    ItemType? type,
    String? searchQuery,
    ItemSortField? sortBy,
    SortDirection? sortDirection,
  }) {
    return ItemFilter(
      type: type ?? this.type,
      searchQuery: searchQuery ?? this.searchQuery,
      sortBy: sortBy ?? this.sortBy,
      sortDirection: sortDirection ?? this.sortDirection,
    );
  }

  bool get hasActiveFilters => type != null || searchQuery != null;
}
```

## DTO Type Restrictions

DTOs should only contain types that `json_serializable` can handle natively:

### Allowed Types

- **Primitives**: `String`, `int`, `double`, `bool`, `num`
- **Nullable primitives**: `String?`, `int?`, etc.
- **Collections**: `List<T>`, `Map<String, T>` (where T is an allowed type)
- **Other DTOs**: Nested DTO classes with `@JsonSerializable`

### DateTime Handling

**Store DateTime as `String` in DTOs** — parsing happens in the mapper layer:

```dart
// DTO — stores as String
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class EventDTO implements BaseDTO {
  const EventDTO({
    required this.id,
    required this.createdAt,  // String, not DateTime
    required this.updatedAt,
  });

  final String id;
  final String createdAt;     // ISO 8601 string from API
  final String? updatedAt;

  factory EventDTO.fromJson(Json json) => _$EventDTOFromJson(json);
  Json toJson() => _$EventDTOToJson(this);
}
```

```dart
// Mapper — parses to DateTime
extension EventDtoMapper on EventDTO {
  EventsTableCompanion toTableCompanion() {
    return EventsTableCompanion(
      id: Value(id),
      createdAt: Value(DateTime.parse(createdAt)),
      updatedAt: Value(updatedAt != null ? DateTime.parse(updatedAt!) : null),
    );
  }
}
```

### Why String for DateTime?

1. **Simpler serialization** — no custom `@JsonKey` converters needed
2. **API flexibility** — handles various date formats in mapper
3. **Explicit parsing** — makes the transformation visible and testable
4. **Error handling** — parse errors surface in mapper, not in JSON layer

### Forbidden in DTOs

- `DateTime` — use `String` instead
- `Duration` — use `int` (milliseconds/seconds)
- Custom classes without `@JsonSerializable`
- Enums without proper `@JsonValue` annotations or string values

## Model Location Summary

| Model Type | Location | Purpose |
|------------|----------|---------|
| Feature Model | `lib/features/[feature]/models/` | UI layer domain objects |
| Database Value Object | `lib/database/models/` | Nested JSON in DB columns |
| Database Enum | `lib/database/utils/enums/` | Drift intEnum storage |
| Feature Enum | `lib/features/[feature]/enums/` | UI display and logic |
| DTO | `lib/network/dto/` | API response parsing |

## Best Practices

1. **Keep feature models simple** — no business logic beyond display helpers
2. **Use const constructors** — enables widget optimization
3. **Separate display logic** — use extension methods for complex formatting
4. **Map enums explicitly** — avoid implicit conversions between layers
5. **Document optional fields** — clarify when null is valid
