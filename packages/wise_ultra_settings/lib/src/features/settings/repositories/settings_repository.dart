// ignore_for_file: one_member_abstracts

import '../settings.dart';

/// Interface for accessing user data in the settings feature.
///
/// Implement this interface to provide user information for display in
/// the settings screen. This is optional and can be omitted if you handle
/// user data differently.
///
/// Example:
/// ```dart
/// @Riverpod(keepAlive: true)
/// class MySettingsRepository extends _$MySettingsRepository
///     implements SettingsRepository {
///
///   @override
///   Stream<User?> build() {
///     return watchCurrentUser();
///   }
///
///   @override
///   Stream<User?> watchCurrentUser() {
///     // Return a stream of the current user from your data source
///     return authService.userStream.map((authUser) => User(
///       uuid: authUser.id,
///       firstName: authUser.firstName,
///       lastName: authUser.lastName,
///       profilePictureUrl: authUser.avatarUrl,
///     ));
///   }
/// }
/// ```
abstract interface class SettingsRepository {
  /// Returns a stream of the current authenticated user.
  ///
  /// The stream should emit a new [User] whenever the user data changes,
  /// or null if no user is authenticated. This is used to display user
  /// information in the profile summary section of the settings screen.
  Stream<User?> watchCurrentUser();
  Future<void> refreshCurrentUser();
  Future<void> updateUser({
    required String firstName,
    required String lastName,
    DateTime? birthDate,
  });
}
