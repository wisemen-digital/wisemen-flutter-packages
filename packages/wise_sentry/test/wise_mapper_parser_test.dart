import 'package:flutter_test/flutter_test.dart';
import 'package:wise_sentry/wise_sentry.dart';

void main() {
  group('WiseMapperParser', () {
    test('wraps exceptions as MapperException', () {
      expect(
        () => WiseMapperParser.parse(
          () => throw StateError('Invalid state'),
          json: {'id': 1},
          mapper: 'MyMapper.toModel',
        ),
        throwsA(isA<MapperException>()),
      );
    });

    test('preserves original exception in MapperException', () {
      try {
        WiseMapperParser.parse(
          () => throw StateError('Invalid state'),
          json: {'id': 1},
          mapper: 'MyMapper.toModel',
        );
        fail('Should have thrown');
      } on MapperException catch (e) {
        expect(e.originalError, isA<StateError>());
        expect((e.originalError as StateError).message, 'Invalid state');
      }
    });

    test('includes mapper name, json, and value in extras', () {
      try {
        WiseMapperParser.parse(
          () => throw RangeError('Out of range'),
          json: {'id': 1},
          mapper: 'UserMapper.toModel',
          value: 'test-value',
        );
        fail('Should have thrown');
      } on MapperException catch (e) {
        expect(e.extras?['mapper'], 'UserMapper.toModel');
        expect(e.extras?['json'], contains('1'));
        expect(e.extras?['value'], 'test-value');
        expect(e.extras?['errorType'], 'RangeError');
        expect(e.extras?['context'], 'Mapper');
      }
    });

    test('preserves original stack trace location', () {
      try {
        WiseMapperParser.parse(
          () => _throwFromKnownLocation(),
          mapper: 'TestMapper.toModel',
        );
        fail('Should have thrown');
      } on MapperException catch (e, stack) {
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

    test('truncates large JSON payloads', () {
      final largeJson = {'data': 'x' * 2000};

      try {
        WiseMapperParser.parse(
          () => throw ArgumentError('error'),
          json: largeJson,
        );
        fail('Should have thrown');
      } on MapperException catch (e) {
        final jsonString = e.extras?['json'] as String;
        expect(jsonString.length, lessThan(1200));
        expect(jsonString, contains('TRUNCATED'));
      }
    });

    test('message includes mapper name', () {
      try {
        WiseMapperParser.parse(
          () => throw StateError('error'),
          mapper: 'UserMapper.toModel',
        );
        fail('Should have thrown');
      } on MapperException catch (e) {
        expect(e.message, contains('UserMapper.toModel'));
        expect(e.message, contains('Mapper error'));
      }
    });

    test('handles exceptions without optional parameters', () {
      try {
        WiseMapperParser.parse(
          () => throw ArgumentError('No extras'),
        );
        fail('Should have thrown');
      } on MapperException catch (e) {
        expect(e.extras?['errorType'], 'ArgumentError');
        expect(e.extras?['context'], 'Mapper');
        expect(e.extras?.containsKey('mapper'), false);
        expect(e.extras?.containsKey('json'), false);
        expect(e.extras?.containsKey('value'), false);
      }
    });
  });
}

// Helper function at a known line for stack trace testing
void _throwFromKnownLocation() {
  throw StateError('Test error from known location');
}
