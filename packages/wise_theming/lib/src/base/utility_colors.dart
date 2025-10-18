import 'dart:ui';

import '../colors/colors.dart';

/// Default implementation of [UtilityColors] for dark mode.
///
/// Provides a set of vibrant utility colors for special purposes like
/// badges, status indicators, and categorization in dark mode.
const UtilityColors darkUtilityColors = UtilityColors(
  teal: Color(0xFF2ED3B7),
  blue: Color(0xFF4A89FE),
  orange: Color(0xFFF38744),
  pink: Color(0xFFF670C7),
  purple: Color(0xFF9B8AFB),
  green: Color(0xFF4ADE80),
  indigo: Color(0xFF6366F1),
  red: Color(0xFFEF4444),
  yellow: Color(0xFFFBBF24),
);

/// Default implementation of [UtilityColors] for light mode.
///
/// Provides a set of vibrant utility colors for special purposes like
/// badges, status indicators, and categorization in light mode.
const UtilityColors lightUtilityColors = UtilityColors(
  teal: Color(0xFF2ED3B7),
  blue: Color(0xFF4A89FE),
  orange: Color(0xFFF38744),
  pink: Color(0xFFF670C7),
  purple: Color(0xFF9B8AFB),
  green: Color(0xFF4ADE80),
  indigo: Color(0xFF6366F1),
  red: Color(0xFFEF4444),
  yellow: Color(0xFFFBBF24),
);

/// High contrast implementation of [UtilityColors] for light mode.
///
/// Provides enhanced contrast utility colors for better accessibility in light mode,
/// using more vibrant and distinct colors for badges, status indicators, and categorization.
const UtilityColors highContrastLightUtilityColors = UtilityColors(
  teal: Color(0xFF059669),
  blue: Color(0xFF1D4ED8),
  orange: Color(0xFFEA580C),
  pink: Color(0xFFBE185D),
  purple: Color(0xFF7C3AED),
  green: Color(0xFF16A34A),
  indigo: Color(0xFF4338CA),
  red: Color(0xFFDC2626),
  yellow: Color(0xFFCA8A04),
);

/// High contrast implementation of [UtilityColors] for dark mode.
///
/// Provides enhanced contrast utility colors for better accessibility in dark mode,
/// using brighter and more distinct colors for badges, status indicators, and categorization.
const UtilityColors highContrastDarkUtilityColors = UtilityColors(
  teal: Color(0xFF14B8A6),
  blue: Color(0xFF3B82F6),
  orange: Color(0xFFF97316),
  pink: Color(0xFFEC4899),
  purple: Color(0xFF8B5CF6),
  green: Color(0xFF22C55E),
  indigo: Color(0xFF6366F1),
  red: Color(0xFFEF4444),
  yellow: Color(0xFFF59E0B),
);
