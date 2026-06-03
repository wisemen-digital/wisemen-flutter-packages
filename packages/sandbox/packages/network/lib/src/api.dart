import 'package:dio/dio.dart';
import 'package:wiseclient/wiseclient.dart';
import 'package:openapi/openapi.dart';

import 'services/services.dart';

abstract class SandboxApi {
  Stream<AuthenticationStatus> get authenticationStatus;
  Future<void> setToken(OAuthToken token);
  Future<void> clearToken();
  //* Services
  UserService get userService;
}

class NetworkApi implements SandboxApi {
  static const String basePath = r'http://localhost:8080';

  final WiseClient client;
  final Openapi api;

  NetworkApi({required WiseClient client, List<Interceptor>? interceptors})
    : this.client = client,
      this.api = Openapi(dio: client, interceptors: interceptors ?? []) {}

  //* Services
  @override
  UserService get userService => UserServiceImpl(api);

  @override
  Stream<AuthenticationStatus> get authenticationStatus =>
      client.authenticationStatus;

  @override
  Future<void> clearToken() async {
    await client.fresh.clearToken();
  }

  @override
  Future<void> setToken(OAuthToken token) async {
    await client.fresh.setToken(token);
  }
}
