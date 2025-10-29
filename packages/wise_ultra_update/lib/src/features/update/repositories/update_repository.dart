abstract interface class UpdateRepository {
  Future<(bool hasUpdate, bool isRequired)> checkNeedsUpdate();
}
