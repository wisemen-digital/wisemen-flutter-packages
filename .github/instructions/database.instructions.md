---
applyTo: '**/database/**'
description: 'Use when working with Drift database, tables, DAOs, migrations, or value objects stored in database. Covers table definitions, DAO patterns, TypeConverters for nested JSON, and reactive queries.'
---

# Database Guidelines

## Directory Structure

```
lib/database/
├── database.dart              # Database class with migrations
├── database.g.dart            # Generated code
│
├── tables/
│   ├── items_table.dart       # Table definitions
│   └── ...
│
├── dao/
│   ├── items_dao.dart         # Data Access Objects
│   └── ...
│
├── models/
│   └── item/
│       └── item_details.dart  # Value objects for JSON columns
│
└── utils/
    ├── enums/                 # Database enums
    └── converters/            # Custom TypeConverters
```

## Database Class

```dart
// lib/database/database.dart
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dao/items_dao.dart';
import 'tables/items_table.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [ItemsTable],
  daos: [ItemsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle migrations
        await customStatement('PRAGMA foreign_keys = ON');
        
        // Example: recreate tables on schema change
        if (from < to) {
          await m.deleteTable('items');
          await m.createTable(itemsTable);
        }
      },
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'app_database');
  }
}

// Provider
final databaseProvider = Provider<AppDatabase>((ref) => AppDatabase());
```

## Table Definition

```dart
// lib/database/tables/items_table.dart
import 'package:drift/drift.dart';

import '../models/item/item_details.dart';
import '../utils/enums/item_type_enum.dart';

@DataClassName('ItemObject')
class ItemsTable extends Table {
  // Primary key
  TextColumn get id => text()();

  // Basic fields
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();

  // Enum stored as int
  IntColumn get type => intEnum<ItemTypeEnum>()();

  // Nullable fields
  TextColumn get imageUrl => text().nullable()();

  // JSON column with TypeConverter
  TextColumn get details => text()
      .map(ItemDetails.converter)
      .nullable()();

  // List stored as JSON
  TextColumn get tags => text()
      .map(const StringListConverter())
      .withDefault(const Constant('[]'))();

  @override
  Set<Column> get primaryKey => {id};
}
```

## DAO Pattern

```dart
// lib/database/dao/items_dao.dart
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database.dart';
import '../tables/items_table.dart';

part 'items_dao.g.dart';

@DriftAccessor(tables: [ItemsTable])
class ItemsDao extends DatabaseAccessor<AppDatabase> with _$ItemsDaoMixin {
  ItemsDao(super.db);

  // ═══════════════════════════════════════════════════════════════
  // WRITE OPERATIONS
  // ═══════════════════════════════════════════════════════════════

  /// Insert or update items
  /// 
  /// Cleanup strategies (choose based on use case):
  /// - **Replace all**: Delete items not in companions (full sync, used here)
  /// - **Stale threshold**: Delete where `updatedAt < DateTime.now().subtract(duration)`
  ///   (partial sync / pagination — keeps items from other pages)
  Future<void> insertItems(List<ItemsTableCompanion> items) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(itemsTable, items);
    });

    // Remove items not in the new set
    final ids = items.map((e) => e.id.value).toSet();
    await (delete(itemsTable)..where((t) => t.id.isNotIn(ids))).go();
  }

  /// Insert single item
  Future<void> insertItem(ItemsTableCompanion item) async {
    await into(itemsTable).insertOnConflictUpdate(item);
  }

  /// Delete item by ID
  Future<void> deleteItem({required String id}) async {
    await (delete(itemsTable)..where((t) => t.id.equals(id))).go();
  }

  // ═══════════════════════════════════════════════════════════════
  // WATCH OPERATIONS — Reactive streams
  // ═══════════════════════════════════════════════════════════════

  /// Watch all items
  Stream<List<ItemObject>> watchAll() {
    return (select(itemsTable)
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .watch();
  }

  /// Watch single item by ID
  Stream<ItemObject?> watchById({required String id}) {
    return (select(itemsTable)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  /// Watch with filters
  Stream<List<ItemObject>> watchFiltered({
    ItemTypeEnum? type,
    String? search,
  }) {
    return (select(itemsTable)
          ..where((t) {
            Expression<bool> condition = const Constant(true);
            if (type != null) {
              condition = condition & t.type.equals(type.index);
            }
            if (search != null && search.isNotEmpty) {
              condition = condition & 
                  t.name.lower().contains(search.toLowerCase());
            }
            return condition;
          })
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .watch();
  }
}

// Provider
final itemsDaoProvider = Provider<ItemsDao>(
  (ref) => ItemsDao(ref.read(databaseProvider)),
);
```

## Value Objects (JSON Columns)

```dart
// lib/database/models/item/item_details.dart
class ItemDetails {
  const ItemDetails({
    required this.category,
    required this.isActive,
    this.metadata,
  });

  final String category;
  final bool isActive;
  final String? metadata;

  factory ItemDetails.fromJson(Map<String, dynamic> json) {
    return ItemDetails(
      category: json['category'] as String? ?? 'default',
      isActive: json['is_active'] as bool? ?? true,
      metadata: json['metadata'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'category': category,
        'is_active': isActive,
        if (metadata != null) 'metadata': metadata,
      };

  // Drift TypeConverter for single object
  static TypeConverter<ItemDetails, String> get converter =>
      TypeConverter.json(
        fromJson: (json) => ItemDetails.fromJson(json as Map<String, dynamic>),
        toJson: (details) => details.toJson(),
      );

  // Drift TypeConverter for list
  static TypeConverter<List<ItemDetails>, String> get listConverter =>
      TypeConverter.json(
        fromJson: (json) => (json as List)
            .map((e) => ItemDetails.fromJson(e as Map<String, dynamic>))
            .toList(),
        toJson: (list) => list.map((e) => e.toJson()).toList(),
      );
}
```

## Database Object to Feature Model Mapper

Located in `lib/repository/table_mappers/`:

```dart
// lib/repository/table_mappers/item/item_object_mapper.dart
extension ItemObjectMapper on ItemObject {
  Item toFeatureModel() {
    return Item(
      id: id,
      name: name,
      description: description,
      type: type.toFeatureEnum(),
      imageUrl: imageUrl,
      details: details?.toFeatureModel(),
    );
  }
}
```

## Custom Type Converters

```dart
// lib/database/utils/converters/string_list_converter.dart
class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.isEmpty || fromDb == '[]') return [];
    return (jsonDecode(fromDb) as List).cast<String>();
  }

  @override
  String toSql(List<String> value) {
    return jsonEncode(value);
  }
}
```

## Combining Streams with RxDart

Use RxDart to combine streams from multiple tables for complex reactive queries:

```dart
// lib/repository/order_repository.dart
import 'package:rxdart/rxdart.dart';

class OrderRepositoryImpl implements OrderRepository {
  const OrderRepositoryImpl({required this.ref});
  final Ref ref;

  /// Combine orders with their related items and customer data
  @override
  Stream<List<OrderWithDetails>> watchOrdersWithDetails() {
    final ordersDao = ref.read(ordersDaoProvider);
    final itemsDao = ref.read(itemsDaoProvider);
    final customersDao = ref.read(customersDaoProvider);

    return Rx.combineLatest3(
      ordersDao.watchAll(),
      itemsDao.watchAll(),
      customersDao.watchAll(),
      (List<OrderObject> orders, List<ItemObject> items, List<CustomerObject> customers) {
        final itemsById = {for (final item in items) item.id: item};
        final customersById = {for (final c in customers) c.id: c};

        return orders.map((order) {
          return OrderWithDetails(
            order: order.toFeatureModel(),
            items: order.itemIds
                .map((id) => itemsById[id]?.toFeatureModel())
                .whereType<Item>()
                .toList(),
            customer: customersById[order.customerId]?.toFeatureModel(),
          );
        }).toList();
      },
    );
  }
}
```

### Common RxDart Operators

```dart
// combineLatest2/3/4... — emit when ANY stream emits (after all have emitted once)
Rx.combineLatest2(streamA, streamB, (a, b) => combine(a, b));

// switchMap — flatten nested streams, cancel previous
userIdStream.switchMap((id) => watchUserById(id));

// debounceTime — wait for pause in emissions (good for search)
searchStream.debounceTime(const Duration(milliseconds: 300));

// distinctUnique — skip consecutive duplicates
stream.distinct();
```

## Code Generation

After modifying tables or DAOs:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Best Practices

1. **Use `.watch()` for streams** — enables reactive UI updates
2. **Batch writes** — wrap multiple inserts in `batch()`
3. **Null safety** — use `.nullable()` for optional columns
4. **JSON for nested data** — complex objects as JSON in text columns
5. **Feature-specific DAOs** — one DAO per feature, can span multiple tables
