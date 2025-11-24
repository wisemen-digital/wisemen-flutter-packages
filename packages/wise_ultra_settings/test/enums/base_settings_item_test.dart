import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise_ultra_settings/wise_ultra_settings.dart';

import '../utils/fake_implementations.dart';

void main() {
  setUpAll(() {
    SettingsFeature.init(
      settingsLocalizations: FakeSettingsLocalizations(),
      settingsAssets: FakeSettingsAssets(),
      settingsNavigationManager: Provider((ref) => FakeSettingsNavigationManager()),
      settingsFlavors: FakeSettingsFlavors(),
      settingsDatabase: Provider((ref) => throw UnimplementedError()),
    );
  });

  group('BaseSettingsItem', () {
    group('enum values', () {
      test('has all expected values', () {
        expect(BaseSettingsItem.values, hasLength(8));
        expect(BaseSettingsItem.values, contains(BaseSettingsItem.personalInfo));
        expect(BaseSettingsItem.values, contains(BaseSettingsItem.notificationSettings));
        expect(BaseSettingsItem.values, contains(BaseSettingsItem.appTheme));
        expect(BaseSettingsItem.values, contains(BaseSettingsItem.appVersion));
        expect(BaseSettingsItem.values, contains(BaseSettingsItem.privacyPolicy));
        expect(BaseSettingsItem.values, contains(BaseSettingsItem.termsAndConditions));
        expect(BaseSettingsItem.values, contains(BaseSettingsItem.logout));
        expect(BaseSettingsItem.values, contains(BaseSettingsItem.appLanguage));
      });

      test('enum values can be compared', () {
        expect(BaseSettingsItem.personalInfo, equals(BaseSettingsItem.personalInfo));
        expect(BaseSettingsItem.personalInfo, isNot(equals(BaseSettingsItem.appTheme)));
      });
    });

    group('getTitle', () {
      testWidgets('returns correct titles for all items', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                expect(BaseSettingsItem.personalInfo.getTitle(context), equals('Personal Info'));
                expect(BaseSettingsItem.notificationSettings.getTitle(context), equals('Notification Settings'));
                expect(BaseSettingsItem.appTheme.getTitle(context), equals('App Theme'));
                expect(BaseSettingsItem.appVersion.getTitle(context), equals('App Version'));
                expect(BaseSettingsItem.privacyPolicy.getTitle(context), equals('Privacy Policy'));
                expect(BaseSettingsItem.termsAndConditions.getTitle(context), equals('Terms and Conditions'));
                expect(BaseSettingsItem.appLanguage.getTitle(context), equals('App Language'));
                expect(BaseSettingsItem.logout.getTitle(context), equals('Logout'));
                return Container();
              },
            ),
          ),
        );
      });
    });

    group('implements SettingsItem', () {
      test('all items implement SettingsItem interface', () {
        for (final item in BaseSettingsItem.values) {
          expect(item, isA<SettingsItem>());
        }
      });
    });
  });
}
