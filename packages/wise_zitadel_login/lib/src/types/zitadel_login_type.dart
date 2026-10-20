import 'package:flutter/material.dart';
import 'package:wise_zitadel_login/src/repository/auth_repository.dart';
import 'package:wiseclient/wiseclient.dart' show OAuthToken;

import '../options.dart';

/// [ZitadelLoginType] represents a login type for buttons on the login screen
final class ZitadelLoginType {
  /// Constructor for [ZitadelLoginType]
  const ZitadelLoginType({
    required this.buttonText,
    required this.idp,
    this.icon = const Icon(Icons.login),
  });

  /// The text displayed in the button
  final String buttonText;

  /// The icon displayed in the button, sized to 24x24
  /// Defaults to a Material login icon
  /// Override with e.g. Google, Apple, Microsoft, etc.'s logo
  final Widget icon;

  /// The IDP used for the login
  ///
  /// An empty idp logs in through Zitadel itself instead of an external
  /// identity provider.
  final String idp;
}
