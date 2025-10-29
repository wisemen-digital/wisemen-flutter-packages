// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:drift/src/runtime/api/runtime_api.dart' as i1;
import 'package:wise_ultra_settings/src/database/tables/base_settings_user_table.drift.dart'
    as i2;
import 'package:drift/internal/modular.dart' as i3;

mixin $UserDaoMixin on i0.DatabaseAccessor<i1.GeneratedDatabase> {
  i2.$BaseSettingsUserTableTable get baseSettingsUserTable =>
      i3.ReadDatabaseContainer(attachedDatabase)
          .resultSet<i2.$BaseSettingsUserTableTable>(
              'base_settings_user_table');
}
