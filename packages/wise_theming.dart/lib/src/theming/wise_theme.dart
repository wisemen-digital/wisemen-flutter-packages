import 'theming.dart';

class WiseTheme {
  WiseTheme({
    required this.identifier,
    required this.lightColors,
    required this.darkColors,
  });

  final String identifier;
  final WiseBrightness lightColors;
  final WiseBrightness darkColors;
}
