import 'package:drift/drift.dart';

const int damageFormId = 1;

@DataClassName('DamageFormObject')
class DamageFormTable extends Table {
  IntColumn get id => integer()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text()();
  IntColumn get price => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
