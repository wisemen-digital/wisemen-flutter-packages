class User {
  final String uuid;
  final String firstName;
  final String lastName;
  final String? profilePictureUrl;

  User({required this.uuid, required this.firstName, required this.lastName, required this.profilePictureUrl});

  String get fullName => '$firstName $lastName';
}
