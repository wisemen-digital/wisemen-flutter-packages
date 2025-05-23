import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_zitadel_login/src/repository/auth_repository.dart';
import 'package:wise_zitadel_login/wise_zitadel_login.dart';
import 'package:wiseclient/wiseclient.dart';

import '../utils/mock_auth.dart';

void main() {
  setUp(mockPlatformAlerts);

  test('AuthRepository static login call returns OAuthToken', () async {
    const type = ZitadelLoginType(
      idp: 'idp_id',
      buttonText: 'Login',
      iconSvgString: '',
    );
    final options = WiseZitadelOptions(
      baseUrl: 'https://example.com',
      bundleId: 'com.example.app',
      applicationId: 'app_id',
      organizationId: 'org_id',
      supportedTypes: [type],
      onLoginSuccess: (router, ref, token) {},
      buttonOptions: WiseZitadelButtonOptions(
        color: (_) => Colors.blue,
        buttonTextStyle: (_) => const TextStyle(),
      ),
    );

    final result = await AuthenticationRepository.login(
      options: options,
      type: type,
    );

    expect(result, isA<OAuthToken>());
  });
}
