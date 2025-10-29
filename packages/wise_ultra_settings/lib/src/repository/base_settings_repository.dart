import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise_ultra_settings/src/database/database.dart';
import 'package:wise_ultra_settings/src/features/settings/settings.dart';
import 'package:wise_ultra_settings/src/repository/mappers/user_mapper.dart';
import '../network/network.dart';

class BaseSettingsRepository implements SettingsRepository {
  BaseSettingsRepository({required this.ref});

  final Ref ref;

  @override
  Stream<User?> watchCurrentUser() {
    return ref.watch(userDaoProvider).watchUser().map((u) => u?.toFeatureModel());
  }

  @override
  Future<void> refreshCurrentUser() async {
    final userDto = await ref.read(userServiceProvider).getMe();

    await ref.read(userDaoProvider).insertUser(userCompanion: userDto.toDbCompanion());
  }

  @override
  Future<void> updateUser({required String firstName, required String lastName, DateTime? birthDate}) async {
    await ref.read(userServiceProvider).updateMe(firstName: firstName, lastName: lastName, birthDate: birthDate);
    await refreshCurrentUser();
  }
}

final baseSettingsRepositoryProvider = Provider<BaseSettingsRepository>((ref) => BaseSettingsRepository(ref: ref));
