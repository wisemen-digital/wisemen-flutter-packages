import 'package:database/database.dart';
import 'package:sandbox/features/settings/models/models.dart';

extension UserMapper on UserObject {
  User toFeature() {
    return User(
      firstName: firstName ?? 'No',
      lastName: lastName ?? 'Name',
      email: email,
    );
  }
}
