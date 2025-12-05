import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ultra_playground/features/shared/utils/app_constants.dart';

void main() {
  test('AppConstants.fakerMode returns bool', () {
    expect(AppConstants.fakerMode, isA<bool>());
  });

  test('AppConstants.faker returns an instance of Faker', () {
    expect(AppConstants.faker, isA<Faker>());
  });

  test('AppConstants.getSimpleStringId returns a string of a number < 5', () {
    final result = AppConstants.getSimpleStringId();
    expect(result, isA<String>());
    expect((int.tryParse(result) ?? 8) < 5, isTrue);
  });
}
