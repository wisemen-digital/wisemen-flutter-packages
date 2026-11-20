import 'package:wiseclient/wiseclient.dart';

import '../api.dart';
import '../services/services.dart';
import 'services/services.dart';

class MockApi extends SandboxApi {
  @override
  UserService get userService => MockUserService();

  @override
  Stream<AuthenticationStatus> get authenticationStatus =>
      Stream.value(AuthenticationStatus.authenticated);

  @override
  Future<void> clearToken() {
    return Future.value();
  }

  @override
  Future<void> setToken(OAuth2Token token) {
    return Future.value();
  }
}
