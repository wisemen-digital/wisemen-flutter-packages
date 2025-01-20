import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sandbox/data/table/app_settings_table.dart';
import 'package:sandbox/database/database.dart';

part 'app_settings_dao.g.dart';

const _appSettingsId = 'app_settings_id';

@DriftAccessor(tables: [AppSettingsTable])
class AppSettingsDao extends DatabaseAccessor<Database>
    with _$AppSettingsDaoMixin {
  AppSettingsDao(super.attachedDatabase);

  Future<void> updateThemeMode(ThemeMode brightness) async {
    await into(appSettingsTable).insertOnConflictUpdate(
      AppSettingsTableCompanion.insert(
        id: _appSettingsId,
        themeMode: Value(brightness),
      ),
    );
  }

  Stream<AppSettings?> watchAppSettings() => (select(appSettingsTable)
        ..where(
          (tbl) => tbl.id.equals(_appSettingsId),
        ))
      .watchSingleOrNull();
}

@riverpod
AppSettingsDao appSettingsDao(Ref ref) {
  return AppSettingsDao(ref.read(databaseServiceProvider));
}
