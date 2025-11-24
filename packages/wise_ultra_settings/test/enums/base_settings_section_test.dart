import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_ultra_settings/wise_ultra_settings.dart';

import '../utils/fake_implementations.dart';

void main() {
  setUpAll(() {
    SettingsFeature.init(
      settingsLocalizations: FakeSettingsLocalizations(),
      settingsAssets: FakeSettingsAssets(),
      settingsNavigationManager: Provider((ref) => MockSettingsNavigationManager()),
      settingsFlavors: FakeSettingsFlavors(),
      settingsDatabase: Provider((ref) => throw UnimplementedError()),
    );
  });

  group('BaseSettingsSection', () {
    group('enum values', () {
      test('has all expected values', () {
        expect(BaseSettingsSection.values, hasLength(3));
        expect(BaseSettingsSection.values, contains(BaseSettingsSection.profileManagement));
        expect(BaseSettingsSection.values, contains(BaseSettingsSection.appInfo));
        expect(BaseSettingsSection.values, contains(BaseSettingsSection.logout));
      });

      test('enum values can be compared', () {
        expect(BaseSettingsSection.profileManagement, equals(BaseSettingsSection.profileManagement));
        expect(BaseSettingsSection.profileManagement, isNot(equals(BaseSettingsSection.appInfo)));
      });

      test('enum values can be used in switch statements', () {
        String result;
        switch (BaseSettingsSection.profileManagement) {
          case BaseSettingsSection.profileManagement:
            result = 'profile';
          case BaseSettingsSection.appInfo:
            result = 'info';
          case BaseSettingsSection.logout:
            result = 'logout';
        }
        expect(result, equals('profile'));
      });
    });

    group('getItems', () {
      test('profileManagement returns correct items', () {
        final items = BaseSettingsSection.profileManagement.getItems();
        
        expect(items, hasLength(4));
        expect(items[0], equals(BaseSettingsItem.personalInfo));
        expect(items[1], equals(BaseSettingsItem.notificationSettings));
        expect(items[2], equals(BaseSettingsItem.appTheme));
        expect(items[3], equals(BaseSettingsItem.appLanguage));
      });

      test('appInfo returns correct items', () {
        final items = BaseSettingsSection.appInfo.getItems();
        
        expect(items, hasLength(3));
        expect(items[0], equals(BaseSettingsItem.appVersion));
        expect(items[1], equals(BaseSettingsItem.termsAndConditions));
        expect(items[2], equals(BaseSettingsItem.privacyPolicy));
      });

      test('logout returns correct items', () {
        final items = BaseSettingsSection.logout.getItems();
        
        expect(items, hasLength(1));
        expect(items[0], equals(BaseSettingsItem.logout));
      });

      test('all items are SettingsItem instances', () {
        for (final section in BaseSettingsSection.values) {
          final items = section.getItems();
          for (final item in items) {
            expect(item, isA<SettingsItem>());
          }
        }
      });

      test('items lists are not empty', () {
        for (final section in BaseSettingsSection.values) {
          final items = section.getItems();
          expect(items, isNotEmpty);
        }
      });
    });

    group('getTitle', () {
      testWidgets('returns correct title for profileManagement', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final title = BaseSettingsSection.profileManagement.getTitle(context);
                expect(title, equals('Profile Management'));
                return Container();
              },
            ),
          ),
        );
      });

      testWidgets('returns correct title for appInfo', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final title = BaseSettingsSection.appInfo.getTitle(context);
                expect(title, equals('App Info'));
                return Container();
              },
            ),
          ),
        );
      });

      testWidgets('returns empty string for logout', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final title = BaseSettingsSection.logout.getTitle(context);
                expect(title, equals(''));
                return Container();
              },
            ),
          ),
        );
      });

      testWidgets('all sections return non-null titles', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                for (final section in BaseSettingsSection.values) {
                  final title = section.getTitle(context);
                  expect(title, isNotNull);
                  expect(title, isA<String>());
                }
                return Container();
              },
            ),
          ),
        );
      });
    });

    group('implements SettingsSection', () {
      test('all sections implement SettingsSection interface', () {
        for (final section in BaseSettingsSection.values) {
          expect(section, isA<SettingsSection>());
        }
      });
    });

    group('section structure', () {
      test('profileManagement has multiple items', () {
        final items = BaseSettingsSection.profileManagement.getItems();
        expect(items.length, greaterThan(1));
      });

      test('appInfo has multiple items', () {
        final items = BaseSettingsSection.appInfo.getItems();
        expect(items.length, greaterThan(1));
      });

      test('logout has single item', () {
        final items = BaseSettingsSection.logout.getItems();
        expect(items, hasLength(1));
      });

      test('no duplicate items within sections', () {
        for (final section in BaseSettingsSection.values) {
          final items = section.getItems();
          final uniqueItems = items.toSet();
          expect(items.length, equals(uniqueItems.length));
        }
      });
    });

    group('edge cases', () {
      test('sections maintain order', () {
        final items1 = BaseSettingsSection.profileManagement.getItems();
        final items2 = BaseSettingsSection.profileManagement.getItems();
        
        for (int i = 0; i < items1.length; i++) {
          expect(items1[i], equals(items2[i]));
        }
      });

      test('items are immutable', () {
        final items = BaseSettingsSection.profileManagement.getItems();
        final itemsCopy = List.from(items);
        
        expect(items, equals(itemsCopy));
      });
    });
  });
}
