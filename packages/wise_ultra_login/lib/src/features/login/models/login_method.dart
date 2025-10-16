import 'package:flutter/material.dart';

import '../login.dart';

class LoginMethod {
  LoginMethod({required this.id, required this.name, required this.type});
  final String id;
  final String name;
  final LoginType type;

  String getTitle(BuildContext context) {
    switch (type) {
      case LoginType.apple:
        return 'Apple';
      case LoginType.google:
        return 'Google';
      case LoginType.email:
        return LoginFeature.localizations.email(context);
      case LoginType.other:
        return name;
    }
  }

  String? getIconAsset() {
    switch (type) {
      case LoginType.apple:
        return LoginFeature.assets.apple;
      case LoginType.google:
        return LoginFeature.assets.google;
      case LoginType.email:
        return LoginFeature.assets.email;
      case LoginType.other:
        return null;
    }
  }
}
