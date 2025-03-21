import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:wisecore/src/extensions/color_extensions.dart';

void main() {
  group('ColorExtensions', () {
    test('fromHex should convert hex string to Color', () {
      expect(
        ColorExtensions.fromHex('#ffffff'),
        equals(const Color(0xffffffff)),
      );
      expect(
        ColorExtensions.fromHex('ffffff'),
        equals(const Color(0xffffffff)),
      );
      expect(
        ColorExtensions.fromHex('#000000'),
        equals(const Color(0xff000000)),
      );
      expect(
        ColorExtensions.fromHex('000000'),
        equals(const Color(0xff000000)),
      );
    });

    test('colorFiltered should return ColorFilter with correct blend mode', () {
      const color = Color(0xff123456);
      final colorFilter = color.colorFiltered();

      expect(colorFilter, isA<ColorFilter>());
      expect(colorFilter, const ColorFilter.mode(color, BlendMode.srcIn));
    });
  });
}
