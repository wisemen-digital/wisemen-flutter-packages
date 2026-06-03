import 'package:database/database.dart';
import 'package:test/test.dart';

import '../utils/utils.dart';

void main() {
  setUpAll(MockDatabase.init);
  tearDownAll(MockDatabase.tearDown);

  const _userCompanion = UserTableCompanion(
    uuid: Value('1234'),
    email: Value('test@example.com'),
    firstName: Value('John'),
    lastName: Value('Doe'),
    roles: Value([
      Role(name: 'tester', isDefault: true, isSystemAdmin: false, uuid: '1'),
    ]),
  );

  test('Can insert user', () async {
    final userDao = UserDao(MockDatabase.database);
    await userDao.insertUser(user: _userCompanion);
    final user = await MockDatabase.database.userTable.select().getSingleOrNull();
    expect(user, isA<UserObject>());
  });

  test('Can watch user', () async {
    final userDao = UserDao(MockDatabase.database);
    await userDao.insertUser(user: _userCompanion);
    final stream = userDao.watchUser();
    final user = await stream.first;

    expect(user?.firstName, equals('John'));
  });
}
