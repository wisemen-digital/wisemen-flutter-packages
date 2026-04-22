---
applyTo: '**/network/**'
description: 'Use when working with API services, DTOs, HTTP clients, or mappers. Covers the network layer structure, json_serializable patterns, service class patterns, DTO-to-database mappers, and client configuration.'
---

# Network Guidelines

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     SERVICE LAYER                           │
│  API operations (ItemService, AuthService)                  │
├─────────────────────────────────────────────────────────────┤
│                     CLIENT LAYER                            │
│  HTTP handling (protected_client, unprotected_client)       │
├─────────────────────────────────────────────────────────────┤
│                      DTO LAYER                              │
│  API response shapes (json_serializable)                    │
└─────────────────────────────────────────────────────────────┘
         │
         ▼ DTO Mappers transform to database companions
┌─────────────────────────────────────────────────────────────┐
│                   DATABASE LAYER                            │
└─────────────────────────────────────────────────────────────┘
```

## Directory Structure

```
lib/network/
├── clients/
│   ├── protected_client.dart      # Authenticated requests
│   └── unprotected_client.dart    # Public endpoints (login)
│
├── dto/
│   ├── shared/                    # Shared DTOs (pagination, errors)
│   ├── my_feature/                # Feature-specific DTOs
│   │   ├── item_dto.dart
│   │   └── item_dto.g.dart        # Generated
│   └── ...
│
├── services/
│   ├── item_service.dart          # API operations
│   └── ...
│
└── utils/
    ├── base_dto.dart              # Base interface
    └── paginated.dart             # Pagination wrapper
```

## DTO Pattern

DTOs represent API response shapes. Use `json_serializable` for code generation.

### Base Interface

```dart
// lib/network/utils/base_dto.dart
typedef Json = Map<String, dynamic>;

abstract class BaseDTO {
  factory BaseDTO.fromJson(Json json) {
    throw UnimplementedError('fromJson must be implemented');
  }
  
  Json toJson();
}
```

### DTO Implementation

```dart
// lib/network/dto/my_feature/item_dto.dart
import 'package:json_annotation/json_annotation.dart';

import '../../utils/base_dto.dart';

part 'item_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ItemDTO implements BaseDTO {
  const ItemDTO({
    required this.itemId,
    required this.itemName,
    required this.type,
    this.description,
    this.imageUrl,
    this.createdAt,
  });

  final String itemId;
  final String itemName;
  final String type;
  final String? description;
  final String? imageUrl;
  final DateTime? createdAt;

  @override
  factory ItemDTO.fromJson(Json json) => _$ItemDTOFromJson(json);

  @override
  Json toJson() => _$ItemDTOToJson(this);
}
```

### Key DTO Conventions

| Convention | Example |
|------------|---------|
| Snake case conversion | `fieldRename: FieldRename.snake` |
| Nested serialization | `explicitToJson: true` |
| Const constructor | `const ItemDTO({...})` |
| Nullable optionals | `final String? avatarUrl` |
| DateTime handling | Automatic ISO 8601 parsing |

### Nested DTOs

```dart
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ItemDetailDTO implements BaseDTO {
  const ItemDetailDTO({
    required this.item,
    required this.metadata,
    required this.relatedItems,
  });

  final ItemDTO item;
  final ItemMetadataDTO metadata;
  final List<ItemDTO> relatedItems;

  @override
  factory ItemDetailDTO.fromJson(Json json) => _$ItemDetailDTOFromJson(json);

  @override
  Json toJson() => _$ItemDetailDTOToJson(this);
}
```

## Pagination Wrapper

```dart
// lib/network/utils/paginated.dart
class Paginated<T> {
  const Paginated({
    required this.items,
    required this.total,
    required this.offset,
    required this.limit,
  });

  final List<T> items;
  final int total;
  final int offset;
  final int limit;

  bool get hasMore => offset + items.length < total;

  factory Paginated.fromJson(
    Json json,
    T Function(Json) fromJsonT,
  ) {
    return Paginated(
      items: (json['items'] as List).map((e) => fromJsonT(e as Json)).toList(),
      total: json['total'] as int,
      offset: json['offset'] as int,
      limit: json['limit'] as int,
    );
  }
}
```

## Service Pattern

Services handle API operations. Each service is a plain class with `Ref` injection.

```dart
// lib/network/services/item_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../clients/protected_client.dart';
import '../dto/my_feature/item_dto.dart';
import '../utils/paginated.dart';

class ItemService {
  const ItemService(this.ref);
  final Ref ref;

  // ═══════════════════════════════════════════════════════════════
  // GET REQUESTS
  // ═══════════════════════════════════════════════════════════════

  Future<Paginated<ItemDTO>> getPaginatedItems({
    required int offset,
    required int limit,
    String? search,
    String? sortColumn,
    SortDirection? sortDirection,
  }) async {
    final result = await ref.read(protectedClientProvider).get(
      '/api/v1/items',
      queryParameters: {
        'offset': offset,
        'limit': limit,
        if (search != null) 'search': search,
        if (sortColumn != null) 'sort_column': sortColumn,
        if (sortDirection != null) 'sort_direction': sortDirection.name,
      },
    );
    return Paginated.fromJson(result, ItemDTO.fromJson);
  }

  Future<ItemDTO> getItemById({required String id}) async {
    final result = await ref.read(protectedClientProvider).get('/api/v1/items/$id');
    return ItemDTO.fromJson(result);
  }

  // ═══════════════════════════════════════════════════════════════
  // POST/PUT/DELETE REQUESTS
  // ═══════════════════════════════════════════════════════════════

  Future<ItemDTO> createItem({required Map<String, dynamic> body}) async {
    final result = await ref.read(protectedClientProvider).post(
      '/api/v1/items',
      body: body,
    );
    return ItemDTO.fromJson(result);
  }

  Future<ItemDTO> updateItem({
    required String id,
    required Map<String, dynamic> body,
  }) async {
    final result = await ref.read(protectedClientProvider).put(
      '/api/v1/items/$id',
      body: body,
    );
    return ItemDTO.fromJson(result);
  }

  Future<void> deleteItem({required String id}) async {
    await ref.read(protectedClientProvider).delete('/api/v1/items/$id');
  }
}

// Provider registration
final itemServiceProvider = Provider<ItemService>((ref) => ItemService(ref));
```

## DTO Mappers

Located in `lib/repository/dto_mappers/`. Transform DTOs to database companions.

```dart
// lib/repository/dto_mappers/my_feature/item_dto_mapper.dart
import 'package:drift/drift.dart';

import '../../../database/database.dart';
import '../../../network/network.dart';

extension ItemDtoMapper on ItemDTO {
  /// Maps DTO to database table companion for insertion
  ItemsTableCompanion toTableCompanion() {
    return ItemsTableCompanion(
      id: Value(itemId),
      name: Value(itemName),
      type: Value(ItemTypeEnum.fromString(type)),
      description: Value(description),
      imageUrl: Value(imageUrl),
      createdAt: Value(createdAt),
    );
  }

  /// Maps DTO directly to feature model (skip database)
  Item toFeatureModel() {
    return Item(
      id: itemId,
      name: itemName,
      type: ItemTypeEnum.fromString(type).toFeatureEnum(),
      description: description,
      imageUrl: imageUrl,
    );
  }
}
```

### Nested Data Mapping

```dart
extension ItemDetailDtoMapper on ItemDetailDTO {
  ItemsTableCompanion toTableCompanion() {
    return ItemsTableCompanion(
      id: Value(item.itemId),
      name: Value(item.itemName),
      type: Value(ItemTypeEnum.fromString(item.type)),
      // Map nested objects to JSON columns
      metadata: Value(metadata.toDatabaseModel()),
    );
  }
}

extension ItemMetadataDtoMapper on ItemMetadataDTO {
  ItemMetadata toDatabaseModel() {
    return ItemMetadata(
      category: category,
      isActive: isActive,
      source: source,
    );
  }
}
```

## HTTP Client Pattern

```dart
// lib/network/clients/protected_client.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'protected_client.g.dart';

@Riverpod(keepAlive: true)
class ProtectedClient extends _$ProtectedClient {
  @override
  HttpClient build() {
    return HttpClient(
      baseUrl: AppConfig.baseUrl,
      interceptors: [
        AuthInterceptor(
          tokenProvider: () => ref.read(authTokenProvider),
          onTokenExpired: () => ref.read(authProvider.notifier).logout(),
        ),
      ],
    );
  }
}
```

## Code Generation

After modifying DTOs, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Best Practices

1. **Keep DTOs flat** — match API shape exactly, transform in mappers
2. **Use `const` constructors** — enables immutability
3. **Handle nulls explicitly** — `?` for optional fields
4. **Separate read/write DTOs** — if request shape differs from response
5. **Test mappers** — ensure all fields are correctly transformed
6. **Use snake_case in JSON** — `fieldRename: FieldRename.snake`
