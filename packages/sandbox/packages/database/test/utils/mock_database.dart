import 'package:database/database.dart';
import 'package:drift/native.dart';

class MockDatabase {
  static late Database database;

  static void init() {
    database = Database(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
  }

  static void tearDown() {
    database.close();
  }
}
