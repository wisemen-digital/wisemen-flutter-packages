import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/features/settings/settings.dart';
import 'package:sandbox/utils/utils.dart';

class UserRepositoryImpl implements SettingsRepository {
  const UserRepositoryImpl({required this.ref});
  final Ref ref;

  @override
  Future<void> getMe() async {
    final result = await ref.read(appRepositoryServiceProvider).api.userService.getMe();
    print(result);
  }

  @override
  Stream<String> get userName => Stream.value('throw UnimplementedError()');
}

final userRepository = Provider<UserRepositoryImpl>(
  (ref) => UserRepositoryImpl(ref: ref),
);
