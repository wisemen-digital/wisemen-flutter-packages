import 'package:flutter_test/flutter_test.dart';
import 'package:wise_zitadel_login/wise_zitadel_login.dart';

void main() {
  group('ZitadelLoginType', () {
    test('should create instance with correct values', () {
      const type = ZitadelLoginType(
        buttonText: 'Sign in with Google',
        iconSvgString: '<svg></svg>',
        idp: 'google',
      );

      expect(type.buttonText, 'Sign in with Google');
      expect(type.iconSvgString, '<svg></svg>');
      expect(type.idp, 'google');
    });
  });
}
