import 'package:drift/drift.dart';

import '../database/database.dart';
import '../tables/tables.dart';
import 'user_dao.drift.dart';

@DriftAccessor(tables: [UserTable])
class UserDao extends DatabaseAccessor<Database> with $UserDaoMixin {
  UserDao(super.attachedDatabase);

  Future<void> insertUser({required UserTableCompanion user}) async {
    await into(userTable).insertOnConflictUpdate(user);
  }

  Stream<UserObject?> watchUser() {
    return select(userTable).watchSingleOrNull();
  }
}
