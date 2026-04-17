abstract interface class SettingsRepository {
  Future<void> getMe();
  Stream<String> get userName;
}
