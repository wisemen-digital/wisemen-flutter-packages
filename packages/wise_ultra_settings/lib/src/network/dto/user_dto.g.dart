// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => UserDTO(
      uuid: json['uuid'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      mobilePhone: json['mobilePhone'] as String?,
      birthDate: json['birthDate'] as String?,
    );

Map<String, dynamic> _$UserDTOToJson(UserDTO instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'mobilePhone': instance.mobilePhone,
      'birthDate': instance.birthDate,
    };
