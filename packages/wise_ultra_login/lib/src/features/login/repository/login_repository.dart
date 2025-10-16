import '../login.dart';

abstract interface class LoginRepository {
  List<LoginMethod> getSupportedLoginMethods();
  Future<void> login(LoginMethod method);
  Future<void> logout();
}
