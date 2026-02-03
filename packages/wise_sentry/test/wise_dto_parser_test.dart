import 'package:flutter_test/flutter_test.dart';
import 'package:wise_sentry/wise_sentry.dart';

void main() {
  group('WiseDTOParser', () {
    test('wraps exceptions as DTOException', () {
      expect(
        () => WiseDTOParser.parse(
          () => throw FormatException('Bad date'),
          json: {'date': 'invalid'},
          mapper: 'MyDto.fromJson',
        ),
        throwsA(isA<DTOException>()),
      );
    });

    test('preserves original exception in DTOException', () {
      try {
        WiseDTOParser.parse(
          () => throw FormatException('Bad date'),
          json: {'date': 'invalid'},
          mapper: 'MyDto.fromJson',
        );
        fail('Should have thrown');
      } on DTOException catch (e) {
        expect(e.originalError, isA<FormatException>());
        expect((e.originalError as FormatException).message, 'Bad date');
      }
    });

    test('includes mapper name and json in extras', () {
      try {
        WiseDTOParser.parse(
          () => throw FormatException('Bad date'),
          json: {'date': 'invalid'},
          mapper: 'MyDto.fromJson',
        );
        fail('Should have thrown');
      } on DTOException catch (e) {
        expect(e.extras?['mapper'], 'MyDto.fromJson');
        expect(e.extras?['json'], contains('invalid'));
        expect(e.extras?['errorType'], 'FormatException');
        expect(e.extras?['context'], 'DTO parsing');
      }
    });

    test('preserves original stack trace location', () {
      try {
        WiseDTOParser.parse(
          () => _throwFromKnownLocation(), // Line 52
          mapper: 'TestDto.fromJson',
        );
        fail('Should have thrown');
      } on DTOException catch (e, stack) {
        // Verify the stack trace points to the original error location
        // not to the WiseDTOParser.parse wrapper
        final stackString = stack.toString();

        // Should contain the original throw location
        expect(stackString, contains('_throwFromKnownLocation'));

        // The first frame should be the original error, not the wrapper
        final frames = stackString.split('\n');
        expect(
          frames.first,
          contains('_throwFromKnownLocation'),
          reason: 'First stack frame should be original error location',
        );
      }
    });

    test('includes FormatException offset in extras', () {
      try {
        WiseDTOParser.parse(
          () => throw FormatException('Bad format', 'source', 10),
          mapper: 'MyDto.fromJson',
        );
        fail('Should have thrown');
      } on DTOException catch (e) {
        expect(e.extras?['offset'], 10);
        expect(e.extras?['source'], 'source');
      }
    });

    test('truncates large JSON payloads', () {
      final largeJson = {'data': 'x' * 2000};

      try {
        WiseDTOParser.parse(
          () => throw FormatException('error'),
          json: largeJson,
        );
        fail('Should have thrown');
      } on DTOException catch (e) {
        final jsonString = e.extras?['json'] as String;
        expect(jsonString.length, lessThan(1200)); // Should be truncated
        expect(jsonString, contains('TRUNCATED'));
      }
    });

    test('message includes mapper name', () {
      try {
        WiseDTOParser.parse(
          () => throw TypeError(),
          mapper: 'UserDto.fromJson',
        );
        fail('Should have thrown');
      } on DTOException catch (e) {
        expect(e.message, contains('UserDto.fromJson'));
        expect(e.message, contains('DTO parsing failed'));
      }
    });
  });
}

// Helper function at a known line for stack trace testing
String _throwFromKnownLocation() {
  throw FormatException('Test error from known location');
}
