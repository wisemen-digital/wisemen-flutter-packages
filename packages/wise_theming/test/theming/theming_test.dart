import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_theming/src/colors/colors.dart';
import 'package:wise_theming/src/theming/theming.dart';

void main() {
  group('WiseThemeType', () {
    group('brightness', () {
      test('light themes should return Brightness.light', () {
        expect(WiseThemeType.light.brightness, Brightness.light);
        expect(WiseThemeType.lightContrast.brightness, Brightness.light);
      });

      test('dark themes should return Brightness.dark', () {
        expect(WiseThemeType.dark.brightness, Brightness.dark);
        expect(WiseThemeType.darkContrast.brightness, Brightness.dark);
      });
    });

    group('themeMode', () {
      test('light themes should return ThemeMode.light', () {
        expect(WiseThemeType.light.themeMode, ThemeMode.light);
        expect(WiseThemeType.lightContrast.themeMode, ThemeMode.light);
      });

      test('dark themes should return ThemeMode.dark', () {
        expect(WiseThemeType.dark.themeMode, ThemeMode.dark);
        expect(WiseThemeType.darkContrast.themeMode, ThemeMode.dark);
      });
    });

    group('isHighContrast', () {
      test('regular themes should not be high contrast', () {
        expect(WiseThemeType.light.isHighContrast, false);
        expect(WiseThemeType.dark.isHighContrast, false);
      });

      test('contrast themes should be high contrast', () {
        expect(WiseThemeType.lightContrast.isHighContrast, true);
        expect(WiseThemeType.darkContrast.isHighContrast, true);
      });
    });

    group('enum values', () {
      test('should have exactly 4 values', () {
        expect(WiseThemeType.values.length, 4);
      });

      test('should contain all expected values', () {
        expect(
            WiseThemeType.values,
            containsAll([
              WiseThemeType.light,
              WiseThemeType.lightContrast,
              WiseThemeType.dark,
              WiseThemeType.darkContrast,
            ]));
      });
    });
  });

  group('WiseTheme', () {
    late WiseTheme lightTheme;
    late WiseTheme darkTheme;
    late TextColors mockTextColors;
    late BackgroundColors mockBackgroundColors;
    late BorderColors mockBorderColors;
    late ForegroundColors mockForegroundColors;
    late UtilityColors mockUtilityColors;

    setUp(() {
      mockTextColors = const TextColors(
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

      mockBackgroundColors = const BackgroundColors(
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

      mockBorderColors = const BorderColors(
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

      mockForegroundColors = const ForegroundColors(
        primary: Color(0xFF000000),
        secondary: Color(0xFF333333),
        secondaryHover: Color(0xFF111111),
        tertiary: Color(0xFF666666),
        tertiaryHover: Color(0xFF444444),
        quaternary: Color(0xFF999999),
        quaternaryHover: Color(0xFF777777),
        quinary: Color(0xFFBBBBBB),
        quinaryHover: Color(0xFFAAAAAA),
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

      mockUtilityColors = const UtilityColors(
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

      lightTheme = WiseTheme(
        identifier: 'test-light-theme',
        themeType: WiseThemeType.light,
        textColors: mockTextColors,
        backgroundColors: mockBackgroundColors,
        borderColors: mockBorderColors,
        foregroundColors: mockForegroundColors,
        utilityColors: mockUtilityColors,
      );

      darkTheme = WiseTheme(
        identifier: 'test-dark-theme',
        themeType: WiseThemeType.dark,
        textColors: mockTextColors,
        backgroundColors: mockBackgroundColors,
        borderColors: mockBorderColors,
        foregroundColors: mockForegroundColors,
        utilityColors: mockUtilityColors,
      );
    });

    group('constructor', () {
      test('should create WiseTheme with all required properties', () {
        expect(lightTheme.identifier, 'test-light-theme');
        expect(lightTheme.themeType, WiseThemeType.light);
        expect(lightTheme.textColors, mockTextColors);
        expect(lightTheme.backgroundColors, mockBackgroundColors);
        expect(lightTheme.borderColors, mockBorderColors);
        expect(lightTheme.foregroundColors, mockForegroundColors);
        expect(lightTheme.utilityColors, mockUtilityColors);
      });
    });

    group('ThemeExtension implementation', () {
      test('should have correct type property', () {
        expect(lightTheme.type, WiseTheme);
      });

      test('copyWith should create new instance with updated properties', () {
        final updatedTheme = lightTheme.copyWith(
          identifier: 'updated-theme',
          themeType: WiseThemeType.dark,
        ) as WiseTheme;

        expect(updatedTheme.identifier, 'updated-theme');
        expect(updatedTheme.themeType, WiseThemeType.dark);
        expect(updatedTheme.textColors, lightTheme.textColors);
        expect(updatedTheme.backgroundColors, lightTheme.backgroundColors);
        expect(updatedTheme.borderColors, lightTheme.borderColors);
        expect(updatedTheme.foregroundColors, lightTheme.foregroundColors);
        expect(updatedTheme.utilityColors, lightTheme.utilityColors);
      });

      test('copyWith should preserve original properties when null', () {
        final copiedTheme = lightTheme.copyWith() as WiseTheme;

        expect(copiedTheme.identifier, lightTheme.identifier);
        expect(copiedTheme.themeType, lightTheme.themeType);
        expect(copiedTheme.textColors, lightTheme.textColors);
        expect(copiedTheme.backgroundColors, lightTheme.backgroundColors);
        expect(copiedTheme.borderColors, lightTheme.borderColors);
        expect(copiedTheme.foregroundColors, lightTheme.foregroundColors);
        expect(copiedTheme.utilityColors, lightTheme.utilityColors);
      });

      test('copyWith should update individual color schemes', () {
        final newTextColors = const TextColors(
          primary: Color(0xFF111111),
          primaryOnBrand: Color(0xFFEEEEEE),
          secondary: Color(0xFF555555),
          secondaryHover: Color(0xFF222222),
          secondaryOnBrand: Color(0xFFDDDDDD),
          tertiary: Color(0xFF888888),
          tertiaryHover: Color(0xFF666666),
          tertiaryOnBrand: Color(0xFFAAAAAA),
          quaternary: Color(0xFFBBBBBB),
          quaternaryOnBrand: Color(0xFFCCCCCC),
          white: Color(0xFFFFFFFF),
          disabled: Color(0xFFDDDDDD),
          placeholder: Color(0xFF777777),
          placeholderSubtle: Color(0xFFDDDDDD),
          brandPrimary: Color(0xFF0077FF),
          brandSecondary: Color(0xFF44AAFF),
          brandTertiary: Color(0xFF77DDFF),
          brandTertiaryAlt: Color(0xFFAAEEFF),
          errorPrimary: Color(0xFFEE0000),
          warningPrimary: Color(0xFFEE8800),
          successPrimary: Color(0xFF00EE00),
        );

        final updatedTheme = lightTheme.copyWith(textColors: newTextColors) as WiseTheme;

        expect(updatedTheme.textColors, newTextColors);
        expect(updatedTheme.identifier, lightTheme.identifier);
        expect(updatedTheme.themeType, lightTheme.themeType);
      });
    });

    group('lerp method', () {
      test('should return self when other is not WiseTheme', () {
        final result = lightTheme.lerp(null, 0.5);
        expect(result, lightTheme);
      });

      test('should interpolate between two WiseThemes at t=0', () {
        final result = lightTheme.lerp(darkTheme, 0.0) as WiseTheme;

        expect(result.identifier, lightTheme.identifier);
        expect(result.themeType, lightTheme.themeType);
      });

      test('should interpolate between two WiseThemes at t=1', () {
        final result = lightTheme.lerp(darkTheme, 1.0) as WiseTheme;

        expect(result.identifier, darkTheme.identifier);
        expect(result.themeType, darkTheme.themeType);
      });

      test('should interpolate between two WiseThemes at t=0.4', () {
        final result = lightTheme.lerp(darkTheme, 0.4) as WiseTheme;

        expect(result.identifier, lightTheme.identifier);
        expect(result.themeType, lightTheme.themeType);
      });

      test('should interpolate between two WiseThemes at t=0.6', () {
        final result = lightTheme.lerp(darkTheme, 0.6) as WiseTheme;

        expect(result.identifier, darkTheme.identifier);
        expect(result.themeType, darkTheme.themeType);
      });

      test('should interpolate color schemes', () {
        final result = lightTheme.lerp(darkTheme, 0.5) as WiseTheme;

        expect(result.textColors, isNotNull);
        expect(result.backgroundColors, isNotNull);
        expect(result.borderColors, isNotNull);
        expect(result.foregroundColors, isNotNull);
        expect(result.utilityColors, isNotNull);
      });
    });

    group('asThemeData', () {
      test('should generate ThemeData with correct brightness for light theme', () {
        final themeData = lightTheme.asThemeData(TargetPlatform.android);

        expect(themeData.brightness, Brightness.light);
        expect(themeData.colorScheme.brightness, Brightness.light);
      });

      test('should generate ThemeData with correct brightness for dark theme', () {
        final themeData = darkTheme.asThemeData(TargetPlatform.android);

        expect(themeData.brightness, Brightness.dark);
        expect(themeData.colorScheme.brightness, Brightness.dark);
      });

      test('should include WiseTheme extension', () {
        final themeData = lightTheme.asThemeData(TargetPlatform.android);

        expect(themeData.extensions[WiseTheme], lightTheme);
      });

      test('should use Material 3', () {
        final themeData = lightTheme.asThemeData(TargetPlatform.android);

        expect(themeData.useMaterial3, true);
      });

      test('should set scaffold background color', () {
        final themeData = lightTheme.asThemeData(TargetPlatform.android);

        expect(themeData.scaffoldBackgroundColor, mockBackgroundColors.primary);
      });

      group('platform-specific configuration', () {
        test('should use Cupertino font for iOS', () {
          final themeData = lightTheme.asThemeData(TargetPlatform.iOS);

          expect(themeData.textTheme.bodyLarge?.fontFamily, 'CupertinoSystemDisplay');
          expect(themeData.splashFactory, NoSplash.splashFactory);
        });

        test('should use Cupertino font for macOS', () {
          final themeData = lightTheme.asThemeData(TargetPlatform.macOS);

          expect(themeData.textTheme.bodyLarge?.fontFamily, 'CupertinoSystemDisplay');
          expect(themeData.splashFactory, NoSplash.splashFactory);
        });

        test('should use RobotoFlex font for Android', () {
          final themeData = lightTheme.asThemeData(TargetPlatform.android);

          expect(themeData.textTheme.bodyLarge?.fontFamily, 'RobotoFlex');
          expect(themeData.splashFactory, isNotNull);
        });

        test('should use RobotoFlex font for other platforms', () {
          final themeDataLinux = lightTheme.asThemeData(TargetPlatform.linux);
          final themeDataWindows = lightTheme.asThemeData(TargetPlatform.windows);
          final themeDataFuchsia = lightTheme.asThemeData(TargetPlatform.fuchsia);

          expect(themeDataLinux.textTheme.bodyLarge?.fontFamily, 'RobotoFlex');
          expect(themeDataWindows.textTheme.bodyLarge?.fontFamily, 'RobotoFlex');
          expect(themeDataFuchsia.textTheme.bodyLarge?.fontFamily, 'RobotoFlex');
        });
      });

      group('page transitions', () {
        test('should set correct page transitions', () {
          final themeData = lightTheme.asThemeData(TargetPlatform.android);

          expect(themeData.pageTransitionsTheme, isNotNull);
          expect(themeData.pageTransitionsTheme.builders[TargetPlatform.android], isA<FadeForwardsPageTransitionsBuilder>());
          expect(themeData.pageTransitionsTheme.builders[TargetPlatform.iOS], isA<CupertinoPageTransitionsBuilder>());
          expect(themeData.pageTransitionsTheme.builders[TargetPlatform.macOS], isA<CupertinoPageTransitionsBuilder>());
        });
      });

      group('color scheme mapping', () {
        test('should map colors correctly to ColorScheme', () {
          final themeData = lightTheme.asThemeData(TargetPlatform.android);
          final colorScheme = themeData.colorScheme;

          expect(colorScheme.primary, mockForegroundColors.brandPrimary);
          expect(colorScheme.onPrimary, mockTextColors.primaryOnBrand);
          expect(colorScheme.secondary, mockForegroundColors.primary);
          expect(colorScheme.onSecondary, mockTextColors.primary);
          expect(colorScheme.error, mockForegroundColors.errorPrimary);
          expect(colorScheme.onError, mockTextColors.errorPrimary);
          expect(colorScheme.surface, mockBackgroundColors.primary);
          expect(colorScheme.onSurface, mockTextColors.primary);
          expect(colorScheme.outline, mockBorderColors.primary);
          expect(colorScheme.outlineVariant, mockBorderColors.secondary);
        });
      });

      group('app bar theme', () {
        test('should configure app bar theme correctly', () {
          final themeData = lightTheme.asThemeData(TargetPlatform.android);
          final appBarTheme = themeData.appBarTheme;

          expect(appBarTheme.backgroundColor, mockBackgroundColors.primary);
          expect(appBarTheme.foregroundColor, mockTextColors.primary);
          expect(appBarTheme.iconTheme?.color, mockTextColors.primary);
          expect(appBarTheme.actionsIconTheme?.color, mockTextColors.primary);
          expect(appBarTheme.elevation, 0);
          expect(appBarTheme.centerTitle, false);
        });

        test('should center title for iOS platforms', () {
          final themeDataIOS = lightTheme.asThemeData(TargetPlatform.iOS);
          final themeDataMacOS = lightTheme.asThemeData(TargetPlatform.macOS);

          expect(themeDataIOS.appBarTheme.centerTitle, true);
          expect(themeDataMacOS.appBarTheme.centerTitle, true);
        });
      });

      group('cupertino override theme', () {
        test('should configure Cupertino theme correctly', () {
          final themeData = lightTheme.asThemeData(TargetPlatform.iOS);
          final cupertinoTheme = themeData.cupertinoOverrideTheme;

          expect(cupertinoTheme?.primaryColor, mockForegroundColors.brandPrimary);
          expect(cupertinoTheme?.primaryContrastingColor, mockTextColors.primaryOnBrand);
          expect(cupertinoTheme?.barBackgroundColor, mockBackgroundColors.primary);
          expect(cupertinoTheme?.brightness, lightTheme.themeType.brightness);
          expect(cupertinoTheme?.scaffoldBackgroundColor, mockBackgroundColors.primary);
        });
      });
    });

    group('theme equality and identity', () {
      test('themes with same properties should be equal', () {
        final theme1 = WiseTheme(
          identifier: 'test',
          themeType: WiseThemeType.light,
          textColors: mockTextColors,
          backgroundColors: mockBackgroundColors,
          borderColors: mockBorderColors,
          foregroundColors: mockForegroundColors,
          utilityColors: mockUtilityColors,
        );

        final theme2 = WiseTheme(
          identifier: 'test',
          themeType: WiseThemeType.light,
          textColors: mockTextColors,
          backgroundColors: mockBackgroundColors,
          borderColors: mockBorderColors,
          foregroundColors: mockForegroundColors,
          utilityColors: mockUtilityColors,
        );

        expect(theme1.identifier, theme2.identifier);
        expect(theme1.themeType, theme2.themeType);
        expect(theme1.textColors, theme2.textColors);
      });

      test('should be different instances even with same properties', () {
        final theme1 = WiseTheme(
          identifier: 'test',
          themeType: WiseThemeType.light,
          textColors: mockTextColors,
          backgroundColors: mockBackgroundColors,
          borderColors: mockBorderColors,
          foregroundColors: mockForegroundColors,
          utilityColors: mockUtilityColors,
        );

        final theme2 = WiseTheme(
          identifier: 'test',
          themeType: WiseThemeType.light,
          textColors: mockTextColors,
          backgroundColors: mockBackgroundColors,
          borderColors: mockBorderColors,
          foregroundColors: mockForegroundColors,
          utilityColors: mockUtilityColors,
        );

        expect(identical(theme1, theme2), false);
      });
    });
  });
}
