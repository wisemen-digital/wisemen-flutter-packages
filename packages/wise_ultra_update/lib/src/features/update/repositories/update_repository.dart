/// Interface for checking if an app update is available.
// ignore: one_member_abstracts
abstract interface class UpdateRepository {
  /// Checks if an update is needed for the current app version.
  ///
  /// Returns a record containing:
  /// - `hasUpdate`: true if an update is available
  /// - `isRequired`: true if the update is mandatory
  Future<(bool hasUpdate, bool isRequired)> checkNeedsUpdate();
}
