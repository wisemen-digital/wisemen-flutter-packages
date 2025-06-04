import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/src/models/models.dart';

class TestPagedError extends PagedError {
  TestPagedError({
    required super.message,
    super.title,
    super.lastTimeFetched,
    this.body = 'Default Sheet Body',
  });

  final String body;

  @override
  String get sheetBody => body;
}

class WrongTestPagedError extends PagedError {
  WrongTestPagedError({
    super.message = 'Test',
    super.title,
    super.lastTimeFetched,
  });
}

void main() {
  group('PagedError', () {
    test('should store message, title, and lastTimeFetched', () {
      final now = DateTime.now();
      final error = TestPagedError(
        message: 'An error occurred',
        title: 'Error',
        lastTimeFetched: now,
      );

      expect(error.message, 'An error occurred');
      expect(error.title, 'Error');
      expect(error.lastTimeFetched, now);
    });

    test('should allow overriding sheetBody', () {
      final error = TestPagedError(message: 'Error', body: 'Custom Sheet Body');

      expect(error.sheetBody, 'Custom Sheet Body');
    });

    test('should throw UnimplementedError for sheetBody getter', () {
      expect(() => WrongTestPagedError().sheetBody, throwsUnimplementedError);
    });
  });
}
