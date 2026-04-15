---
applyTo: '**/*repository*.dart'
description: 'Use when creating repositories, understanding the repository pattern, or implementing data flow between network and database layers. Covers the two-layer pattern (interface + implementation), stream patterns, and fetch/watch operations.'
---

# Repositories Guidelines

## Two-Layer Repository Pattern

Repositories use two layers:
1. **Interface** — defined in feature, declares the contract
2. **Implementation** — in `lib/repository/`, orchestrates data flow

```
┌─────────────────────────────────────────────┐
│ Feature Layer                                │
│  └── MyRepository (interface)               │
├─────────────────────────────────────────────┤
│ Repository Layer                             │
│  └── MyRepositoryImpl (implementation)      │
│       ├── → Network Service (fetch)         │
│       ├── → DAO (store/watch)               │
│       └── → Mappers (transform)             │
└─────────────────────────────────────────────┘
```

## Repository Interface

Located in `lib/features/[feature]/repositories/`:

```dart
// lib/features/my_feature/repositories/item_repository.dart
abstract class ItemRepository {
  // Watch methods return streams for reactive updates
  Stream<List<Item>> watchItems();
  Stream<Item?> watchItemById({required String id});
  
  // Fetch methods get data from API and store locally
  Future<void> fetchItems();
  Future<void> fetchItemById({required String id});
  
  // Mutation methods
  Future<void> updateItem({required String id, required ItemUpdate update});
  Future<void> deleteItem({required String id});
}
```

## Repository Implementation

Located in `lib/repository/repositories/`:

```dart
// lib/repository/repositories/item_repository_impl.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemRepositoryImpl implements ItemRepository {
  const ItemRepositoryImpl({required this.ref});
  final Ref ref;

  // ═══════════════════════════════════════════════════════════════
  // WATCH METHODS — Return streams from database
  // ═══════════════════════════════════════════════════════════════

  @override
  Stream<List<Item>> watchItems() {
    return ref.watch(itemDaoProvider).watchAll().map(
          (items) => items.map((item) => item.toFeatureModel()).toList(),
        );
  }

  @override
  Stream<Item?> watchItemById({required String id}) {
    return ref.watch(itemDaoProvider).watchById(id: id).map(
          (item) => item?.toFeatureModel(),
        );
  }

  // ═══════════════════════════════════════════════════════════════
  // FETCH METHODS — Get from API, transform, store in database
  // ═══════════════════════════════════════════════════════════════

  @override
  Future<void> fetchItems() async {
    // 1. Fetch from network
    final result = await ref.read(itemServiceProvider).getItems();
    
    // 2. Transform DTOs to database companions
    final companions = result.map((dto) => dto.toTableCompanion()).toList();
    
    // 3. Store in database
    await ref.read(itemDaoProvider).insertItems(companions);
  }

  @override
  Future<void> fetchItemById({required String id}) async {
    final dto = await ref.read(itemServiceProvider).getItemById(id: id);
    await ref.read(itemDaoProvider).insertItem(dto.toTableCompanion());
  }

  // ═══════════════════════════════════════════════════════════════
  // MUTATION METHODS — API call + local update
  // ═══════════════════════════════════════════════════════════════

  @override
  Future<void> updateItem({required String id, required ItemUpdate update}) async {
    // 1. Send to API
    final dto = await ref.read(itemServiceProvider).updateItem(
      id: id,
      body: update.toRequestBody(),
    );
    
    // 2. Update local database
    await ref.read(itemDaoProvider).insertItem(dto.toTableCompanion());
  }

  @override
  Future<void> deleteItem({required String id}) async {
    await ref.read(itemServiceProvider).deleteItem(id: id);
    await ref.read(itemDaoProvider).deleteItem(id: id);
  }
}

// Provider registration
final itemRepositoryProvider = Provider<ItemRepository>(
  (ref) => ItemRepositoryImpl(ref: ref),
);
```

## Data Flow Pattern

```
1. FETCH TRIGGERED
   UI calls provider.refresh() → Repository.fetch*()

2. NETWORK REQUEST
   Repository → Service.get*() → HTTP Client → API
   ← Returns DTO

3. TRANSFORMATION
   DTO.toTableCompanion() → Creates database companion
   (Uses DTO mapper extension)

4. DATABASE WRITE
   Repository → DAO.insert*() → Drift upsert operation

5. STREAM EMITS
   DAO.watch*() automatically emits new data

6. UI UPDATES
   Stream maps to feature model → Provider rebuilds → Widget rebuilds
```

## Pagination Pattern

For paginated lists with search:

```dart
@override
Future<void> fetchItems({
  int offset = 0,
  int limit = 20,
  String? search,
}) async {
  final result = await ref.read(itemServiceProvider).getPaginatedItems(
    offset: offset,
    limit: limit,
    search: search,
  );

  final companions = result.items.map((dto) {
    return dto.toTableCompanion();
  }).toList();

  await ref.read(itemDaoProvider).insertItems(companions);
}
```

## Watch with Filters

```dart
@override
Stream<List<Item>> watchItems({ItemFilter? filter}) {
  return ref.watch(itemDaoProvider).watchFiltered(
    type: filter?.type?.toDatabaseEnum(),
    search: filter?.searchQuery,
    sortBy: filter?.sortBy.toColumnName(),
    sortDirection: filter?.sortDirection,
  ).map((items) => items.map((item) => item.toFeatureModel()).toList());
}
```

## Top N Items Pattern

For dashboard widgets showing limited items:

```dart
@override
Stream<List<Item>> watchTopItems({int limit = 5}) {
  return ref.watch(itemDaoProvider).watchTopN(limit: limit)
      .map((items) => items.map((item) => item.toFeatureModel()).toList());
}

@override
Future<void> fetchTopItems() async {
  final result = await ref.read(itemServiceProvider).getPaginatedItems(
    offset: 0,
    limit: 5,
    sortColumn: 'created_at',
    sortDirection: SortDirection.descending,
  );

  final companions = result.items.map((dto) {
    return dto.toTableCompanion();
  }).toList();

  await ref.read(itemDaoProvider).insertItems(companions);
}
```

## Repository Registration

Register in `feature_init_util.dart`:

```dart
void initFeatures() {
  MyFeature.init(repository: itemRepositoryProvider);
}
```

Access in providers via feature class:

```dart
@riverpod
class ItemsProvider extends _$ItemsProvider {
  @override
  Stream<List<Item>> build() {
    return ref.watch(MyFeature.itemRepository).watchItems();
  }
}
```

## Best Practices

1. **Watch for reads, fetch for writes** — streams enable reactive UI
2. **Transform at boundaries** — DTO→Companion in fetch, Object→Model in watch
3. **Handle pagination state** — track offset, search flags in companion
4. **Use `ref.watch` for DAOs** — enables stream updates
5. **Use `ref.read` for services** — one-time calls for API requests
6. **Keep repositories thin** — orchestration only, no business logic
