import '../settings.dart';

abstract interface class SettingsRepository {
  Future<void> getMe();
  Stream<User?> get user;
}
