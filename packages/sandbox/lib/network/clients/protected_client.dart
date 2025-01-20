import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sandbox/features/shared/shared.dart';
import 'package:sandbox/flavors.dart';
import 'package:wiseclient/wiseclient.dart';

import 'fake_client.dart';
import 'unprotected_client.dart';

part 'protected_client.g.dart';

@Riverpod(keepAlive: true)
class ProtectedClient extends _$ProtectedClient {
  @override
  WiseClient build() {
    if (AppConstants.fakerMode) {
      return FakerWiseClient(wiseInterceptors: []);
    }
    return WiseClient(
      refreshFunction: (token, dio) async {
        try {
          final response = await ref.read(unprotectedClientProvider).wPost(
            'oauth/token',
            body: {
              'client_id': F.clientId,
              'client_secret': F.clientSecret,
              'grant_type': 'refresh_token',
              'refresh_token': token?.refreshToken,
            },
            extraHeaders: {
              'content-type': 'application/x-www-form-urlencoded',
            },
          );

          return OAuthToken.fromSnakeCase(response);
        } on DioException catch (e) {
          if ([
            401,
          ].any(
            (element) => element == e.response?.statusCode,
          )) {
            throw RevokeTokenException();
          } else {
            rethrow;
          }
        }
      },
      options: WiseOptions.base(
        url: F.baseUrl,
      ),
      wiseInterceptors: [
        WiseInterceptor.fresh,
      ],
      useNativeAdapter: PlatformUtils.isIos,
    );
  }
}
