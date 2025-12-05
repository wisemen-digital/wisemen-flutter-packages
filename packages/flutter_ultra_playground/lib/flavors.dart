import 'dart:convert';

import 'package:flutter_ultra_playground/network/DTO/config_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wise_ultra_login/wise_ultra_login.dart';
import 'package:wise_ultra_settings/wise_ultra_settings.dart';

enum Flavor { DEVELOPMENT, STAGING, QA, PRODUCTION }

class F implements LoginFlavors, SettingsFlavors {
  static String identifier = '';
  static ConfigDTO? config;

  static Flavor? appFlavor;

  static String get appName {
    if (config != null) {
      return config!.appName;
    }

    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
        return 'Flutter Ultra Development';
      case Flavor.STAGING:
        return 'Flutter Ultra Staging';
      case Flavor.QA:
        return 'Flutter Ultra QA';
      case Flavor.PRODUCTION:
        return 'Flutter Ultra';
      default:
        return 'Flutter Ultra';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
      case Flavor.STAGING:
      case Flavor.QA:
      case Flavor.PRODUCTION:
      case null:
        return 'https://wise-crm.development.appwi.se';
    }
  }

  static String get clientId {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
      case Flavor.STAGING:
      case Flavor.QA:
      case Flavor.PRODUCTION:
      case null:
        return 'null';
    }
  }

  static String get clientSecret {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
      case Flavor.STAGING:
      case Flavor.QA:
      case Flavor.PRODUCTION:
      case null:
        return 'null';
    }
  }

  static String? get onesignalKey {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
      case Flavor.STAGING:
      case Flavor.QA:
      case Flavor.PRODUCTION:
      case null:
        return null;
    }
  }

  static String? get sentryDsn {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
      case Flavor.STAGING:
      case Flavor.QA:
      case Flavor.PRODUCTION:
      case null:
        return null;
    }
  }

  static String? get bannerName {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
        return 'DEV';
      case Flavor.STAGING:
        return 'STAGING';
      case Flavor.QA:
        return 'QA';
      case Flavor.PRODUCTION:
        return null;
      default:
        return null;
    }
  }

  static String get name => appFlavor?.name ?? '';

  @override
  String get authenticationUrl => config?.baseUrl ?? '';

  @override
  String get bundleId => config?.bundleID ?? '';

  @override
  String get clientID => config?.clientId ?? '';

  @override
  List<LoginMethod> get loginMethods => config?.signInMethods?.map((m) => m.toLoginMethod()).toList() ?? [];

  @override
  String get organizationID => config?.organizationID ?? '';

  @override
  String get splashImage => config?.splashImage ?? '';

  @override
  String get privacyPolicyUrl => 'https://example.com';

  @override
  String get termsAndConditionsUrl => 'https://example.com';

  static String get storeUrl => 'https://example.com';
}

extension FlavorMapper on F {
  LoginType toLoginType(String type) {
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

    return loginType;
  }
}

extension PersistantFlavors on F {
  static const String _configKey = 'app_config';
  static const String _identifierKey = 'app_identifier';

  /// Load persisted config from SharedPreferences
  static Future<void> loadPersistedConfig() async {
    final prefs = await SharedPreferences.getInstance();

    final configJson = prefs.getString(_configKey);
    if (configJson != null) {
      final configMap = jsonDecode(configJson) as Map<String, dynamic>;
      F.config = ConfigDTO.fromJson(configMap);
    }

    final persistedIdentifier = prefs.getString(_identifierKey);
    if (persistedIdentifier != null) {
      F.identifier = persistedIdentifier;
    }
  }

  /// Save current config to SharedPreferences
  static Future<void> saveConfig() async {
    final prefs = await SharedPreferences.getInstance();

    if (F.config != null) {
      final configJson = jsonEncode(F.config!.toJson());
      await prefs.setString(_configKey, configJson);
    }

    if (F.identifier.isNotEmpty) {
      await prefs.setString(_identifierKey, F.identifier);
    }
  }

  /// Clear persisted config from SharedPreferences
  static Future<void> clearPersistedConfig() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_configKey);
    await prefs.remove(_identifierKey);
  }
}
