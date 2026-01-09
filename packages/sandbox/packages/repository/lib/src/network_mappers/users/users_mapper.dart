import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:openapi/openapi.dart';

/// Extension to map [ViewRoleDetailResponse] to [Role]
extension ViewRoleDetailResponseMapper on ViewRoleDetailResponse {
  /// Maps the network role response to a database role model
  Role toRole() {
    return Role(uuid: uuid, name: name, isDefault: isDefault, isSystemAdmin: isSystemAdmin);
  }
}

/// Extension to map [ViewMeResponse] to [UserTableCompanion]
extension ViewMeResponseMapper on ViewMeResponse {
  /// Maps the network response to a database companion object
  UserTableCompanion toCompanion() {
    final rolesList = roles.map((role) => role.toRole()).toList();

    return UserTableCompanion(
      uuid: Value(uuid),
      firstName: Value(firstName),
      lastName: Value(lastName),
      email: Value(email),
      roles: Value(rolesList),
    );
  }
}
