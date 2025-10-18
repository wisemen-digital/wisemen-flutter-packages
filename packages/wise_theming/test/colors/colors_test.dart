import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_theming/src/colors/colors.dart';

void main() {
  group('TextColors', () {
    late TextColors textColors;

    setUp(() {
      textColors = const TextColors(
        primary: Color(0xFF000000),
        primaryOnBrand: Color(0xFFFFFFFF),
        secondary: Color(0xFF666666),
        secondaryHover: Color(0xFF333333),
        secondaryOnBrand: Color(0xFFCCCCCC),
        tertiary: Color(0xFF999999),
        tertiaryHover: Color(0xFF777777),
        tertiaryOnBrand: Color(0xFFBBBBBB),
        quaternary: Color(0xFFAAAAAA),
        quaternaryOnBrand: Color(0xFFDDDDDD),
        white: Color(0xFFFFFFFF),
        disabled: Color(0xFFCCCCCC),
        placeholder: Color(0xFF888888),
        placeholderSubtle: Color(0xFFEEEEEE),
        brandPrimary: Color(0xFF0066FF),
        brandSecondary: Color(0xFF3399FF),
        brandTertiary: Color(0xFF66CCFF),
        brandTertiaryAlt: Color(0xFF99DDFF),
        errorPrimary: Color(0xFFFF0000),
        warningPrimary: Color(0xFFFF9900),
        successPrimary: Color(0xFF00FF00),
      );
    });

    test('should create TextColors with all required properties', () {
      expect(textColors.primary, const Color(0xFF000000));
      expect(textColors.primaryOnBrand, const Color(0xFFFFFFFF));
      expect(textColors.secondary, const Color(0xFF666666));
      expect(textColors.secondaryHover, const Color(0xFF333333));
      expect(textColors.secondaryOnBrand, const Color(0xFFCCCCCC));
      expect(textColors.tertiary, const Color(0xFF999999));
      expect(textColors.tertiaryHover, const Color(0xFF777777));
      expect(textColors.tertiaryOnBrand, const Color(0xFFBBBBBB));
      expect(textColors.quaternary, const Color(0xFFAAAAAA));
      expect(textColors.quaternaryOnBrand, const Color(0xFFDDDDDD));
      expect(textColors.white, const Color(0xFFFFFFFF));
      expect(textColors.disabled, const Color(0xFFCCCCCC));
      expect(textColors.placeholder, const Color(0xFF888888));
      expect(textColors.placeholderSubtle, const Color(0xFFEEEEEE));
      expect(textColors.brandPrimary, const Color(0xFF0066FF));
      expect(textColors.brandSecondary, const Color(0xFF3399FF));
      expect(textColors.brandTertiary, const Color(0xFF66CCFF));
      expect(textColors.brandTertiaryAlt, const Color(0xFF99DDFF));
      expect(textColors.errorPrimary, const Color(0xFFFF0000));
      expect(textColors.warningPrimary, const Color(0xFFFF9900));
      expect(textColors.successPrimary, const Color(0xFF00FF00));
    });

    test('should interpolate between two TextColors', () {
      final otherTextColors = const TextColors(
        primary: Color(0xFFFFFFFF),
        primaryOnBrand: Color(0xFF000000),
        secondary: Color(0xFF333333),
        secondaryHover: Color(0xFFCCCCCC),
        secondaryOnBrand: Color(0xFF666666),
        tertiary: Color(0xFF444444),
        tertiaryHover: Color(0xFF888888),
        tertiaryOnBrand: Color(0xFF555555),
        quaternary: Color(0xFF777777),
        quaternaryOnBrand: Color(0xFF222222),
        white: Color(0xFFFFFFFF),
        disabled: Color(0xFF999999),
        placeholder: Color(0xFF111111),
        placeholderSubtle: Color(0xFF444444),
        brandPrimary: Color(0xFFFF6600),
        brandSecondary: Color(0xFFFF3300),
        brandTertiary: Color(0xFFFF0066),
        brandTertiaryAlt: Color(0xFFFF0099),
        errorPrimary: Color(0xFF990000),
        warningPrimary: Color(0xFF996600),
        successPrimary: Color(0xFF009900),
      );

      final interpolated = TextColors.lerp(textColors, otherTextColors, 0.5);

      // Test that interpolation returns valid colors
      expect(interpolated.primary, isNotNull);
      expect(interpolated.brandPrimary, isNotNull);
      expect(interpolated.errorPrimary, isNotNull);

      // Test that all colors are properly interpolated
      expect(interpolated.primary, isNot(equals(textColors.primary)));
      expect(interpolated.primary, isNot(equals(otherTextColors.primary)));
    });

    test('should interpolate at extremes correctly', () {
      final otherTextColors = const TextColors(
        primary: Color(0xFFFFFFFF),
        primaryOnBrand: Color(0xFF000000),
        secondary: Color(0xFF333333),
        secondaryHover: Color(0xFFCCCCCC),
        secondaryOnBrand: Color(0xFF666666),
        tertiary: Color(0xFF444444),
        tertiaryHover: Color(0xFF888888),
        tertiaryOnBrand: Color(0xFF555555),
        quaternary: Color(0xFF777777),
        quaternaryOnBrand: Color(0xFF222222),
        white: Color(0xFFFFFFFF),
        disabled: Color(0xFF999999),
        placeholder: Color(0xFF111111),
        placeholderSubtle: Color(0xFF444444),
        brandPrimary: Color(0xFFFF6600),
        brandSecondary: Color(0xFFFF3300),
        brandTertiary: Color(0xFFFF0066),
        brandTertiaryAlt: Color(0xFFFF0099),
        errorPrimary: Color(0xFF990000),
        warningPrimary: Color(0xFF996600),
        successPrimary: Color(0xFF009900),
      );

      // At t=0, should be exactly the first color scheme
      final interpolatedAt0 = TextColors.lerp(textColors, otherTextColors, 0.0);
      expect(interpolatedAt0.primary, textColors.primary);
      expect(interpolatedAt0.brandPrimary, textColors.brandPrimary);

      // At t=1, should be exactly the second color scheme
      final interpolatedAt1 = TextColors.lerp(textColors, otherTextColors, 1.0);
      expect(interpolatedAt1.primary, otherTextColors.primary);
      expect(interpolatedAt1.brandPrimary, otherTextColors.brandPrimary);
    });
  });

  group('BackgroundColors', () {
    late BackgroundColors backgroundColors;

    setUp(() {
      backgroundColors = const BackgroundColors(
        primary: Color(0xFFFFFFFF),
        primaryAlt: Color(0xFFF8F8F8),
        primaryHover: Color(0xFFF0F0F0),
        primarySolid: Color(0xFF000000),
        secondary: Color(0xFFE8E8E8),
        secondaryAlt: Color(0xFFE0E0E0),
        secondaryHover: Color(0xFFD8D8D8),
        secondarySubtle: Color(0xFFF4F4F4),
        secondarySolid: Color(0xFF666666),
        tertiary: Color(0xFFD0D0D0),
        quaternary: Color(0xFFB8B8B8),
        active: Color(0xFFE8E8E8),
        disabled: Color(0xFFD0D0D0),
        disabledSubtle: Color(0xFFE8E8E8),
        overlay: Color(0x80000000),
        brandPrimary: Color(0xFFE6F3FF),
        brandPrimaryAlt: Color(0xFFE6F3FF),
        brandSecondary: Color(0xFFCCE7FF),
        brandSolid: Color(0xFF0066FF),
        brandSolidHover: Color(0xFF0052CC),
        brandSection: Color(0xFF003D99),
        brandSectionSubtle: Color(0xFF0052CC),
        errorPrimary: Color(0xFFFFEBEB),
        errorSecondary: Color(0xFFFFD6D6),
        errorSolid: Color(0xFFFF0000),
        warningPrimary: Color(0xFFFFF3E6),
        warningSecondary: Color(0xFFFFE6CC),
        warningSolid: Color(0xFFFF9900),
        successPrimary: Color(0xFFE6FFE6),
        successSecondary: Color(0xFFCCFFCC),
        successSolid: Color(0xFF00FF00),
      );
    });

    test('should create BackgroundColors with all required properties', () {
      expect(backgroundColors.primary, isNotNull);
      expect(backgroundColors.primaryAlt, isNotNull);
      expect(backgroundColors.primaryHover, isNotNull);
      expect(backgroundColors.primarySolid, isNotNull);
      expect(backgroundColors.secondary, isNotNull);
      expect(backgroundColors.secondaryAlt, isNotNull);
      expect(backgroundColors.secondaryHover, isNotNull);
      expect(backgroundColors.secondarySubtle, isNotNull);
      expect(backgroundColors.secondarySolid, isNotNull);
      expect(backgroundColors.tertiary, isNotNull);
      expect(backgroundColors.quaternary, isNotNull);
      expect(backgroundColors.active, isNotNull);
      expect(backgroundColors.disabled, isNotNull);
      expect(backgroundColors.disabledSubtle, isNotNull);
      expect(backgroundColors.overlay, isNotNull);
      expect(backgroundColors.brandPrimary, isNotNull);
      expect(backgroundColors.brandPrimaryAlt, isNotNull);
      expect(backgroundColors.brandSecondary, isNotNull);
      expect(backgroundColors.brandSolid, isNotNull);
      expect(backgroundColors.brandSolidHover, isNotNull);
      expect(backgroundColors.brandSection, isNotNull);
      expect(backgroundColors.brandSectionSubtle, isNotNull);
      expect(backgroundColors.errorPrimary, isNotNull);
      expect(backgroundColors.errorSecondary, isNotNull);
      expect(backgroundColors.errorSolid, isNotNull);
      expect(backgroundColors.warningPrimary, isNotNull);
      expect(backgroundColors.warningSecondary, isNotNull);
      expect(backgroundColors.warningSolid, isNotNull);
      expect(backgroundColors.successPrimary, isNotNull);
      expect(backgroundColors.successSecondary, isNotNull);
      expect(backgroundColors.successSolid, isNotNull);
    });

    test('should interpolate between two BackgroundColors', () {
      final otherBackgroundColors = const BackgroundColors(
        primary: Color(0xFF000000),
        primaryAlt: Color(0xFF111111),
        primaryHover: Color(0xFF222222),
        primarySolid: Color(0xFFFFFFFF),
        secondary: Color(0xFF333333),
        secondaryAlt: Color(0xFF444444),
        secondaryHover: Color(0xFF555555),
        secondarySubtle: Color(0xFF166666),
        secondarySolid: Color(0xFF777777),
        tertiary: Color(0xFF888888),
        quaternary: Color(0xFF999999),
        active: Color(0xFFAAAAAA),
        disabled: Color(0xFFBBBBBB),
        disabledSubtle: Color(0xFFCCCCCC),
        overlay: Color(0x80FFFFFF),
        brandPrimary: Color(0xFFFF0000),
        brandPrimaryAlt: Color(0xFFFF1111),
        brandSecondary: Color(0xFFFF2222),
        brandSolid: Color(0xFFFF3333),
        brandSolidHover: Color(0xFFFF4444),
        brandSection: Color(0xFFFF5555),
        brandSectionSubtle: Color(0xFFFF6666),
        errorPrimary: Color(0xFF990000),
        errorSecondary: Color(0xFF880000),
        errorSolid: Color(0xFF770000),
        warningPrimary: Color(0xFF996600),
        warningSecondary: Color(0xFF885500),
        warningSolid: Color(0xFF774400),
        successPrimary: Color(0xFF009900),
        successSecondary: Color(0xFF008800),
        successSolid: Color(0xFF007700),
      );

      final interpolated =
          BackgroundColors.lerp(backgroundColors, otherBackgroundColors, 0.5);

      expect(interpolated.primary, isNotNull);
      expect(interpolated.brandPrimary, isNotNull);
      expect(interpolated.errorPrimary, isNotNull);
    });
  });

  group('BorderColors', () {
    late BorderColors borderColors;

    setUp(() {
      borderColors = const BorderColors(
        primary: Color(0xFF000000),
        secondary: Color(0xFF666666),
        tertiary: Color(0xFFCCCCCC),
        disabled: Color(0xFFE0E0E0),
        disabledSubtle: Color(0xFFF0F0F0),
        brand: Color(0xFF0066FF),
        brandAlt: Color(0xFF3399FF),
        error: Color(0xFFFF0000),
        errorSubtle: Color(0xFFFFCCCC),
      );
    });

    test('should create BorderColors with all required properties', () {
      expect(borderColors.primary, const Color(0xFF000000));
      expect(borderColors.secondary, const Color(0xFF666666));
      expect(borderColors.tertiary, const Color(0xFFCCCCCC));
      expect(borderColors.disabled, const Color(0xFFE0E0E0));
      expect(borderColors.disabledSubtle, const Color(0xFFF0F0F0));
      expect(borderColors.brand, const Color(0xFF0066FF));
      expect(borderColors.brandAlt, const Color(0xFF3399FF));
      expect(borderColors.error, const Color(0xFFFF0000));
      expect(borderColors.errorSubtle, const Color(0xFFFFCCCC));
    });

    test('should interpolate between two BorderColors', () {
      final otherBorderColors = const BorderColors(
        primary: Color(0xFFFFFFFF),
        secondary: Color(0xFF999999),
        tertiary: Color(0xFF333333),
        disabled: Color(0xFF1F1F1F),
        disabledSubtle: Color(0xFF0F0F0F),
        brand: Color(0xFFFF6600),
        brandAlt: Color(0xFFFF3300),
        error: Color(0xFF990000),
        errorSubtle: Color(0xFF663333),
      );

      final interpolated =
          BorderColors.lerp(borderColors, otherBorderColors, 0.5);

      // Test that interpolation returns valid colors
      expect(interpolated.primary, isNotNull);
      expect(interpolated.secondary, isNotNull);
      expect(interpolated.brand, isNotNull);

      // Test that colors are properly interpolated (not equal to either source)
      expect(interpolated.primary, isNot(equals(borderColors.primary)));
      expect(interpolated.primary, isNot(equals(otherBorderColors.primary)));
    });

    test('should interpolate at boundaries correctly', () {
      final otherBorderColors = const BorderColors(
        primary: Color(0xFFFFFFFF),
        secondary: Color(0xFF999999),
        tertiary: Color(0xFF333333),
        disabled: Color(0xFF1F1F1F),
        disabledSubtle: Color(0xFF0F0F0F),
        brand: Color(0xFFFF6600),
        brandAlt: Color(0xFFFF3300),
        error: Color(0xFF990000),
        errorSubtle: Color(0xFF663333),
      );

      // At t=0
      final interpolatedAt0 =
          BorderColors.lerp(borderColors, otherBorderColors, 0.0);
      expect(interpolatedAt0.primary, borderColors.primary);

      // At t=1
      final interpolatedAt1 =
          BorderColors.lerp(borderColors, otherBorderColors, 1.0);
      expect(interpolatedAt1.primary, otherBorderColors.primary);
    });
  });

  group('ForegroundColors', () {
    late ForegroundColors foregroundColors;

    setUp(() {
      foregroundColors = const ForegroundColors(
        primary: Color(0xFF000000),
        secondary: Color(0xFF333333),
        secondaryHover: Color(0xFF111111),
        tertiary: Color(0xFF666666),
        tertiaryHover: Color(0xFF444444),
        quaternary: Color(0xFF999999),
        quaternaryHover: Color(0xFF777777),
        quinary: Color(0xFFBBBBBB),
        quinaryHover: Color(0x0ffaaaaa),
        senary: Color(0xFFDDDDDD),
        white: Color(0xFFFFFFFF),
        disabled: Color(0xFFCCCCCC),
        disabledSubtle: Color(0xFFE8E8E8),
        brandPrimary: Color(0xFF0066FF),
        brandPrimaryAlt: Color(0xFF3399FF),
        brandSecondary: Color(0xFF66CCFF),
        errorPrimary: Color(0xFFFF0000),
        errorSecondary: Color(0xFFFF6666),
        warningPrimary: Color(0xFFFF9900),
        warningSecondary: Color(0xFFFFCC66),
        successPrimary: Color(0xFF00FF00),
        successSecondary: Color(0xFF66FF66),
      );
    });

    test('should create ForegroundColors with all required properties', () {
      expect(foregroundColors.primary, isNotNull);
      expect(foregroundColors.secondary, isNotNull);
      expect(foregroundColors.secondaryHover, isNotNull);
      expect(foregroundColors.tertiary, isNotNull);
      expect(foregroundColors.tertiaryHover, isNotNull);
      expect(foregroundColors.quaternary, isNotNull);
      expect(foregroundColors.quaternaryHover, isNotNull);
      expect(foregroundColors.quinary, isNotNull);
      expect(foregroundColors.quinaryHover, isNotNull);
      expect(foregroundColors.senary, isNotNull);
      expect(foregroundColors.white, isNotNull);
      expect(foregroundColors.disabled, isNotNull);
      expect(foregroundColors.disabledSubtle, isNotNull);
      expect(foregroundColors.brandPrimary, isNotNull);
      expect(foregroundColors.brandPrimaryAlt, isNotNull);
      expect(foregroundColors.brandSecondary, isNotNull);
      expect(foregroundColors.errorPrimary, isNotNull);
      expect(foregroundColors.errorSecondary, isNotNull);
      expect(foregroundColors.warningPrimary, isNotNull);
      expect(foregroundColors.warningSecondary, isNotNull);
      expect(foregroundColors.successPrimary, isNotNull);
      expect(foregroundColors.successSecondary, isNotNull);
    });

    test('should interpolate between two ForegroundColors', () {
      final otherForegroundColors = const ForegroundColors(
        primary: Color(0xFFFFFFFF),
        secondary: Color(0xFFCCCCCC),
        secondaryHover: Color(0xFFEEEEEE),
        tertiary: Color(0xFF999999),
        tertiaryHover: Color(0xFFBBBBBB),
        quaternary: Color(0xFF666666),
        quaternaryHover: Color(0xFF888888),
        quinary: Color(0xFF444444),
        quinaryHover: Color(0xFF555555),
        senary: Color(0xFF222222),
        white: Color(0xFFFFFFFF),
        disabled: Color(0xFF333333),
        disabledSubtle: Color(0xFF171717),
        brandPrimary: Color(0xFFFF6600),
        brandPrimaryAlt: Color(0xFFFF3300),
        brandSecondary: Color(0xFFFF0066),
        errorPrimary: Color(0xFF990000),
        errorSecondary: Color(0xFF996666),
        warningPrimary: Color(0xFF996600),
        warningSecondary: Color(0xFF993366),
        successPrimary: Color(0xFF009900),
        successSecondary: Color(0xFF669966),
      );

      final interpolated =
          ForegroundColors.lerp(foregroundColors, otherForegroundColors, 0.5);

      expect(interpolated.primary, isNotNull);
      expect(interpolated.brandPrimary, isNotNull);
      expect(interpolated.errorPrimary, isNotNull);
    });
  });

  group('UtilityColors', () {
    late UtilityColors utilityColors;

    setUp(() {
      utilityColors = const UtilityColors(
        teal: Color(0xFF008080),
        blue: Color(0xFF0000FF),
        orange: Color(0xFFFF8000),
        pink: Color(0xFFFF69B4),
        purple: Color(0xFF800080),
        green: Color(0xFF008000),
        red: Color(0xFFFF0000),
        yellow: Color(0xFFFFFF00),
        indigo: Color(0xFF4B0082),
      );
    });

    test('should create UtilityColors with all required properties', () {
      expect(utilityColors.teal, const Color(0xFF008080));
      expect(utilityColors.blue, const Color(0xFF0000FF));
      expect(utilityColors.orange, const Color(0xFFFF8000));
      expect(utilityColors.pink, const Color(0xFFFF69B4));
      expect(utilityColors.purple, const Color(0xFF800080));
      expect(utilityColors.green, const Color(0xFF008000));
      expect(utilityColors.red, const Color(0xFFFF0000));
      expect(utilityColors.yellow, const Color(0xFFFFFF00));
      expect(utilityColors.indigo, const Color(0xFF4B0082));
    });

    test('should create UtilityColors with custom colors', () {
      final customColors = {
        'customRed': const Color(0xFFAA0000),
        'customGreen': const Color(0xFF00AA00)
      };

      final utilityColorsWithCustom = UtilityColors(
        teal: const Color(0xFF008080),
        blue: const Color(0xFF0000FF),
        orange: const Color(0xFFFF8000),
        pink: const Color(0xFFFF69B4),
        purple: const Color(0xFF800080),
        green: const Color(0xFF008000),
        red: const Color(0xFFFF0000),
        yellow: const Color(0xFFFFFF00),
        indigo: const Color(0xFF4B0082),
        customColors: customColors,
      );

      expect(utilityColorsWithCustom.customColors, customColors);
      expect(utilityColorsWithCustom.customColors?['customRed'],
          const Color(0xFFAA0000));
      expect(utilityColorsWithCustom.customColors?['customGreen'],
          const Color(0xFF00AA00));
    });

    test('should handle null customColors', () {
      expect(utilityColors.customColors, isNull);
    });

    test('should interpolate between two UtilityColors', () {
      final otherUtilityColors = const UtilityColors(
        teal: Color(0xFF80FFFF),
        blue: Color(0xFF8080FF),
        orange: Color(0xFF80FF80),
        pink: Color(0xFF8069B4),
        purple: Color(0xFF808080),
        green: Color(0xFF808000),
        red: Color(0xFF800000),
        yellow: Color(0xFF808000),
        indigo: Color(0xFFB40082),
      );

      final interpolated =
          UtilityColors.lerp(utilityColors, otherUtilityColors, 0.5);

      expect(interpolated.teal, isNotNull);
      expect(interpolated.blue, isNotNull);
      expect(interpolated.orange, isNotNull);
      expect(interpolated.pink, isNotNull);
      expect(interpolated.purple, isNotNull);
      expect(interpolated.green, isNotNull);
      expect(interpolated.red, isNotNull);
      expect(interpolated.yellow, isNotNull);
      expect(interpolated.indigo, isNotNull);
    });

    test('should interpolate custom colors correctly', () {
      final customColors1 = {'custom1': const Color(0xFF000000)};
      final customColors2 = {'custom2': const Color(0xFFFFFFFF)};

      final utilityColors1 = UtilityColors(
        teal: const Color(0xFF008080),
        blue: const Color(0xFF0000FF),
        orange: const Color(0xFFFF8000),
        pink: const Color(0xFFFF69B4),
        purple: const Color(0xFF800080),
        green: const Color(0xFF008000),
        red: const Color(0xFFFF0000),
        yellow: const Color(0xFFFFFF00),
        indigo: const Color(0xFF4B0082),
        customColors: customColors1,
      );

      final utilityColors2 = UtilityColors(
        teal: const Color(0xFF80FFFF),
        blue: const Color(0xFF8080FF),
        orange: const Color(0xFF80FF80),
        pink: const Color(0xFF8069B4),
        purple: const Color(0xFF808080),
        green: const Color(0xFF808000),
        red: const Color(0xFF800000),
        yellow: const Color(0xFF808000),
        indigo: const Color(0xFFB40082),
        customColors: customColors2,
      );

      final interpolated =
          UtilityColors.lerp(utilityColors1, utilityColors2, 0.5);

      // Custom colors should use the second parameter's custom colors
      expect(interpolated.customColors, customColors2);
    });
  });

  group('Color interpolation edge cases', () {
    test('should handle interpolation at t=0', () {
      final textColors1 = const TextColors(
        primary: Color(0xFF000000),
        primaryOnBrand: Color(0xFFFFFFFF),
        secondary: Color(0xFF666666),
        secondaryHover: Color(0xFF333333),
        secondaryOnBrand: Color(0xFFCCCCCC),
        tertiary: Color(0xFF999999),
        tertiaryHover: Color(0xFF777777),
        tertiaryOnBrand: Color(0xFFBBBBBB),
        quaternary: Color(0xFFAAAAAA),
        quaternaryOnBrand: Color(0xFFDDDDDD),
        white: Color(0xFFFFFFFF),
        disabled: Color(0xFFCCCCCC),
        placeholder: Color(0xFF888888),
        placeholderSubtle: Color(0xFFEEEEEE),
        brandPrimary: Color(0xFF0066FF),
        brandSecondary: Color(0xFF3399FF),
        brandTertiary: Color(0xFF66CCFF),
        brandTertiaryAlt: Color(0xFF99DDFF),
        errorPrimary: Color(0xFFFF0000),
        warningPrimary: Color(0xFFFF9900),
        successPrimary: Color(0xFF00FF00),
      );

      final textColors2 = const TextColors(
        primary: Color(0xFFFFFFFF),
        primaryOnBrand: Color(0xFF000000),
        secondary: Color(0xFF333333),
        secondaryHover: Color(0xFFCCCCCC),
        secondaryOnBrand: Color(0xFF666666),
        tertiary: Color(0xFF444444),
        tertiaryHover: Color(0xFF888888),
        tertiaryOnBrand: Color(0xFF555555),
        quaternary: Color(0xFF777777),
        quaternaryOnBrand: Color(0xFF222222),
        white: Color(0xFFFFFFFF),
        disabled: Color(0xFF999999),
        placeholder: Color(0xFF111111),
        placeholderSubtle: Color(0xFF444444),
        brandPrimary: Color(0xFFFF6600),
        brandSecondary: Color(0xFFFF3300),
        brandTertiary: Color(0xFFFF0066),
        brandTertiaryAlt: Color(0xFFFF0099),
        errorPrimary: Color(0xFF990000),
        warningPrimary: Color(0xFF996600),
        successPrimary: Color(0xFF009900),
      );

      final interpolated = TextColors.lerp(textColors1, textColors2, 0.0);

      expect(interpolated.primary, textColors1.primary);
      expect(interpolated.brandPrimary, textColors1.brandPrimary);
      expect(interpolated.errorPrimary, textColors1.errorPrimary);
    });

    test('should handle interpolation at t=1', () {
      final borderColors1 = const BorderColors(
        primary: Color(0xFF000000),
        secondary: Color(0xFF666666),
        tertiary: Color(0xFFCCCCCC),
        disabled: Color(0xFFE0E0E0),
        disabledSubtle: Color(0xFFF0F0F0),
        brand: Color(0xFF0066FF),
        brandAlt: Color(0xFF3399FF),
        error: Color(0xFFFF0000),
        errorSubtle: Color(0xFFFFCCCC),
      );

      final borderColors2 = const BorderColors(
        primary: Color(0xFFFFFFFF),
        secondary: Color(0xFF999999),
        tertiary: Color(0xFF333333),
        disabled: Color(0xFF1F1F1F),
        disabledSubtle: Color(0xFF0F0F0F),
        brand: Color(0xFFFF6600),
        brandAlt: Color(0xFFFF3300),
        error: Color(0xFF990000),
        errorSubtle: Color(0xFF663333),
      );

      final interpolated = BorderColors.lerp(borderColors1, borderColors2, 1.0);

      expect(interpolated.primary, borderColors2.primary);
      expect(interpolated.brand, borderColors2.brand);
      expect(interpolated.error, borderColors2.error);
    });
  });
}
