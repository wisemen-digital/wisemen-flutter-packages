import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_theming/src/colors/colors.dart';
import 'package:wise_theming/src/styles/styles.dart';
import 'package:wise_theming/src/theming/theming.dart';
import 'package:wise_theming/src/wise_theming.dart';

void main() {
  group('WiseTheming', () {
    late List<WiseTheme> mockSupportedThemes;
    late WiseTheme lightTheme;
    late WiseTheme darkTheme;
    late WiseTheme lightContrastTheme;
    late WiseTheme darkContrastTheme;
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
        identifier: 'light-theme',
        themeType: WiseThemeType.light,
        textColors: mockTextColors,
        backgroundColors: mockBackgroundColors,
        borderColors: mockBorderColors,
        foregroundColors: mockForegroundColors,
        utilityColors: mockUtilityColors,
      );

      darkTheme = WiseTheme(
        identifier: 'dark-theme',
        themeType: WiseThemeType.dark,
        textColors: mockTextColors,
        backgroundColors: mockBackgroundColors,
        borderColors: mockBorderColors,
        foregroundColors: mockForegroundColors,
        utilityColors: mockUtilityColors,
      );

      lightContrastTheme = WiseTheme(
        identifier: 'light-contrast-theme',
        themeType: WiseThemeType.lightContrast,
        textColors: mockTextColors,
        backgroundColors: mockBackgroundColors,
        borderColors: mockBorderColors,
        foregroundColors: mockForegroundColors,
        utilityColors: mockUtilityColors,
      );

      darkContrastTheme = WiseTheme(
        identifier: 'dark-contrast-theme',
        themeType: WiseThemeType.darkContrast,
        textColors: mockTextColors,
        backgroundColors: mockBackgroundColors,
        borderColors: mockBorderColors,
        foregroundColors: mockForegroundColors,
        utilityColors: mockUtilityColors,
      );

      mockSupportedThemes = [
        lightTheme,
        darkTheme,
        lightContrastTheme,
        darkContrastTheme,
      ];
    });

    group('constructor', () {
      test('should create WiseTheming with supported themes', () {
        final theming = WiseTheming(
          supportedThemes: mockSupportedThemes,
          targetPlatform: TargetPlatform.android,
          selectedTheme: lightTheme,
        );

        expect(theming.supportedThemes, mockSupportedThemes);
        expect(theming.targetPlatform, TargetPlatform.android);
        expect(theming.value, lightTheme);
      });

      test('should create WiseTheming without selected theme', () {
        final theming = WiseTheming(
          supportedThemes: mockSupportedThemes,
          targetPlatform: TargetPlatform.iOS,
        );

        expect(theming.supportedThemes, mockSupportedThemes);
        expect(theming.targetPlatform, TargetPlatform.iOS);
        expect(theming.value, isNull);
      });

      test('should throw assertion error when supportedThemes is empty', () {
        expect(
          () => WiseTheming(
            supportedThemes: [],
            targetPlatform: TargetPlatform.android,
          ),
          throwsAssertionError,
        );
      });
    });

    group('setCurrentTheme', () {
      late WiseTheming theming;

      setUp(() {
        theming = WiseTheming(
          supportedThemes: mockSupportedThemes,
          targetPlatform: TargetPlatform.android,
        );
      });

      test('should set theme by identifier', () {
        final result = theming.setCurrentTheme('dark-theme');

        expect(result, darkTheme);
        expect(theming.value, darkTheme);
      });

      test('should set different theme by identifier', () {
        final result = theming.setCurrentTheme('light-contrast-theme');

        expect(result, lightContrastTheme);
        expect(theming.value, lightContrastTheme);
      });

      test('should throw ArgumentError for non-existent theme', () {
        expect(
          () => theming.setCurrentTheme('non-existent-theme'),
          throwsA(
            isA<ArgumentError>().having(
              (error) => error.message,
              'message',
              'No theme found with identifier: non-existent-theme',
            ),
          ),
        );
      });

      test('should notify listeners when theme changes', () {
        var notificationCount = 0;
        theming.addListener(() => notificationCount++);

        final result = theming.setCurrentTheme('dark-theme');

        // Note: setCurrentTheme calls notifyListeners() directly, plus ValueNotifier
        // calls notifyListeners() when value changes, so we get 2 notifications
        expect(notificationCount, 2);
        expect(result, darkTheme);
      });

      test('should handle multiple theme changes', () {
        var result = theming.setCurrentTheme('light-theme');
        expect(theming.value, lightTheme);
        expect(result, lightTheme);

        result = theming.setCurrentTheme('dark-theme');
        expect(theming.value, darkTheme);
        expect(result, darkTheme);

        result = theming.setCurrentTheme('light-contrast-theme');
        expect(theming.value, lightContrastTheme);
        expect(result, lightContrastTheme);
      });
    });

    group('theme getters', () {
      late WiseTheming theming;

      setUp(() {
        theming = WiseTheming(
          supportedThemes: mockSupportedThemes,
          targetPlatform: TargetPlatform.android,
          selectedTheme: lightTheme,
        );
      });

      test('lightTheme should return light theme when selected theme is set', () {
        final themeData = theming.lightTheme;

        expect(themeData, isNotNull);
        expect(themeData?.brightness, Brightness.light);
        expect(themeData?.extensions[WiseTheme], lightTheme);
      });

      test('darkTheme should return current theme when selected theme is set', () {
        final themeData = theming.darkTheme;

        expect(themeData, isNotNull);
        // _getThemeByType returns current value (lightTheme) when value is not null
        expect(themeData?.brightness, Brightness.light);
        expect(themeData?.extensions[WiseTheme], lightTheme);
      });

      test('lightContrastTheme should return current theme when selected theme is set', () {
        final themeData = theming.lightContrastTheme;

        expect(themeData, isNotNull);
        // _getThemeByType returns current value (lightTheme) when value is not null
        expect(themeData?.brightness, Brightness.light);
        expect(themeData?.extensions[WiseTheme], lightTheme);
      });

      test('darkContrastTheme should return current theme when selected theme is set', () {
        final themeData = theming.darkContrastTheme;

        expect(themeData, isNotNull);
        // _getThemeByType returns current value (lightTheme) when value is not null
        expect(themeData?.brightness, Brightness.light);
        expect(themeData?.extensions[WiseTheme], lightTheme);
      });

      test('should return null themes when no selected theme and no fallback available', () {
        final themingNoThemes = WiseTheming(
          supportedThemes: [lightTheme], // Only light theme, no dark theme
          targetPlatform: TargetPlatform.android,
        );

        expect(themingNoThemes.darkTheme, isNull);
        expect(themingNoThemes.lightContrastTheme, isNull);
        expect(themingNoThemes.darkContrastTheme, isNull);
      });

      test('should fallback to first available theme of correct type when no selected theme', () {
        final themingNoSelected = WiseTheming(
          supportedThemes: mockSupportedThemes,
          targetPlatform: TargetPlatform.android,
        );

        final lightThemeData = themingNoSelected.lightTheme;
        final darkThemeData = themingNoSelected.darkTheme;
        final lightContrastThemeData = themingNoSelected.lightContrastTheme;
        final darkContrastThemeData = themingNoSelected.darkContrastTheme;

        expect(lightThemeData, isNotNull);
        expect(darkThemeData, isNotNull);
        expect(lightContrastThemeData, isNotNull);
        expect(darkContrastThemeData, isNotNull);
      });

      test('themeMode should return correct ThemeMode', () {
        var result = theming.setCurrentTheme('light-theme');
        expect(theming.themeMode, ThemeMode.light);
        expect(result, lightTheme);

        result = theming.setCurrentTheme('dark-theme');
        expect(theming.themeMode, ThemeMode.dark);
        expect(result, darkTheme);

        result = theming.setCurrentTheme('light-contrast-theme');
        expect(theming.themeMode, ThemeMode.light);
        expect(result, lightContrastTheme);

        result = theming.setCurrentTheme('dark-contrast-theme');
        expect(theming.themeMode, ThemeMode.dark);
        expect(result, darkContrastTheme);
      });

      test('themeMode should return null when no theme selected', () {
        final themingNoSelected = WiseTheming(
          supportedThemes: mockSupportedThemes,
          targetPlatform: TargetPlatform.android,
        );

        expect(themingNoSelected.themeMode, isNull);
      });
    });
  });

  group('WiseThemeExtension', () {
    late WiseTheme testTheme;

    setUp(() {
      testTheme = WiseTheme(
        identifier: 'test-theme',
        themeType: WiseThemeType.light,
        textColors: const TextColors(
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
        ),
        backgroundColors: const BackgroundColors(
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
        ),
        borderColors: const BorderColors(
          primary: Color(0xFF000000),
          secondary: Color(0xFF666666),
          tertiary: Color(0xFFCCCCCC),
          disabled: Color(0xFFE0E0E0),
          disabledSubtle: Color(0xFFF0F0F0),
          brand: Color(0xFF0066FF),
          brandAlt: Color(0xFF3399FF),
          error: Color(0xFFFF0000),
          errorSubtle: Color(0xFFFFCCCC),
        ),
        foregroundColors: const ForegroundColors(
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
        ),
        utilityColors: const UtilityColors(
          teal: Color(0xFF008080),
          blue: Color(0xFF0000FF),
          orange: Color(0xFFFF8000),
          pink: Color(0xFFFF69B4),
          purple: Color(0xFF800080),
          green: Color(0xFF008000),
          red: Color(0xFFFF0000),
          yellow: Color(0xFFFFFF00),
          indigo: Color(0xFF4B0082),
        ),
      );
    });

    testWidgets('wiseTheme should return WiseTheme from context', (tester) async {
      late WiseTheme contextTheme;

      await tester.pumpWidget(
        MaterialApp(
          theme: testTheme.asThemeData(TargetPlatform.android),
          home: Builder(
            builder: (context) {
              contextTheme = context.wiseTheme;
              return Container();
            },
          ),
        ),
      );

      expect(contextTheme, testTheme);
    });

    testWidgets('should throw assertion when no WiseTheme in context', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(), // No WiseTheme extension
          home: Builder(
            builder: (context) {
              expect(() => context.wiseTheme, throwsAssertionError);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('backgroundColors should return BackgroundColors', (tester) async {
      late BackgroundColors contextBackgroundColors;

      await tester.pumpWidget(
        MaterialApp(
          theme: testTheme.asThemeData(TargetPlatform.android),
          home: Builder(
            builder: (context) {
              contextBackgroundColors = context.backgroundColors;
              return Container();
            },
          ),
        ),
      );

      expect(contextBackgroundColors, testTheme.backgroundColors);
    });

    testWidgets('borderColors should return BorderColors', (tester) async {
      late BorderColors contextBorderColors;

      await tester.pumpWidget(
        MaterialApp(
          theme: testTheme.asThemeData(TargetPlatform.android),
          home: Builder(
            builder: (context) {
              contextBorderColors = context.borderColors;
              return Container();
            },
          ),
        ),
      );

      expect(contextBorderColors, testTheme.borderColors);
    });

    testWidgets('foregroundColors should return ForegroundColors', (tester) async {
      late ForegroundColors contextForegroundColors;

      await tester.pumpWidget(
        MaterialApp(
          theme: testTheme.asThemeData(TargetPlatform.android),
          home: Builder(
            builder: (context) {
              contextForegroundColors = context.foregroundColors;
              return Container();
            },
          ),
        ),
      );

      expect(contextForegroundColors, testTheme.foregroundColors);
    });

    testWidgets('textColors should return TextColors', (tester) async {
      late TextColors contextTextColors;

      await tester.pumpWidget(
        MaterialApp(
          theme: testTheme.asThemeData(TargetPlatform.android),
          home: Builder(
            builder: (context) {
              contextTextColors = context.textColors;
              return Container();
            },
          ),
        ),
      );

      expect(contextTextColors, testTheme.textColors);
    });

    testWidgets('utilityColors should return UtilityColors', (tester) async {
      late UtilityColors contextUtilityColors;

      await tester.pumpWidget(
        MaterialApp(
          theme: testTheme.asThemeData(TargetPlatform.android),
          home: Builder(
            builder: (context) {
              contextUtilityColors = context.utilityColors;
              return Container();
            },
          ),
        ),
      );

      expect(contextUtilityColors, testTheme.utilityColors);
    });

    testWidgets('brightness should return correct brightness', (tester) async {
      late Brightness contextBrightness;

      await tester.pumpWidget(
        MaterialApp(
          theme: testTheme.asThemeData(TargetPlatform.android),
          home: Builder(
            builder: (context) {
              contextBrightness = context.brightness;
              return Container();
            },
          ),
        ),
      );

      expect(contextBrightness, Brightness.light);
    });
  });

  group('TextStyleExtension', () {
    late WiseTheme testTheme;

    setUp(() {
      testTheme = WiseTheme(
        identifier: 'test-theme',
        themeType: WiseThemeType.light,
        textColors: const TextColors(
          primary: Color(0xFF123456),
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
        ),
        backgroundColors: const BackgroundColors(
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
        ),
        borderColors: const BorderColors(
          primary: Color(0xFF000000),
          secondary: Color(0xFF666666),
          tertiary: Color(0xFFCCCCCC),
          disabled: Color(0xFFE0E0E0),
          disabledSubtle: Color(0xFFF0F0F0),
          brand: Color(0xFF0066FF),
          brandAlt: Color(0xFF3399FF),
          error: Color(0xFFFF0000),
          errorSubtle: Color(0xFFFFCCCC),
        ),
        foregroundColors: const ForegroundColors(
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
        ),
        utilityColors: const UtilityColors(
          teal: Color(0xFF008080),
          blue: Color(0xFF0000FF),
          orange: Color(0xFFFF8000),
          pink: Color(0xFFFF69B4),
          purple: Color(0xFF800080),
          green: Color(0xFF008000),
          red: Color(0xFFFF0000),
          yellow: Color(0xFFFFFF00),
          indigo: Color(0xFF4B0082),
        ),
      );
    });

    testWidgets('title should return title style with primary text color', (tester) async {
      late TextStyle contextTitle;

      await tester.pumpWidget(
        MaterialApp(
          theme: testTheme.asThemeData(TargetPlatform.android),
          home: Builder(
            builder: (context) {
              contextTitle = context.title;
              return Container();
            },
          ),
        ),
      );

      expect(contextTitle.fontSize, AppStyles.title.fontSize);
      expect(contextTitle.fontWeight, AppStyles.title.fontWeight);
      expect(contextTitle.height, AppStyles.title.height);
      expect(contextTitle.color, const Color(0xFF123456)); // testTheme.textColors.primary
    });

    testWidgets('headline should return headline style with primary text color', (tester) async {
      late TextStyle contextHeadline;

      await tester.pumpWidget(
        MaterialApp(
          theme: testTheme.asThemeData(TargetPlatform.android),
          home: Builder(
            builder: (context) {
              contextHeadline = context.headline;
              return Container();
            },
          ),
        ),
      );

      expect(contextHeadline.fontSize, AppStyles.headline.fontSize);
      expect(contextHeadline.fontWeight, AppStyles.headline.fontWeight);
      expect(contextHeadline.height, AppStyles.headline.height);
      expect(contextHeadline.color, const Color(0xFF123456));
    });

    testWidgets('subHeadline should return subHeadline style with primary text color', (tester) async {
      late TextStyle contextSubHeadline;

      await tester.pumpWidget(
        MaterialApp(
          theme: testTheme.asThemeData(TargetPlatform.android),
          home: Builder(
            builder: (context) {
              contextSubHeadline = context.subHeadline;
              return Container();
            },
          ),
        ),
      );

      expect(contextSubHeadline.fontSize, AppStyles.subHeadline.fontSize);
      expect(contextSubHeadline.fontWeight, AppStyles.subHeadline.fontWeight);
      expect(contextSubHeadline.height, AppStyles.subHeadline.height);
      expect(contextSubHeadline.color, const Color(0xFF123456));
    });

    testWidgets('body should return body style with primary text color', (tester) async {
      late TextStyle contextBody;

      await tester.pumpWidget(
        MaterialApp(
          theme: testTheme.asThemeData(TargetPlatform.android),
          home: Builder(
            builder: (context) {
              contextBody = context.body;
              return Container();
            },
          ),
        ),
      );

      expect(contextBody.fontSize, AppStyles.body.fontSize);
      expect(contextBody.fontWeight, AppStyles.body.fontWeight);
      expect(contextBody.height, AppStyles.body.height);
      expect(contextBody.color, const Color(0xFF123456));
    });

    testWidgets('input should return input style with primary text color', (tester) async {
      late TextStyle contextInput;

      await tester.pumpWidget(
        MaterialApp(
          theme: testTheme.asThemeData(TargetPlatform.android),
          home: Builder(
            builder: (context) {
              contextInput = context.input;
              return Container();
            },
          ),
        ),
      );

      expect(contextInput.fontSize, AppStyles.input.fontSize);
      expect(contextInput.fontWeight, AppStyles.input.fontWeight);
      expect(contextInput.height, AppStyles.input.height);
      expect(contextInput.color, const Color(0xFF123456));
    });
  });
}

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
