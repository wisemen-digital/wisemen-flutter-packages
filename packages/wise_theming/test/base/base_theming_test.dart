import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_theming/src/base/base.dart';
import 'package:wise_theming/src/theming/theming.dart';

void main() {
  group('PrimitiveColors', () {
    test('should have basic colors defined', () {
      expect(PrimitiveColors.white, isNotNull);
      expect(PrimitiveColors.black, isNotNull);
      expect(PrimitiveColors.transparent, isNotNull);
    });

    test('should have complete gray color swatch', () {
      final expectedShades = [
        25,
        50,
        100,
        200,
        300,
        400,
        500,
        600,
        700,
        800,
        900,
        950
      ];
      for (final shade in expectedShades) {
        expect(PrimitiveColors.gray[shade], isNotNull,
            reason: 'gray[$shade] should not be null');
      }
    });

    test('should have complete grayDark color swatch', () {
      final expectedShades = [
        25,
        50,
        100,
        200,
        300,
        400,
        500,
        600,
        700,
        800,
        900,
        950
      ];
      for (final shade in expectedShades) {
        expect(PrimitiveColors.grayDark[shade], isNotNull,
            reason: 'grayDark[$shade] should not be null');
      }
    });

    test('should have complete brand color swatch', () {
      final expectedShades = [
        25,
        50,
        100,
        200,
        300,
        400,
        500,
        600,
        700,
        800,
        900,
        950
      ];
      for (final shade in expectedShades) {
        expect(PrimitiveColors.brand[shade], isNotNull,
            reason: 'brand[$shade] should not be null');
      }
    });

    test('should have complete error color swatch', () {
      final expectedShades = [
        25,
        50,
        100,
        200,
        300,
        400,
        500,
        600,
        700,
        800,
        900,
        950
      ];
      for (final shade in expectedShades) {
        expect(PrimitiveColors.error[shade], isNotNull,
            reason: 'error[$shade] should not be null');
      }
    });

    test('should have complete warning color swatch', () {
      final expectedShades = [
        25,
        50,
        100,
        200,
        300,
        400,
        500,
        600,
        700,
        800,
        900,
        950
      ];
      for (final shade in expectedShades) {
        expect(PrimitiveColors.warning[shade], isNotNull,
            reason: 'warning[$shade] should not be null');
      }
    });

    test('should have complete success color swatch', () {
      final expectedShades = [
        25,
        50,
        100,
        200,
        300,
        400,
        500,
        600,
        700,
        800,
        900,
        950
      ];
      for (final shade in expectedShades) {
        expect(PrimitiveColors.success[shade], isNotNull,
            reason: 'success[$shade] should not be null');
      }
    });

    test('should have complete yellow color swatch', () {
      final expectedShades = [
        25,
        50,
        100,
        200,
        300,
        400,
        500,
        600,
        700,
        800,
        900,
        950
      ];
      for (final shade in expectedShades) {
        expect(PrimitiveColors.yellow[shade], isNotNull,
            reason: 'yellow[$shade] should not be null');
      }
    });
  });

  group('HexColor extension', () {
    test('should parse 6-character hex strings', () {
      expect(HexColor.fromString('FF0000'), const Color(0xFFFF0000));
      expect(HexColor.fromString('#FF0000'), const Color(0xFFFF0000));
      expect(HexColor.fromString('00FF00'), const Color(0xFF00FF00));
      expect(HexColor.fromString('0000FF'), const Color(0xFF0000FF));
    });

    test('should parse 7-character hex strings with hash', () {
      expect(HexColor.fromString('#FFFFFF'), const Color(0xFFFFFFFF));
      expect(HexColor.fromString('#000000'), const Color(0xFF000000));
      expect(HexColor.fromString('#123456'), const Color(0xFF123456));
    });

    test('should parse 8-character hex strings with alpha', () {
      expect(HexColor.fromString('80FF0000'), const Color(0x80FF0000));
      expect(HexColor.fromString('#80FF0000'), const Color(0x80FF0000));
      expect(HexColor.fromString('FF00FF00'), const Color(0xFF00FF00));
    });

    test('should handle mixed case hex strings', () {
      expect(HexColor.fromString('abcdef'), const Color(0xFFABCDEF));
      expect(HexColor.fromString('ABCDEF'), const Color(0xFFABCDEF));
      expect(HexColor.fromString('#AbCdEf'), const Color(0xFFABCDEF));
    });
  });

  group('TextColors', () {
    test('lightTextColors should have all colors defined', () {
      expect(lightTextColors.primary, isNotNull);
      expect(lightTextColors.primaryOnBrand, isNotNull);
      expect(lightTextColors.secondary, isNotNull);
      expect(lightTextColors.white, isNotNull);
      expect(lightTextColors.brandPrimary, isNotNull);
      expect(lightTextColors.brandSecondary, isNotNull);
      expect(lightTextColors.brandTertiary, isNotNull);
      expect(lightTextColors.errorPrimary, isNotNull);
      expect(lightTextColors.warningPrimary, isNotNull);
      expect(lightTextColors.successPrimary, isNotNull);
    });

    test('darkTextColors should have all colors defined', () {
      expect(darkTextColors.primary, isNotNull);
      expect(darkTextColors.primaryOnBrand, isNotNull);
      expect(darkTextColors.secondary, isNotNull);
      expect(darkTextColors.white, isNotNull);
      expect(darkTextColors.brandPrimary, isNotNull);
      expect(darkTextColors.brandSecondary, isNotNull);
      expect(darkTextColors.brandTertiary, isNotNull);
      expect(darkTextColors.errorPrimary, isNotNull);
      expect(darkTextColors.warningPrimary, isNotNull);
      expect(darkTextColors.successPrimary, isNotNull);
    });

    test('highContrastLightTextColors should have all colors defined', () {
      expect(highContrastLightTextColors.primary, isNotNull);
      expect(highContrastLightTextColors.primaryOnBrand, isNotNull);
      expect(highContrastLightTextColors.brandPrimary, isNotNull);
      expect(highContrastLightTextColors.errorPrimary, isNotNull);
      expect(highContrastLightTextColors.warningPrimary, isNotNull);
      expect(highContrastLightTextColors.successPrimary, isNotNull);
    });

    test('highContrastDarkTextColors should have all colors defined', () {
      expect(highContrastDarkTextColors.primary, isNotNull);
      expect(highContrastDarkTextColors.primaryOnBrand, isNotNull);
      expect(highContrastDarkTextColors.brandPrimary, isNotNull);
      expect(highContrastDarkTextColors.errorPrimary, isNotNull);
      expect(highContrastDarkTextColors.warningPrimary, isNotNull);
      expect(highContrastDarkTextColors.successPrimary, isNotNull);
    });
  });

  group('BackgroundColors', () {
    test('lightBackgroundColors should have all colors defined', () {
      expect(lightBackgroundColors.primary, isNotNull);
      expect(lightBackgroundColors.secondary, isNotNull);
      expect(lightBackgroundColors.tertiary, isNotNull);
      expect(lightBackgroundColors.quaternary, isNotNull);
      expect(lightBackgroundColors.brandPrimary, isNotNull);
      expect(lightBackgroundColors.brandSecondary, isNotNull);
      expect(lightBackgroundColors.brandSolid, isNotNull);
      expect(lightBackgroundColors.errorPrimary, isNotNull);
      expect(lightBackgroundColors.warningPrimary, isNotNull);
      expect(lightBackgroundColors.successPrimary, isNotNull);
    });

    test('darkBackgroundColors should have all colors defined', () {
      expect(darkBackgroundColors.primary, isNotNull);
      expect(darkBackgroundColors.primaryAlt, isNotNull);
      expect(darkBackgroundColors.secondary, isNotNull);
      expect(darkBackgroundColors.tertiary, isNotNull);
      expect(darkBackgroundColors.brandPrimary, isNotNull);
      expect(darkBackgroundColors.errorPrimary, isNotNull);
    });
  });

  group('ForegroundColors', () {
    test('lightForegroundColors should be defined', () {
      expect(lightForegroundColors.primary, isNotNull);
      expect(lightForegroundColors.secondary, isNotNull);
      expect(lightForegroundColors.brandPrimary, isNotNull);
    });

    test('darkForegroundColors should be defined', () {
      expect(darkForegroundColors.primary, isNotNull);
      expect(darkForegroundColors.secondary, isNotNull);
      expect(darkForegroundColors.brandPrimary, isNotNull);
    });
  });

  group('BorderColors', () {
    test('lightBorderColors should be defined', () {
      expect(lightBorderColors.primary, isNotNull);
      expect(lightBorderColors.secondary, isNotNull);
      expect(lightBorderColors.brand, isNotNull);
      expect(lightBorderColors.error, isNotNull);
    });

    test('darkBorderColors should be defined', () {
      expect(darkBorderColors.primary, isNotNull);
      expect(darkBorderColors.secondary, isNotNull);
      expect(darkBorderColors.brand, isNotNull);
      expect(darkBorderColors.error, isNotNull);
    });
  });

  group('UtilityColors', () {
    test('lightUtilityColors should be defined', () {
      expect(lightUtilityColors.blue, isNotNull);
      expect(lightUtilityColors.red, isNotNull);
      expect(lightUtilityColors.green, isNotNull);
      expect(lightUtilityColors.yellow, isNotNull);
    });

    test('darkUtilityColors should be defined', () {
      expect(darkUtilityColors.blue, isNotNull);
      expect(darkUtilityColors.red, isNotNull);
      expect(darkUtilityColors.green, isNotNull);
      expect(darkUtilityColors.yellow, isNotNull);
    });
  });

  group('Base theme configuration', () {
    test('supportedThemes should contain exactly 4 themes', () {
      expect(supportedThemes.length, 4);
    });

    test('should contain base light theme with correct properties', () {
      final lightTheme = supportedThemes.firstWhere(
        (theme) => theme.identifier == 'Base theme',
      );

      expect(lightTheme.themeType, WiseThemeType.light);
      expect(lightTheme.textColors, lightTextColors);
      expect(lightTheme.foregroundColors, lightForegroundColors);
      expect(lightTheme.borderColors, lightBorderColors);
      expect(lightTheme.backgroundColors, lightBackgroundColors);
      expect(lightTheme.utilityColors, lightUtilityColors);
    });

    test('should contain base dark theme with correct properties', () {
      final darkTheme = supportedThemes.firstWhere(
        (theme) => theme.identifier == 'Base dark theme',
      );

      expect(darkTheme.themeType, WiseThemeType.dark);
      expect(darkTheme.textColors, darkTextColors);
      expect(darkTheme.foregroundColors, darkForegroundColors);
      expect(darkTheme.borderColors, darkBorderColors);
      expect(darkTheme.backgroundColors, darkBackgroundColors);
      expect(darkTheme.utilityColors, darkUtilityColors);
    });

    test('should contain high contrast light theme with correct properties',
        () {
      final highContrastTheme = supportedThemes.firstWhere(
        (theme) => theme.identifier == 'High contrast theme',
      );

      expect(highContrastTheme.themeType, WiseThemeType.lightContrast);
      expect(highContrastTheme.textColors, highContrastLightTextColors);
      expect(highContrastTheme.foregroundColors,
          highContrastLightForegroundColors);
      expect(highContrastTheme.borderColors, highContrastLightBorderColors);
      expect(highContrastTheme.backgroundColors,
          highContrastLightBackgroundColors);
      expect(highContrastTheme.utilityColors, highContrastLightUtilityColors);
    });

    test('should contain high contrast dark theme with correct properties', () {
      final highContrastDarkTheme = supportedThemes.firstWhere(
        (theme) => theme.identifier == 'High contrast dark theme',
      );

      expect(highContrastDarkTheme.themeType, WiseThemeType.darkContrast);
      expect(highContrastDarkTheme.textColors, highContrastDarkTextColors);
      expect(highContrastDarkTheme.foregroundColors,
          highContrastDarkForegroundColors);
      expect(highContrastDarkTheme.borderColors, highContrastDarkBorderColors);
      expect(highContrastDarkTheme.backgroundColors,
          highContrastDarkBackgroundColors);
      expect(
          highContrastDarkTheme.utilityColors, highContrastDarkUtilityColors);
    });

    test('all theme identifiers should be unique', () {
      final identifiers =
          supportedThemes.map((theme) => theme.identifier).toList();
      final uniqueIdentifiers = identifiers.toSet();

      expect(identifiers.length, uniqueIdentifiers.length);
    });

    test('should have themes for all WiseThemeType values', () {
      final themeTypes =
          supportedThemes.map((theme) => theme.themeType).toSet();

      expect(
          themeTypes,
          containsAll([
            WiseThemeType.light,
            WiseThemeType.dark,
            WiseThemeType.lightContrast,
            WiseThemeType.darkContrast,
          ]));
    });
  });

  group('Color consistency', () {
    test('all color swatches should have consistent shade values', () {
      final expectedShades = [
        25,
        50,
        100,
        200,
        300,
        400,
        500,
        600,
        700,
        800,
        900,
        950
      ];

      for (final shade in expectedShades) {
        expect(PrimitiveColors.gray[shade], isNotNull,
            reason: 'gray[$shade] should not be null');
        expect(PrimitiveColors.grayDark[shade], isNotNull,
            reason: 'grayDark[$shade] should not be null');
        expect(PrimitiveColors.brand[shade], isNotNull,
            reason: 'brand[$shade] should not be null');
        expect(PrimitiveColors.error[shade], isNotNull,
            reason: 'error[$shade] should not be null');
        expect(PrimitiveColors.warning[shade], isNotNull,
            reason: 'warning[$shade] should not be null');
        expect(PrimitiveColors.success[shade], isNotNull,
            reason: 'success[$shade] should not be null');
        expect(PrimitiveColors.yellow[shade], isNotNull,
            reason: 'yellow[$shade] should not be null');
      }
    });
  });

  group('Theme validation', () {
    test('all themes should have valid color assignments', () {
      for (final theme in supportedThemes) {
        // Verify all color objects are not null
        expect(theme.textColors, isNotNull);
        expect(theme.foregroundColors, isNotNull);
        expect(theme.borderColors, isNotNull);
        expect(theme.backgroundColors, isNotNull);
        expect(theme.utilityColors, isNotNull);

        // Verify identifier is not empty
        expect(theme.identifier.isNotEmpty, isTrue);
      }
    });
  });
}
