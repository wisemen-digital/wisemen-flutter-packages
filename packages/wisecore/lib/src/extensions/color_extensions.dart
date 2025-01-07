import 'dart:ui';

/// Extensions on [Color] type
extension ColorExtensions on Color {
  /// Converts a hex string to a [Color] object
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Converts a [Color] to [ColorFilter] (mostly used for SvgPicture)
  ColorFilter colorFiltered({BlendMode blendMode = BlendMode.srcIn}) {
    return ColorFilter.mode(this, blendMode);
  }
}
