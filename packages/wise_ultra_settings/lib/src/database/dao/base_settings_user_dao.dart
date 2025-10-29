import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise_ultra_settings/src/features/settings/settings.dart';

import '../database.dart';

@DriftAccessor(tables: [BaseSettingsUserTable])
class UserDao extends DatabaseAccessor<GeneratedDatabase> with $UserDaoMixin {
  UserDao(super.attachedDatabase);

  Future<void> insertUser({required BaseSettingsUserTableCompanion userCompanion}) async {
    await (delete(baseSettingsUserTable)..where((t) => t.id.equals(userCompanion.id.value).not())).go();
    await into(baseSettingsUserTable).insertOnConflictUpdate(userCompanion);
  }

  Future<BaseSettingsUser?> getUser({required String id}) async {
    return (select(baseSettingsUserTable)..where((user) => user.id.equals(id))).getSingleOrNull();
  }

  Stream<BaseSettingsUser?> watchUser() {
    return (select(baseSettingsUserTable)..limit(1)).watchSingleOrNull();
  }
}

final userDaoProvider = Provider.autoDispose(
  (ref) => UserDao(ref.read(SettingsFeature.database)),
);
