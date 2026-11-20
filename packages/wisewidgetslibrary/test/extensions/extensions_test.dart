import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:wisewidgetslibrary/src/extensions/hex_color_extension.dart';

void main() {
  test('ColorExtension hexString', () {
    const color = Color(0xFF123456);
    expect(color.hexString, 'ff123456');
  });
}
