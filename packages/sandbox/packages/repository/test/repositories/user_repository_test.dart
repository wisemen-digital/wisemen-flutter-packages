import 'package:repository/repository.dart';
import 'package:test/test.dart';

import '../utils/utils.dart';

void main() {
  setUpAll(MockApp.init);
  tearDownAll(MockApp.tear);

  test('UserRepository can get user', () async {
    final repo = MockApp.providerContainer.read(userRepository);
    await repo.getMe();
    final user = await repo.user.first;

    expect(user?.firstName, equals('John'));
  });
}
