import 'package:flutter/widgets.dart';

import 'extensions.dart';

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

  /// Changes the opacity of a [Color] by a given value between 0 and 1
  Color changeOpacity(double value) {
    return withAlpha(value.opacityToAlpha());
  }

  /// Darkens the color proportionally toward black.
  /// [amount] ranges from 0.0 (no change) to 1.0 (completely black).
  Color darken({required double amount}) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0.0 and 1.0');
    final hsl = HSLColor.fromColor(this);
    final darkened = hsl.withLightness(hsl.lightness * (1 - amount));
    return darkened.toColor();
  }

  /// Lightens the color proportionally toward white.
  /// [amount] ranges from 0.0 (no change) to 1.0 (completely white).
  Color lighten({required double amount}) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0.0 and 1.0');
    final hsl = HSLColor.fromColor(this);
    final lightened =
        hsl.withLightness(hsl.lightness + (1 - hsl.lightness) * amount);
    return lightened.toColor();
  }
}
