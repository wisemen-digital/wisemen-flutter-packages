import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_zitadel_login/wise_zitadel_login.dart';

void main() {
  group('ZitadelLoginType', () {
    test('should create instance with correct values', () {
      const icon = Icon(Icons.g_mobiledata);
      const type = ZitadelLoginType(
        buttonText: 'Sign in with Google',
        idp: 'google',
        icon: icon,
      );

      expect(type.buttonText, 'Sign in with Google');
      expect(type.icon, same(icon));
      expect(type.idp, 'google');
    });

    test('defaults the icon to a login icon', () {
      const type = ZitadelLoginType(buttonText: 'Internal', idp: '');

      expect(type.icon, isA<Icon>());
      expect((type.icon as Icon).icon, Icons.login);
    });
  });
}
