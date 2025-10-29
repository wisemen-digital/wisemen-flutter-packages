import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO {
  const UserDTO({
    required this.uuid,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phone,
    this.mobilePhone,
    this.birthDate,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return _$UserDTOFromJson(json);
  }

  final String uuid;
  final String firstName;
  final String lastName;
  final String? email;
  final String? phone;
  final String? mobilePhone;
  final String? birthDate;

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
}
