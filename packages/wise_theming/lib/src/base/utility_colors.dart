import 'dart:ui';

import '../colors/colors.dart';
import 'primitive_colors.dart';

/// Default implementation of [UtilityColors] for dark mode.
///
/// Provides a set of vibrant utility colors for special purposes like
/// badges, status indicators, and categorization in dark mode.
class DarkUtilityColors implements UtilityColors {
  @override
  Color get teal => HexColor.fromString('#2ED3B7');

  @override
  Color get blue => HexColor.fromString('#4A89FE');

  @override
  Color get orange => HexColor.fromString('#F38744');

  @override
  Color get pink => HexColor.fromString('#F670C7');

  @override
  Color get purple => HexColor.fromString('#9B8AFB');

  @override
  Color get green => HexColor.fromString('#4ADE80');

  @override
  Color get indigo => HexColor.fromString('#6366F1');

  @override
  Color get red => HexColor.fromString('#EF4444');

  @override
  Color get yellow => HexColor.fromString('#FBBF24');
}

/// Default implementation of [UtilityColors] for light mode.
///
/// Provides a set of vibrant utility colors for special purposes like
/// badges, status indicators, and categorization in light mode.
class LightUtilityColors implements UtilityColors {
  @override
  Color get teal => HexColor.fromString('#2ED3B7');

  @override
  Color get blue => HexColor.fromString('#4A89FE');

  @override
  Color get orange => HexColor.fromString('#F38744');

  @override
  Color get pink => HexColor.fromString('#F670C7');

  @override
  Color get purple => HexColor.fromString('#9B8AFB');

  @override
  Color get green => HexColor.fromString('#4ADE80');

  @override
  Color get indigo => HexColor.fromString('#6366F1');

  @override
  Color get red => HexColor.fromString('#EF4444');

  @override
  Color get yellow => HexColor.fromString('#FBBF24');
}
