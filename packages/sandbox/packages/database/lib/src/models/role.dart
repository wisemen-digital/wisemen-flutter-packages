import 'dart:convert';

import 'package:drift/drift.dart';

/// Database model for a user role
class Role {
  const Role({required this.uuid, required this.name, required this.isDefault, required this.isSystemAdmin});

  final String uuid;
  final String name;
  final bool isDefault;
  final bool isSystemAdmin;

  Map<String, dynamic> toJson() {
    return {'uuid': uuid, 'name': name, 'isDefault': isDefault, 'isSystemAdmin': isSystemAdmin};
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
