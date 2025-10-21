import '../settings.dart';

abstract interface class SettingsRepository {
  Stream<User?> watchCurrentUser();
}
