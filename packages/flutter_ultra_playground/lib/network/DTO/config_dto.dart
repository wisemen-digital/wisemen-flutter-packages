import 'package:json_annotation/json_annotation.dart';
import 'package:wise_ultra_login/wise_ultra_login.dart';

part 'config_dto.g.dart';

@JsonSerializable()
class ConfigDTO {
  final String appName;
  final String baseUrl;
  final String clientId;
  final String organizationID;
  final List<SignInMethodDTO>? signInMethods;
  final String splashImage;
  final String brandColor;
  final String bundleID;
  final String? avatar;

  String? localAvatar;

  ConfigDTO({
    required this.appName,
    required this.baseUrl,
    required this.clientId,
    required this.organizationID,
    this.signInMethods,
    required this.splashImage,
    required this.brandColor,
    required this.bundleID,
    required this.avatar,
  });

  factory ConfigDTO.fromJson(Map<String, dynamic> json) {
    return _$ConfigDTOFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConfigDTOToJson(this);
}

@JsonSerializable()
class SignInMethodDTO {
  final String id;
  final String name;
  final String type;

  SignInMethodDTO({required this.id, required this.name, required this.type});

  factory SignInMethodDTO.fromJson(Map<String, dynamic> json) {
    return _$SignInMethodDTOFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SignInMethodDTOToJson(this);
}

extension SignInMethodDTOMapper on SignInMethodDTO {
  LoginMethod toLoginMethod() {
    late LoginType loginType;

    switch (type) {
      case 'google':
        loginType = LoginType.google;
      case 'apple':
        loginType = LoginType.apple;
      case 'email':
        loginType = LoginType.email;
      default:
        loginType = LoginType.other;
    }
    return LoginMethod(id: id, name: name, type: loginType);
  }
}
