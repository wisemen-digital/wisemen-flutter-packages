/// Model representing a user in the settings feature.
///
/// This model contains basic user information to be displayed in the
/// settings screen's profile summary section.
///
/// Example:
/// ```dart
/// final user = User(
///   uuid: '123',
///   firstName: 'John',
///   lastName: 'Doe',
///   profilePictureUrl: 'https://example.com/avatar.jpg',
/// );
/// ```
class User {
  /// Creates a new [User] instance.
  ///
  /// All fields except [profilePictureUrl] are required.
  User({
    required this.uuid,
    required this.firstName,
    required this.lastName,
    required this.profilePictureUrl,
    required this.email,
    this.phone,
    this.mobilePhone,
    this.birthDate,
  });

  /// Unique identifier for the user.
  final String uuid;

  /// User's first name.
  final String firstName;

  /// User's last name.
  final String lastName;

  /// Optional URL to the user's profile picture.
  ///
  /// If null, initials will be displayed instead in the profile summary.
  final String? profilePictureUrl;

  final String email;

  final String? phone;

  final String? mobilePhone;

  final DateTime? birthDate;

  /// Returns the user's full name by combining first and last name.
  String get fullName => '$firstName $lastName';
}
