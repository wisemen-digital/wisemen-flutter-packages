import 'package:flutter/widgets.dart';

/// [ZitadelLoginType] represents a login type for buttons on the login screen
final class ZitadelLoginType {
  /// Constructor for [ZitadelLoginType]
  const ZitadelLoginType({
    required this.buttonText,
    required this.idp,
    this.icon,
  });

  /// The text displayed in the button
  final String buttonText;

  /// The optional icon displayed in the button, sized to 24x24
  /// Usually Google, Apple, Microsoft, etc.'s logo
  final Widget? icon;

  /// The IDP used for the login
  ///
  /// An empty idp logs in through Zitadel itself instead of an external
  /// identity provider.
  final String idp;
}
