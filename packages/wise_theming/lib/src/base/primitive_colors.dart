import 'package:flutter/material.dart';

/// A class that holds the primitive color palette used throughout wise_theming.
///
/// This class provides a comprehensive set of color swatches with multiple shades
/// (25, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950) for consistent
/// color usage across the application.
///
/// **This class is not meant to be instantiated.** All colors are provided as
/// static properties.
///
/// The colors are organized into categories:
/// - **Base colors**: [white], [black], [transparent]
/// - **Neutral colors**: [gray] (for light mode), [grayDark] (for dark mode)
/// - **Semantic colors**: [brand], [error], [warning], [success], [yellow]
///
/// Each color swatch uses a scale from 25 (lightest) to 950 (darkest), with
/// 500 typically representing the primary color value.
///
/// Example usage:
/// ```dart
/// // Using gray scale
/// Container(color: PrimitiveColors.gray[300])
///
/// // Using brand colors
/// Container(color: PrimitiveColors.brand[500])
///
/// // Using semantic colors
/// Container(color: PrimitiveColors.success[600])
/// ```
class PrimitiveColors {
  /// Pure white color (#FFFFFF).
  static const Color white = Color(0xFFFFFFFF);

  /// Pure black color (#000000).
  static const Color black = Color(0xFF000000);

  /// Fully transparent color.
  static const Color transparent = Color(0x001F1F1F);

  /// Gray color scale optimized for light mode backgrounds.
  ///
  /// This swatch provides neutral gray tones that work well on light backgrounds.
  /// Available shades: 25, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950.
  ///
  /// Typical usage:
  /// - 25-100: Very light grays for subtle backgrounds
  /// - 200-400: Light to medium grays for borders and disabled states
  /// - 500-700: Medium to dark grays for secondary text and icons
  /// - 800-950: Very dark grays for primary text and emphasis
  static final MaterialColor gray = MaterialColor(
    0xFF697586, // 500
    <int, Color>{
      25: HexColor.fromString('#FCFCFD'),
      50: HexColor.fromString('#F8FAFC'),
      100: HexColor.fromString('#EEF2F6'),
      200: HexColor.fromString('#E3E8EF'),
      300: HexColor.fromString('#CDD5DF'),
      400: HexColor.fromString('#9AA4B2'),
      500: HexColor.fromString('#697586'),
      600: HexColor.fromString('#4B5565'),
      700: HexColor.fromString('#364152'),
      800: HexColor.fromString('#202939'),
      900: HexColor.fromString('#121926'),
      950: HexColor.fromString('#0D121C'),
    },
  );

  /// Gray color scale optimized for dark mode backgrounds.
  ///
  /// This swatch provides neutral gray tones that work well on dark backgrounds.
  /// Available shades: 25, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950.
  ///
  /// Typical usage:
  /// - 25-100: Very light grays for text and high-contrast elements
  /// - 200-400: Light to medium grays for secondary text and borders
  /// - 500-700: Medium grays for disabled states and subtle elements
  /// - 800-950: Very dark grays for backgrounds and surfaces
  static final MaterialColor grayDark = MaterialColor(
    0xFF9E9E9E, // 500
    <int, Color>{
      25: HexColor.fromString('#FAFAFA'),
      50: HexColor.fromString('#F7F7F7'),
      100: HexColor.fromString('#F0F0F1'),
      200: HexColor.fromString('#ECECED'),
      300: HexColor.fromString('#CECFD2'),
      400: HexColor.fromString('#94979C'),
      500: HexColor.fromString('#85888E'),
      600: HexColor.fromString('#61656C'),
      700: HexColor.fromString('#373A41'),
      800: HexColor.fromString('#22262F'),
      900: HexColor.fromString('#13161B'),
      950: HexColor.fromString('#0C0E12'),
    },
  );

  /// Brand color scale for primary brand identity.
  ///
  /// This swatch contains the primary brand colors for your application.
  /// Available shades: 25, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950.
  ///
  /// The default brand color is blue. Override this by creating your own
  /// color implementations.
  ///
  /// Typical usage:
  /// - 25-100: Very light brand colors for backgrounds and subtle highlights
  /// - 400-600: Primary brand colors for buttons and call-to-action elements
  /// - 700-950: Dark brand colors for hover states and emphasis
  static final ColorSwatch<int> brand = ColorSwatch<int>(
    0xFF0B68FE, // 500
    <int, Color>{
      25: HexColor.fromString('#F5F8FF'),
      50: HexColor.fromString('#F0F5FF'),
      100: HexColor.fromString('#D0E1FF'),
      200: HexColor.fromString('#A9C7FF'),
      300: HexColor.fromString('#7AA9FE'),
      400: HexColor.fromString('#4A89FE'),
      500: HexColor.fromString('#0B68FE'),
      600: HexColor.fromString('#0146C6'),
      700: HexColor.fromString('#01328E'),
      800: HexColor.fromString('#002260'),
      900: HexColor.fromString('#00153D'),
      950: HexColor.fromString('#00071A'),
    },
  );

  /// Error color scale for error states and destructive actions.
  ///
  /// This swatch contains red-toned colors for indicating errors, failures,
  /// and destructive actions.
  /// Available shades: 25, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950.
  ///
  /// Typical usage:
  /// - 25-100: Very light reds for error message backgrounds
  /// - 500-600: Primary error colors for text and icons
  /// - 700-950: Dark error colors for emphasis and borders
  static final MaterialColor error = MaterialColor(
    0xFFDD4B50, // 500
    <int, Color>{
      25: HexColor.fromString('#FCEDEE'),
      50: HexColor.fromString('#F8DBDC'),
      100: HexColor.fromString('#F5C9CB'),
      200: HexColor.fromString('#F1B7B9'),
      300: HexColor.fromString('#EB9396'),
      400: HexColor.fromString('#E46F73'),
      500: HexColor.fromString('#DD4B50'),
      600: HexColor.fromString('#B13C40'),
      700: HexColor.fromString('#852D30'),
      800: HexColor.fromString('#581E20'),
      900: HexColor.fromString('#2C0F10'),
      950: HexColor.fromString('#160808'),
    },
  );

  /// Warning color scale for warning states and caution messages.
  ///
  /// This swatch contains orange-toned colors for indicating warnings,
  /// caution states, and important notices.
  /// Available shades: 25, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950.
  ///
  /// Typical usage:
  /// - 25-100: Very light oranges for warning message backgrounds
  /// - 500-600: Primary warning colors for text and icons
  /// - 700-950: Dark warning colors for emphasis
  static final MaterialColor warning = MaterialColor(
    0xFFF08C42, // 500
    <int, Color>{
      25: HexColor.fromString('#FEF4EC'),
      50: HexColor.fromString('#FCE8D9'),
      100: HexColor.fromString('#FBDDC6'),
      200: HexColor.fromString('#F9D1B3'),
      300: HexColor.fromString('#F6BA8E'),
      400: HexColor.fromString('#F3A368'),
      500: HexColor.fromString('#F08C42'),
      600: HexColor.fromString('#C47235'),
      700: HexColor.fromString('#985828'),
      800: HexColor.fromString('#6B3D1B'),
      900: HexColor.fromString('#3F230E'),
      950: HexColor.fromString('#291608'),
    },
  );

  /// Success color scale for success states and positive feedback.
  ///
  /// This swatch contains green-toned colors for indicating success,
  /// completion, and positive states.
  /// Available shades: 25, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950.
  ///
  /// Typical usage:
  /// - 25-100: Very light greens for success message backgrounds
  /// - 500-600: Primary success colors for text and icons
  /// - 700-950: Dark success colors for emphasis
  static final MaterialColor success = MaterialColor(
    0xFF17B26A, // 500
    <int, Color>{
      25: HexColor.fromString('#F6FEF9'),
      50: HexColor.fromString('#ECFDF3'),
      100: HexColor.fromString('#DCFAE6'),
      200: HexColor.fromString('#A9EFC5'),
      300: HexColor.fromString('#75E0A7'),
      400: HexColor.fromString('#47CD89'),
      500: HexColor.fromString('#17B26A'),
      600: HexColor.fromString('#079455'),
      700: HexColor.fromString('#067647'),
      800: HexColor.fromString('#085D3A'),
      900: HexColor.fromString('#074D31'),
      950: HexColor.fromString('#053321'),
    },
  );

  /// Yellow color scale for highlights and attention-grabbing elements.
  ///
  /// This swatch contains yellow-toned colors for highlighting information,
  /// drawing attention, and special states.
  /// Available shades: 25, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950.
  ///
  /// Typical usage:
  /// - 25-100: Very light yellows for subtle highlights
  /// - 400-600: Primary yellow colors for badges and notifications
  /// - 700-950: Dark yellows for text on light backgrounds
  static final MaterialColor yellow = MaterialColor(
    0xFFF6B93B, // 500
    <int, Color>{
      25: HexColor.fromString('#FEFAEE'),
      50: HexColor.fromString('#FDF4DC'),
      100: HexColor.fromString('#FDEFCB'),
      200: HexColor.fromString('#FCE9B9'),
      300: HexColor.fromString('#FADE97'),
      400: HexColor.fromString('#F9D374'),
      500: HexColor.fromString('#F7C851'),
      600: HexColor.fromString('#CCA441'),
      700: HexColor.fromString('#A18131'),
      800: HexColor.fromString('#755D21'),
      900: HexColor.fromString('#4A3A11'),
      950: HexColor.fromString('#352809'),
    },
  );
}

/// Extension on [Color] for parsing hexadecimal color strings.
///
/// This extension provides a utility method to create [Color] objects from
/// hex color strings commonly used in design systems.
extension HexColor on Color {
  /// Creates a [Color] from a hexadecimal string.
  ///
  /// Supports two formats:
  /// - `#RRGGBB` - 6 characters (RGB), alpha defaults to FF (fully opaque)
  /// - `#AARRGGBB` - 8 characters (ARGB), includes alpha channel
  ///
  /// The `#` prefix is optional and will be removed if present.
  ///
  /// Example:
  /// ```dart
  /// final red = HexColor.fromString('#FF0000');
  /// final semiTransparentBlue = HexColor.fromString('#8000FF00');
  /// ```
  static Color fromString(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
