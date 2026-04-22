import 'package:flutter/painting.dart';
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

    test('changeOpacity should change the opacity of a Color', () {
      const color = Color(0xffffffff);
      //* Color.a returns double between 0 and 1
      expect(color.changeOpacity(0).a, equals(0));
      expect(color.changeOpacity(1).a, equals(1));
      expect(color.changeOpacity(0.5).a, closeTo(.5, 0.01));
    });

    test('darken should darken the color toward black', () {
      const color = Color(0xff808080);
      final darkened = color.darken(amount: 0.5);
      final original = HSLColor.fromColor(color);
      final darkenedHsl = HSLColor.fromColor(darkened);

      expect(darkenedHsl.lightness, closeTo(original.lightness * 0.5, 0.001));
    });

    test('darken with amount 0 should not change the color', () {
      const color = Color(0xff808080);
      final darkened = color.darken(amount: 0);
      expect(darkened, equals(color));
    });

    test('darken with amount 1 should produce black', () {
      const color = Color(0xff808080);
      final darkened = color.darken(amount: 1);
      expect(HSLColor.fromColor(darkened).lightness, closeTo(0.0, 0.001));
    });

    test('lighten should lighten the color toward white', () {
      const color = Color(0xff808080);
      final lightened = color.lighten(amount: 0.5);
      final original = HSLColor.fromColor(color);
      final lightenedHsl = HSLColor.fromColor(lightened);

      expect(
        lightenedHsl.lightness,
        closeTo(original.lightness + (1 - original.lightness) * 0.5, 0.003),
      );
    });

    test('lighten with amount 0 should not change the color', () {
      const color = Color(0xff808080);
      final lightened = color.lighten(amount: 0);
      expect(lightened, equals(color));
    });

    test('lighten with amount 1 should produce white', () {
      const color = Color(0xff808080);
      final lightened = color.lighten(amount: 1);
      expect(HSLColor.fromColor(lightened).lightness, closeTo(1.0, 0.001));
    });
  });
}
