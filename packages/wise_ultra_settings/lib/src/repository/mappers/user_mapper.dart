import 'package:drift/drift.dart';
import 'package:wise_ultra_settings/src/database/database.dart';
import 'package:wise_ultra_settings/src/features/settings/settings.dart';
import 'package:wise_ultra_settings/src/network/dto/dto.dart';

extension UserMapper on UserDTO {
  BaseSettingsUserTableCompanion toDbCompanion() {
    return BaseSettingsUserTableCompanion(
      id: Value(uuid),
      firstName: Value(firstName),
      lastName: Value(lastName),
      primaryEmail: Value(email),
      phone: Value(phone),
      mobilePhone: Value(mobilePhone),
      birthDate: Value(birthDate != null ? DateTime.parse(birthDate!) : null),
    );
  }
}

extension BaseUserMapper on BaseSettingsUser {
  User toFeatureModel() {
    return User(
      uuid: id,
      firstName: firstName,
      lastName: lastName,
      profilePictureUrl: '',
      email: primaryEmail ?? '',
      birthDate: birthDate,
    );
  }
}
