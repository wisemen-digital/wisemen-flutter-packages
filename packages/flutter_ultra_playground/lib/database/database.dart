import 'package:drift/drift.dart';
import 'package:flutter_ultra_playground/database/database.drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_ultra_settings/wise_ultra_settings.dart';

import 'utils/shared.dart';

// ! flutter pub run build_runner watch --delete-conflicting-outputs

@DriftDatabase(tables: [BaseSettingsUserTable], daos: [UserDao])
class Database extends $Database {
  Database(super.e, this.ref);

  final Ref ref;

  @override
  int get schemaVersion => 1;

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

final databaseProvider = Provider<GeneratedDatabase>((ref) {
  return constructDb(ref: ref);
});
