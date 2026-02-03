import 'package:flutter_test/flutter_test.dart';
import 'package:wise_sentry/wise_sentry.dart';

void main() {
  group('WiseUIErrorParser', () {
    test('wraps exceptions as UIException', () {
      expect(
        () => WiseUIErrorParser.parse(
          () => throw Exception('Widget build failed'),
          context: {'widgetName': 'UserCard'},
          location: 'user_card_widget.dart',
        ),
        throwsA(isA<UIException>()),
      );
    });

    test('preserves original exception in UIException', () {
      try {
        WiseUIErrorParser.parse(
          () => throw StateError('Invalid widget state'),
          context: {'widgetName': 'LoginForm'},
          location: 'login_form_widget.dart',
        );
        fail('Should have thrown');
      } on UIException catch (e) {
        expect(e.originalError, isA<StateError>());
        expect((e.originalError as StateError).message, 'Invalid widget state');
      }
    });

    test('includes location and context in extras', () {
      try {
        WiseUIErrorParser.parse(
          () => throw RangeError('Index out of bounds'),
          context: {'listLength': 5, 'index': 10},
          location: 'list_view_widget.dart',
        );
        fail('Should have thrown');
      } on UIException catch (e) {
        expect(e.extras?['location'], 'list_view_widget.dart');
        expect(e.extras?['context'], contains('5'));
        expect(e.extras?['errorType'], 'RangeError');
        expect(e.extras?['context_type'], 'UI');
      }
    });

    test('preserves original stack trace location', () {
      try {
        WiseUIErrorParser.parse(
          () => _throwFromKnownLocation(),
          location: 'test_widget.dart',
        );
        fail('Should have thrown');
      } on UIException catch (e, stack) {
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

    test('message includes location', () {
      try {
        WiseUIErrorParser.parse(
          () => throw Exception('error'),
          location: 'profile_widget.dart',
        );
        fail('Should have thrown');
      } on UIException catch (e) {
        expect(e.message, contains('profile_widget.dart'));
        expect(e.message, contains('UI error'));
      }
    });

    test('handles exceptions without optional parameters', () {
      try {
        WiseUIErrorParser.parse(
          () => throw FormatException('Bad format'),
        );
        fail('Should have thrown');
      } on UIException catch (e) {
        expect(e.extras?['errorType'], 'FormatException');
        expect(e.extras?['context_type'], 'UI');
        expect(e.extras?.containsKey('location'), false);
        expect(e.extras?.containsKey('context'), false);
      }
    });

    test('wraps both Exception and Error types', () {
      // Test Exception
      try {
        WiseUIErrorParser.parse(
          () => throw Exception('exception'),
          location: 'test.dart',
        );
        fail('Should have thrown');
      } on UIException catch (e) {
        expect(e.originalError, isA<Exception>());
      }

      // Test Error
      try {
        WiseUIErrorParser.parse(
          () => throw AssertionError('assertion failed'),
          location: 'test.dart',
        );
        fail('Should have thrown');
      } on UIException catch (e) {
        expect(e.originalError, isA<AssertionError>());
      }
    });

    test('handles null pointer exceptions', () {
      try {
        WiseUIErrorParser.parse(
          () => throw TypeError(),
          context: {'operation': 'render'},
          location: 'custom_painter.dart',
        );
        fail('Should have thrown');
      } on UIException catch (e) {
        expect(e.originalError, isA<TypeError>());
        expect(e.extras?['location'], 'custom_painter.dart');
      }
    });
  });
}

// Helper function at a known line for stack trace testing
void _throwFromKnownLocation() {
  throw Exception('Test error from known location');
}
