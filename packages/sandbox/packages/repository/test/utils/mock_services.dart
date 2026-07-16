import 'dart:ffi';

import 'package:database/database.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repository/repository.dart';
import 'package:sandbox/utils/utils.dart';
import 'package:sqlite3/open.dart';

class MockApp {
  static late final ProviderContainer providerContainer;

  static void init() {
    initFeatures();
    open.overrideFor(OperatingSystem.macOS, () {
      return DynamicLibrary.open('/usr/lib/libsqlite3.dylib');
    });
    providerContainer = ProviderContainer(
      overrides: [
        appRepositoryServiceProvider.overrideWithValue(
          RepositoryService.mock(
            database: Database(
              DatabaseConnection(
                NativeDatabase.memory(),
                closeStreamsSynchronously: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static void tear() {
    providerContainer.dispose();
  }
}
