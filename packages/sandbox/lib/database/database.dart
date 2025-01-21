import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sandbox/data/data.dart';

import 'utils/shared.dart';

part 'database.g.dart';

// ! flutter pub run build_runner watch --delete-conflicting-outputs

@DriftDatabase(
  tables: [
    AppSettingsTable,
  ],
  daos: [
    AppSettingsDao,
  ],
)
class Database extends _$Database {
  Database(super.e, this.ref);

  final Ref ref;

  @override
  int get schemaVersion => 2;

  Future<void> deleteDatabase() async {
    await transaction(() async {
      // Deleting tables in reverse topological order to avoid foreign-key conflicts
      for (final table in allTables.toList().reversed) {
        await delete(table).go();
      }
    });
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
        onUpgrade: (m, from, to) async {
          if (from < to) {
            for (final table in allTables.toList().reversed) {
              await m.deleteTable(table.actualTableName);
              await m.createTable(table);
            }
          }
        },
      );
}

@Riverpod(keepAlive: true)
Database databaseService(Ref ref) {
  return constructDb(ref: ref);
}
