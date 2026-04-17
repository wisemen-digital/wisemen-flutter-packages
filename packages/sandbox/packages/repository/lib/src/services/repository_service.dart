import 'dart:ui';

import 'package:database/database.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';
import 'package:openapi/openapi.dart';
import 'package:wiseclient/wiseclient.dart';

class RepositoryService {
  final Openapi api;
  final Database database;

  RepositoryService({
    required String baseUrl,
    required String authUrl,
    required String clientId,
    required VoidCallback onLogout,
  }) : api = Openapi(
         client: WiseClient(
           options: WiseOptions.base(url: baseUrl),
           useNativeAdapter: true,
           wiseInterceptors: [WiseInterceptor.fresh],
           refreshFunction: (token, client) async {
             final response = await (client..httpClientAdapter = NativeAdapter()).post(
               authUrl,
               data: {
                 'client_id': clientId,
                 'grant_type': 'refresh_token',
                 'refresh_token': token?.refreshToken,
               },
               options: Options(
                 contentType: 'application/x-www-form-urlencoded',
               ),
             );

             return OAuthToken.fromSnakeCase(response.data);
           },
           refreshErrorHandler: (e, stackTrace) async {
             if (e is DioException && [401].contains(e.response?.statusCode)) {
               onLogout();
             } else {
               // Don't log out
             }
           },
         ),
       ),
       database = constructDb();

  Stream<AuthenticationStatus> get authenticationStatus => api.client.authenticationStatus;

  Future<void> setToken(OAuthToken token) async {
    await api.client.fresh.setToken(token);
  }

  Future<void> clearToken() async {
    await api.client.fresh.clearToken();
  }
}
