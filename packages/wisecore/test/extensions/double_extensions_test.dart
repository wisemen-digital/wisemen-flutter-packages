import 'package:flutter_test/flutter_test.dart';
import 'package:wisecore/src/extensions/double_extensions.dart';

void main() {
  group('DoubleExtensions', () {
    test('toRadians should convert degrees to radians', () {
      expect(0.0.toRadians(), equals(0.0));
      expect(90.0.toRadians(), closeTo(1.5708, 0.0001));
      expect(180.0.toRadians(), closeTo(3.1416, 0.0001));
      expect(360.0.toRadians(), closeTo(6.2832, 0.0001));
    });
  });
}