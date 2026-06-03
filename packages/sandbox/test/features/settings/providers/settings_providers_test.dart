import 'package:database/src/daos/user_dao.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repository/repository.dart';
import 'package:sandbox/features/settings/settings.dart';

import '../../../utils/utils.dart';

class SettingsRepositoryMock extends Mock implements UserRepositoryImpl {
  SettingsRepositoryMock();

  User? _user = User(
    email: 'test@example.com',
    firstName: 'John',
    lastName: 'Doe',
  );

  @override
  Stream<User?> get user => Stream.value(_user);

  @override
  Future<void> getMe() async {
    _user = User(
      email: 'test@example.com',
      firstName: 'Jane',
      lastName: 'Doe',
    );
  }

  @override
  Ref get ref => throw UnimplementedError();

  @override
  UserDao get userDao => throw UnimplementedError();
}

void main() {
  setUpAll(MockApp.init);
  tearDownAll(MockApp.tear);

  test('Refresh updates the user', () async {
    final repo = SettingsRepositoryMock();
    final container = ProviderContainer.test(
      overrides: [
        SettingsFeature.settingsRepository.overrideWithValue(repo),
      ],
    );

    final notifier = container.read(SettingsProviders.user.notifier);
    await notifier.refresh();
    // Here for coverage
    notifier.onError(Exception('Test exception'), StackTrace.current);

    expect(repo._user?.firstName, equals('Jane'));
  });
}
