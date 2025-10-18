import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'colors/colors.dart';
import 'styles/styles.dart';
import 'theming/theming.dart';

/// A theming system for Flutter applications that provides comprehensive theme management
/// with support for multiple themes and light/dark mode.
///
/// This class manages theme initialization and switching, providing Material and Cupertino
/// themes that are synchronized with the current theme's color scheme.
///
/// Example:
/// ```dart
/// final theming = WiseTheming(
///   supportedThemes: [myCustomTheme, myCustomHighContrastTheme],
///   targetPlatform: TargetPlatform.fuchsia,
///   selectedTheme: myCustomTheme,
/// );
///
/// Use in MaterialApp
/// MaterialApp(
///   themeMode: value.themeMode,
///   theme: theming.lightTheme,
///   darkTheme: theming.darkTheme,
///   ...
/// );
/// ```
class WiseTheming extends ValueNotifier<WiseTheme?> {
  /// [WiseTheming] constructor
  WiseTheming({
    required this.supportedThemes,
    required this.targetPlatform,
    WiseTheme? selectedTheme,
  })  : assert(supportedThemes.isNotEmpty, 'supportedThemes cannot be empty'),
        super(selectedTheme);

  /// The list of all themes supported by the application.
  final List<WiseTheme> supportedThemes;

  /// A [TargetPlatform] to determine platform-specific theming in [ThemeData].
  final TargetPlatform targetPlatform;

  /// Changes the current active theme to the one matching the provided identifier.
  /// Only sets theme in current sessions's cache
  /// Remember to store this result in persistent storage if you want to keep the theme after app restart.
  @useResult
  WiseTheme setCurrentTheme(String themeIdentifier) {
    final newTheme = supportedThemes.firstWhere(
      (theme) => theme.identifier == themeIdentifier,
      orElse: () => throw ArgumentError(
          'No theme found with identifier: $themeIdentifier'),
    );
    value = newTheme;
    notifyListeners();
    return newTheme;
  }

  /// Convenience getter to set [MaterialApp]'s `theme` parameter.
  ThemeData? get lightTheme =>
      _getThemeByType(WiseThemeType.light)?.asThemeData(targetPlatform);

  /// Convenience getter to set [MaterialApp]'s `darkTheme` parameter.
  ThemeData? get darkTheme =>
      _getThemeByType(WiseThemeType.dark)?.asThemeData(targetPlatform);

  /// Convenience getter to set [MaterialApp]'s `highContrastTheme` parameter for high contrast.
  ThemeData? get lightContrastTheme =>
      _getThemeByType(WiseThemeType.lightContrast)?.asThemeData(targetPlatform);

  /// Convenience getter to set [MaterialApp]'s `highContrastDarkTheme` parameter for high contrast dark mode.
  ThemeData? get darkContrastTheme =>
      _getThemeByType(WiseThemeType.darkContrast)?.asThemeData(targetPlatform);

  /// Convenience getter to set [MaterialApp]'s `themeMode` parameter.
  ThemeMode? get themeMode => value?.themeType.themeMode;

  WiseTheme? _getThemeByType(WiseThemeType type) {
    if (value != null) return value;
    for (final element in supportedThemes) {
      if (element.themeType == type) return element;
    }
    return null;
  }
}

/// Extension on [BuildContext] providing access to [WiseTheme] and its color schemes.
///
/// This extension automatically selects the appropriate color set
/// based on the current theme and accessibility settings. Each getter returns a type-specific
/// color collection that adapts to the current theme mode.
///
/// Example:
/// ```dart
/// Container(
///   color: context.bgColor.primary,
///   child: Text(
///     'Hello',
///     style: context.title,
///   ),
/// )
/// ```
extension WiseThemeExtension on BuildContext {
  /// [BuildContext] accessor shortcut for [WiseTheme].
  WiseTheme get wiseTheme {
    assert(
      Theme.of(this).extension<WiseTheme>() != null,
      'No WiseTheme found in context. Make sure to add WiseTheme to your ThemeData extensions or use the WiseApp widget.',
    );
    return Theme.of(this).extension<WiseTheme>()!;
  }

  /// [BuildContext] accessor shortcut for [BackgroundColors] in [WiseTheme].
  BackgroundColors get backgroundColors => wiseTheme.backgroundColors;

  /// [BuildContext] accessor shortcut for [BorderColors] in [WiseTheme].
  BorderColors get borderColors => wiseTheme.borderColors;

  /// [BuildContext] accessor shortcut for [ForegroundColors] in [WiseTheme].
  ForegroundColors get foregroundColors => wiseTheme.foregroundColors;

  /// [BuildContext] accessor shortcut for [TextColors] in [WiseTheme].
  TextColors get textColors => wiseTheme.textColors;

  /// [BuildContext] accessor shortcut for [UtilityColors] in [WiseTheme].
  UtilityColors get utilityColors => wiseTheme.utilityColors;

  /// Returns the current [Brightness] (light or dark mode) from the color scheme.
  Brightness get brightness => wiseTheme.themeType.brightness;
}

/// Extension on [BuildContext] providing convenient access to pre-styled text styles.
///
/// This extension provides quick access to common text styles with appropriate colors
/// automatically applied based on the current theme brightness.
///
/// Example:
/// ```dart
/// Text('Title', style: context.title)
/// Text('Body text', style: context.body)
/// Text('Label', style: context.headline)
/// ```
extension TextStyleExtension on BuildContext {
  /// Returns the title text style with appropriate color for the current theme.
  TextStyle get title => AppStyles.title.copyWith(color: textColors.primary);

  /// Returns the headline text style with appropriate color for the current theme.
  TextStyle get headline =>
      AppStyles.headline.copyWith(color: textColors.primary);

  /// Returns the sub-headline text style with appropriate color for the current theme.
  TextStyle get subHeadline =>
      AppStyles.subHeadline.copyWith(color: textColors.primary);

  /// Returns the body text style with appropriate color for the current theme.
  TextStyle get body => AppStyles.body.copyWith(color: textColors.primary);

  /// Returns the input text style with appropriate color for the current theme.
  TextStyle get input => AppStyles.input.copyWith(color: textColors.primary);
}
