# Network to database layer mapper instructions

In this folder we map code-generated openapi models to drift table companions.

# Steps

1. Find the folder or file that fits the use case.
    * File names should be '{table_name}_mapper.dart'
    * Folder names should be {table_name}

2. Create an extension on the openapi model with a function that returns the given table companion.
    * The companion can be found in 'file_name.drift.dart'
    * Make logical connections that match column names
    * For nested objects/collections, create a database model in the database layer:
        - Create the model in the database package's `lib/src/models/` folder
        - File name should match the model name (e.g., 'role.dart' for Role model)
        - The model should include:
          - A simple class with required fields
          - `toJson()` method for serialization
          - `fromJson()` factory for deserialization
          - A TypeConverter class in the same file for drift integration
        - Add the new file to the models barrel file (`lib/src/models/models.dart`)
        - Update the database barrel file (`lib/database.dart`) if needed
    * In the mapper, create an extension to convert the openapi nested model to the database model
    * Import necessary packages and files

3. Document the functions and extensions (dart docs: ///) for implementations that weren't clear and obvious.

4. Add newly created files/folders to existing barrel files

# Example: Database Model with Converter

File: `packages/database/lib/src/models/role.dart`

```dart
import 'dart:convert';
import 'package:drift/drift.dart';

/// Database model for a user role
class Role {
  const Role({
    required this.uuid,
    required this.name,
    required this.isDefault,
    required this.isSystemAdmin,
  });

  final String uuid;
  final String name;
  final bool isDefault;
  final bool isSystemAdmin;

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'isDefault': isDefault,
      'isSystemAdmin': isSystemAdmin,
    };
  }

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      isDefault: json['isDefault'] as bool,
      isSystemAdmin: json['isSystemAdmin'] as bool,
    );
  }
}

/// TypeConverter for storing a list of roles as JSON in the database
/// Use TypeConverter for non-nullable types
class RolesListConverter extends TypeConverter<List<Role>, String> {
  @override
  List<Role> fromSql(String fromDb) {
    final List<dynamic> rolesJson = json.decode(fromDb);
    return rolesJson.map((roleMap) => Role.fromJson(roleMap)).toList();
  }

  @override
  String toSql(List<Role> value) {
    return json.encode(value.map((role) => role.toJson()).toList());
  }
}

/// For nullable types, use NullAwareTypeConverter
class NullableRoleConverter extends NullAwareTypeConverter<Role, String> {
  @override
  Role requireFromSql(String fromDb) {
    Map<String, dynamic> map = json.decode(fromDb);
    return Role.fromJson(map);
  }

  @override
  String requireToSql(Role value) {
    return json.encode(value.toJson());
  }
}
```

# Example: Mapper

File: `packages/repository/lib/src/network_mappers/users/users_mapper.dart`

```dart
import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:openapi/openapi.dart';

/// Extension to map [ViewRoleDetailResponse] to [Role]
extension ViewRoleDetailResponseMapper on ViewRoleDetailResponse {
  /// Maps the network role response to a database role model
  Role toRole() {
    return Role(
      uuid: uuid,
      name: name,
      isDefault: isDefault,
      isSystemAdmin: isSystemAdmin,
    );
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
```
