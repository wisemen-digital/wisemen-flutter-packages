import 'package:drift/drift.dart';

import '../database/database.dart';
import '../tables/tables.dart';
import 'damage_form_dao.drift.dart';

@DriftAccessor(tables: [DamageFormTable])
class DamageFormDao extends DatabaseAccessor<Database> with $DamageFormDaoMixin {
  DamageFormDao(super.attachedDatabase);

  Future<void> insertDamageForm({required DamageFormTableCompanion damageForm}) async {
    await into(damageFormTable).insertOnConflictUpdate(damageForm);
  }

  Future<DamageFormObject?> getDamageForm() {
    return select(damageFormTable).getSingleOrNull();
  }
}
