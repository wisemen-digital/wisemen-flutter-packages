import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_ultra_login/wise_ultra_login.dart';

import '../utils/fake_ref.dart';

void main() {
  setUpAll(() {
    LoginFeature.init(
      loginFlavors: FakeLoginFlavors(),
      loginLocalizations: FakeLoginLocalizations(),
      loginAssets: FakeLoginAssets(),
      loginRepository: Provider<LoginRepository>((ref) => MockLoginRepository()),
    );
  });

  group('LoginMethod', () {
    test('creates login method with required parameters', () {
      final method = LoginMethod(
        id: 'test_id',
        name: 'Test Method',
        type: LoginType.google,
      );

      expect(method.id, 'test_id');
      expect(method.name, 'Test Method');
      expect(method.type, LoginType.google);
    });

    testWidgets('getTitle returns correct title for Apple',
        (WidgetTester tester) async {
      final method = LoginMethod(
        id: 'apple',
        name: 'Apple',
        type: LoginType.apple,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(method.getTitle(context), 'Apple');
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('getTitle returns correct title for Google',
        (WidgetTester tester) async {
      final method = LoginMethod(
        id: 'google',
        name: 'Google',
        type: LoginType.google,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(method.getTitle(context), 'Google');
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('getTitle returns localized email for Email type',
        (WidgetTester tester) async {
      final method = LoginMethod(
        id: 'email',
        name: 'Email',
        type: LoginType.email,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(method.getTitle(context), 'Email');
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('getTitle returns name for other type',
        (WidgetTester tester) async {
      final method = LoginMethod(
        id: 'custom',
        name: 'Custom SSO',
        type: LoginType.other,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(method.getTitle(context), 'Custom SSO');
              return const SizedBox();
            },
          ),
        ),
      );
    });

    test('getIconAsset returns correct asset for Apple', () {
      final method = LoginMethod(
        id: 'apple',
        name: 'Apple',
        type: LoginType.apple,
      );

      expect(
        method.getIconAsset(),
        'test/fixtures/test_icon.svg',
      );
    });

    test('getIconAsset returns correct asset for Google', () {
      final method = LoginMethod(
        id: 'google',
        name: 'Google',
        type: LoginType.google,
      );

      expect(
        method.getIconAsset(),
        'test/fixtures/test_icon.svg',
      );
    });

    test('getIconAsset returns correct asset for Email', () {
      final method = LoginMethod(
        id: 'email',
        name: 'Email',
        type: LoginType.email,
      );

      expect(
        method.getIconAsset(),
        'test/fixtures/test_icon.svg',
      );
    });

    test('getIconAsset returns null for other type', () {
      final method = LoginMethod(
        id: 'custom',
        name: 'Custom SSO',
        type: LoginType.other,
      );

      expect(method.getIconAsset(), null);
    });
  });
}
