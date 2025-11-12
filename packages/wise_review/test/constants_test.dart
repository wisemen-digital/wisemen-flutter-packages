import 'package:flutter_test/flutter_test.dart';
import 'package:wise_review/src/constants/constants.dart';

void main() {
  group('Constants', () {
    test('appOpenCount returns correct key', () {
      expect(Constants.appOpenCount, 'app_open_count');
    });

    test('appOpenCount is consistent across calls', () {
      final firstCall = Constants.appOpenCount;
      final secondCall = Constants.appOpenCount;
      
      expect(firstCall, secondCall);
    });

    test('appOpenCount is a non-empty string', () {
      expect(Constants.appOpenCount, isNotEmpty);
      expect(Constants.appOpenCount, isA<String>());
    });
  });
}
