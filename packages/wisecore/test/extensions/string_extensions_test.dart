import 'package:flutter_test/flutter_test.dart';
import 'package:wisecore/src/extensions/extensions.dart';

void main() {
  group('StringExtensions', () {
    test('correctEllipsis should add zero-width spaces', () {
      const original = 'test';
      const expected = 't\u200Be\u200Bs\u200Bt';
      expect(original.correctEllipsis, expected);
    });

    test('capitalized should capitalize the first letter', () {
      const original = 'hello';
      const expected = 'Hello';
      expect(original.capitalized, expected);
    });

    test(r'enableSlashN should replace \n with newlines', () {
      const original = r'Line1\nLine2';
      const expected = 'Line1\nLine2';
      expect(original.enableSlashN, expected);
    });
  });

  group('NullableStringExtension', () {
    test('orNull should return the string if it is not null or empty', () {
      const nonEmptyString = 'Hello';
      expect(nonEmptyString.orNull, 'Hello');

      const emptyString = '';
      expect(emptyString.orNull, null);

      const String? nullString = null;
      expect(nullString.orNull, null);
    });

    test('isNullOrEmpty should return true if the string is null or empty', () {
      const nonEmptyString = 'Hello';
      expect(nonEmptyString.isNullOrEmpty, false);

      const emptyString = '';
      expect(emptyString.isNullOrEmpty, true);

      const String? nullString = null;
      expect(nullString.isNullOrEmpty, true);
    });
  });
}
