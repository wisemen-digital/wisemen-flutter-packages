import 'package:flutter_test/flutter_test.dart';
import 'package:wise_ultra_login/wise_ultra_login.dart';

void main() {
  group('LoginType', () {
    test('has correct enum values', () {
      expect(LoginType.values.length, 4);
      expect(LoginType.values, contains(LoginType.apple));
      expect(LoginType.values, contains(LoginType.google));
      expect(LoginType.values, contains(LoginType.email));
      expect(LoginType.values, contains(LoginType.other));
    });

    test('enum values can be compared', () {
      expect(LoginType.apple, LoginType.apple);
      expect(LoginType.google, LoginType.google);
      expect(LoginType.email, LoginType.email);
      expect(LoginType.other, LoginType.other);

      expect(LoginType.apple, isNot(LoginType.google));
      expect(LoginType.google, isNot(LoginType.email));
      expect(LoginType.email, isNot(LoginType.other));
    });

    test('enum values can be used in switch statements', () {
      String getDescription(LoginType type) {
        switch (type) {
          case LoginType.apple:
            return 'Apple login';
          case LoginType.google:
            return 'Google login';
          case LoginType.email:
            return 'Email login';
          case LoginType.other:
            return 'Other login';
        }
      }

      expect(getDescription(LoginType.apple), 'Apple login');
      expect(getDescription(LoginType.google), 'Google login');
      expect(getDescription(LoginType.email), 'Email login');
      expect(getDescription(LoginType.other), 'Other login');
    });
  });
}
