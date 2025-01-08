import 'dart:ui';

/// Extension to get hex color from String
extension ColorExtension on Color {
  /// Convert a color to a hex string
  // ignore: deprecated_member_use
  String get hexString => value.toRadixString(16);
}
