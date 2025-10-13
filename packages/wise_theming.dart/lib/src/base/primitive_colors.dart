import 'package:flutter/material.dart';

/// A class that holds the primitive color palette.
///
/// This class is not meant to be instantiated. It provides a set of
/// static const MaterialColor objects based on the provided design system image.
/// The colors are grouped by their semantic meaning (brand, success, warning, etc.).
class PrimitiveColors {
  /// White color.
  static const Color white = Color(0xFFFFFFFF);

  /// Black color.
  static const Color black = Color(0xFF000000);

  /// Transparent color.
  /// The image specifies #1F1F1F at 0% opacity.
  static const Color transparent = Color(0x001F1F1F);

  // -------------------
  //      GRAY (Light Mode)
  // -------------------
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

  // -------------------
  //      GRAY (Dark Mode)
  // -------------------
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

  // -------------------
  //      BRAND
  // -------------------
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

  // -------------------
  //      ERROR
  // -------------------
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

  // -------------------
  //      WARNING
  // -------------------
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

  // -------------------
  //      SUCCESS
  // -------------------
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

  // -------------------
  //      YELLOW
  // -------------------
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

extension HexColor on Color {
  /// String in format #RRGGBB or #AARRGGBB
  static Color fromString(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
