import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wise_zitadel_login/src/repository/auth_repository.dart';
import 'package:wise_zitadel_login/wise_zitadel_login.dart';
import 'package:wiseclient/wiseclient.dart' show OAuthToken;

import '../utils/fake_ref.dart';
import '../utils/mock_auth.dart';

class MockAuthRepository extends Mock implements AuthenticationRepository {}

void main() {
  setUp(mockPlatformAlerts);

  group('ZitadelLoginType', () {
    const buttonText = 'Sign in with Google';
    const iconSvgString = '<svg></svg>';
    const idp = 'google';
    const type = ZitadelLoginType(
      buttonText: buttonText,
      iconSvgString: iconSvgString,
      idp: idp,
    );

    test('should create instance with correct values', () {
      expect(type.buttonText, buttonText);
      expect(type.iconSvgString, iconSvgString);
      expect(type.idp, idp);
    });

    test(
      'login should call AuthenticationRepository.login with correct params',
      () async {
        final token = await type.login(
          FakeRef().read(wiseZitadelOptionsProvider),
        );
        expect(token, isA<OAuthToken>());
      },
    );
  });
}
