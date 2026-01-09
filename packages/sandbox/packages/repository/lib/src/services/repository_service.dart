import 'dart:ui';

import 'package:database/database.dart';
import 'package:openapi/openapi.dart';
import 'package:wiseclient/wiseclient.dart';

class RepositoryService {
  final Openapi api;
  final Database database;

  RepositoryService({
    required String baseUrl,
    required String clientId,
    required VoidCallback onLogout,
  }) : api = Openapi(
         client: WiseClient(
           options: WiseOptions.base(url: baseUrl),
           wiseInterceptors: [WiseInterceptor.fresh],
           refreshFunction: (token, client) async {
             final response = await client.post(
               '$baseUrl/oauth/v2/token',
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
