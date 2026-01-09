import 'package:drift/drift.dart';

import '../models/role.dart';

@DataClassName('UserObject')
class UserTable extends Table {
  TextColumn get uuid => text()();
  TextColumn get firstName => text().nullable()();
  TextColumn get lastName => text().nullable()();
  TextColumn get email => text()();
  TextColumn get roles => text().map(RolesListConverter())();

  @override
  Set<Column> get primaryKey => {uuid};
}
