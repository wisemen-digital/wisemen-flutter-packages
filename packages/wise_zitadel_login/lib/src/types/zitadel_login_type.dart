import 'package:wise_zitadel_login/src/repository/auth_repository.dart';
import 'package:wiseclient/wiseclient.dart' show OAuthToken;

import '../options.dart';

/// [ZitadelLoginType] represents a login type for buttons on the login screen
final class ZitadelLoginType {
  /// Constructor for [ZitadelLoginType]
  const ZitadelLoginType({
    required this.buttonText,
    required this.iconSvgString,
    required this.idp,
  });

  /// The text displayed in the button
  final String buttonText;

  /// The SVG string used for the button icon
  /// Usually Google, Apple, Microsoft, etc.'s logo
  final String iconSvgString;

  /// The IDP used for the login
  final String idp;

  /// Login function called by the button
  Future<OAuthToken?> login(WiseZitadelOptions options) {
    return AuthenticationRepository.login(options: options, type: this);
  }
}
