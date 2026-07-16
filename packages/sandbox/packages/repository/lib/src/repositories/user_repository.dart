import 'package:database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repository/repository.dart';
import 'package:sandbox/features/settings/settings.dart';
import 'package:sandbox/utils/utils.dart';

class UserRepositoryImpl implements SettingsRepository {
  const UserRepositoryImpl({required this.ref});
  final Ref ref;

  UserDao get userDao => ref.read(appRepositoryServiceProvider).database.userDao;

  @override
  Future<void> getMe() async {
    final result = await ref.read(appRepositoryServiceProvider).api.userService.getMe();
    await userDao.insertUser(user: result.toCompanion());
  }

  @override
  Stream<User?> get user => userDao.watchUser().map((user) => user?.toFeature());
}

final userRepository = Provider<UserRepositoryImpl>(
  (ref) => UserRepositoryImpl(ref: ref),
);
