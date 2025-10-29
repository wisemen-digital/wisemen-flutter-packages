import 'package:drift/drift.dart';

@DataClassName('BaseSettingsUser')
class BaseSettingsUserTable extends Table {
  TextColumn get id => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get primaryEmail => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get mobilePhone => text().nullable()();
  DateTimeColumn get birthDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
