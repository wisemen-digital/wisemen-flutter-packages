import 'package:fresh/src/fresh.dart';
import 'package:openapi/src/services/services.dart';
import 'package:wiseclient/src/token_model/oauth_token.dart';

import '../api.dart';
import 'services/services.dart';

class MockApi extends SandboxApi {
  @override
  UserService get userService => MockUserService();

  @override
  Stream<AuthenticationStatus> get authenticationStatus => Stream.value(AuthenticationStatus.authenticated);

  @override
  Future<void> clearToken() {
    return Future.value();
  }

  @override
  Future<void> setToken(OAuthToken token) {
    return Future.value();
  }
}
