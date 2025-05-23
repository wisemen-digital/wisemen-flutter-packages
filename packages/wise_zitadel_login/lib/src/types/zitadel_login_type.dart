import 'package:wise_zitadel_login/src/repository/auth_repository.dart';
import 'package:wiseclient/wiseclient.dart' show OAuthToken;

import '../options.dart';

final class ZitadelLoginType {
  const ZitadelLoginType({
    required this.buttonText,
    required this.iconSvgString,
    required this.idp,
  });

  final String buttonText;
  final String iconSvgString;
  final String idp;

  Future<OAuthToken?> login(WiseZitadelOptions options) {
    return AuthenticationRepository.login(options: options, type: this);
  }
}
