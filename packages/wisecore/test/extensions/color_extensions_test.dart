import 'package:flutter_test/flutter_test.dart';
import 'package:wisecore/src/extensions/color_extensions.dart';
import 'dart:ui';

void main() {
  group('ColorExtensions', () {
    test('fromHex should convert hex string to Color', () {
      expect(ColorExtensions.fromHex('#ffffff'), equals(Color(0xffffffff)));
      expect(ColorExtensions.fromHex('ffffff'), equals(Color(0xffffffff)));
      expect(ColorExtensions.fromHex('#000000'), equals(Color(0xff000000)));
      expect(ColorExtensions.fromHex('000000'), equals(Color(0xff000000)));
    });

    test('colorFiltered should return ColorFilter with correct blend mode', () {
      const color = Color(0xff123456);
      final colorFilter = color.colorFiltered(blendMode: BlendMode.srcIn);

      expect(colorFilter, isA<ColorFilter>());
      expect(colorFilter, ColorFilter.mode(color, BlendMode.srcIn));
    });
  });
}
