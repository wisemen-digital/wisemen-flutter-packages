import 'package:drift/drift.dart';
import 'package:flutter/material.dart' as m;

@DataClassName('AppSettings')
class AppSettingsTable extends Table {
  TextColumn get id => text()();
  IntColumn get themeMode => intEnum<m.ThemeMode>().withDefault(
        Constant(
          m.ThemeMode.system.index,
        ),
      )();

  @override
  Set<Column> get primaryKey => {id};
}
