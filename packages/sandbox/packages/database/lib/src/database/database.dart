import 'package:drift/drift.dart';

import '../tables/tables.dart';
import 'database.drift.dart';

@DriftDatabase(tables: [UserTable])
class Database extends $Database {
  Database(super.e);

  @override
  int get schemaVersion => 241;

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
        for (final table in allTables) {
          await m.deleteTable(table.actualTableName);
          await m.createTable(table);
        }
      }
    },
  );
}
