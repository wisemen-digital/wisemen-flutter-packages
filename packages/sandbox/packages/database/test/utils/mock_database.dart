import 'dart:ffi';

import 'package:database/database.dart';
import 'package:drift/native.dart';
import 'package:sqlite3/open.dart';

class MockDatabase {
  static late Database database;

  static void init() {
    open.overrideFor(OperatingSystem.macOS, () {
      return DynamicLibrary.open('/usr/lib/libsqlite3.dylib');
    });
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
