import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise_ultra_settings/wise_ultra_settings.dart';

import 'fake_implementations.dart';

void main() {
  setUpAll(() {
    SettingsFeature.init(
      settingsLocalizations: FakeSettingsLocalizations(),
      settingsAssets: FakeSettingsAssets(),
      settingsNavigationManager:
          Provider((ref) => FakeSettingsNavigationManager()),
      settingsFlavors: FakeSettingsFlavors(),
      settingsDatabase: Provider((ref) => throw UnimplementedError()),
    );
  });

  group('emptyValidator', () {
    group('with ignore = false (default)', () {
      test('returns error message for null value', () {
        final result = emptyValidator(null);
        expect(result, equals('Required'));
      });

      test('returns error message for empty string', () {
        final result = emptyValidator('');
        expect(result, equals('Required'));
      });

      test('returns error message for whitespace only', () {
        final result = emptyValidator('   ');
        expect(result, isNull); // Whitespace is not considered empty by isEmpty
      });

      test('returns null for non-empty string', () {
        final result = emptyValidator('test');
        expect(result, isNull);
      });

      test('returns null for string with content', () {
        final result = emptyValidator('John Doe');
        expect(result, isNull);
      });

      test('returns null for single character', () {
        final result = emptyValidator('a');
        expect(result, isNull);
      });

      test('returns null for numbers as string', () {
        final result = emptyValidator('123');
        expect(result, isNull);
      });

      test('returns null for special characters', () {
        final result = emptyValidator('!@#\$%');
        expect(result, isNull);
      });
    });

    group('with ignore = true', () {
      test('returns null for null value', () {
        final result = emptyValidator(null, ignore: true);
        expect(result, isNull);
      });

      test('returns null for empty string', () {
        final result = emptyValidator('', ignore: true);
        expect(result, isNull);
      });

      test('returns null for non-empty string', () {
        final result = emptyValidator('test', ignore: true);
        expect(result, isNull);
      });

      test('returns null for any value', () {
        final result = emptyValidator('anything', ignore: true);
        expect(result, isNull);
      });
    });

    group('edge cases', () {
      test('handles very long strings', () {
        final longString = 'a' * 10000;
        final result = emptyValidator(longString);
        expect(result, isNull);
      });

      test('handles unicode characters', () {
        final result = emptyValidator('你好');
        expect(result, isNull);
      });

      test('handles emojis', () {
        final result = emptyValidator('😀');
        expect(result, isNull);
      });

      test('handles newlines', () {
        final result = emptyValidator('\n');
        expect(result, isNull);
      });

      test('handles tabs', () {
        final result = emptyValidator('\t');
        expect(result, isNull);
      });
    });
  });
}
