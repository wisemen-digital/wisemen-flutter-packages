// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:wise_ultra_settings/src/database/tables/base_settings_user_table.drift.dart'
    as i1;
import 'package:wise_ultra_settings/src/database/dao/base_settings_user_dao.dart'
    as i2;
import 'package:drift/src/runtime/api/runtime_api.dart' as i3;

abstract class $Database extends i0.GeneratedDatabase {
  $Database(i0.QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final i1.$BaseSettingsUserTableTable baseSettingsUserTable = i1
      .$BaseSettingsUserTableTable(this);
  late final i2.UserDao userDao = i2.UserDao(this as i3.GeneratedDatabase);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [
    baseSettingsUserTable,
  ];
  @override
  i0.DriftDatabaseOptions get options =>
      const i0.DriftDatabaseOptions(storeDateTimeAsText: true);
}

class $DatabaseManager {
  final $Database _db;
  $DatabaseManager(this._db);
  i1.$$BaseSettingsUserTableTableTableManager get baseSettingsUserTable => i1
      .$$BaseSettingsUserTableTableTableManager(_db, _db.baseSettingsUserTable);
}
