import 'package:wiseclient/wiseclient.dart';

import '../login.dart';

abstract interface class LoginRepository {
  List<LoginMethod> getSupportedLoginMethods();
  Future<void> login(LoginMethod method);
  Future<void> logout();
  Future<OAuth2Token> refresh(OAuth2Token? token);
}
