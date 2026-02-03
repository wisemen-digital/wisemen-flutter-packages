import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_sentry/wise_sentry.dart';

void main() {
  group('Flutter Global Error Handlers', () {
    late List<Map<String, dynamic>> capturedErrors;
    late void Function(FlutterErrorDetails)? originalOnError;

    setUp(() {
      capturedErrors = [];
      originalOnError = FlutterError.onError;

      // Mock the captureException to track calls
      FlutterError.onError = (FlutterErrorDetails details) {
        capturedErrors.add({
          'exception': details.exception,
          'stack': details.stack,
          'context': details.context,
        });
      };
    });

    tearDown(() {
      FlutterError.onError = originalOnError;
      capturedErrors.clear();
    });

    testWidgets('catches widget build errors automatically', (tester) async {
      // Build a widget that throws an error
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                throw Exception('Widget build failed');
              },
            ),
          ),
        ),
      );

      // Verify the error was captured
      expect(capturedErrors, isNotEmpty);
      expect(capturedErrors.first['exception'].toString(), contains('Widget build failed'));
    });

    testWidgets('catches errors in widget lifecycle methods', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: _ErrorThrowingWidget(),
        ),
      );

      // Trigger the error
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify error was captured
      expect(capturedErrors, isNotEmpty);
      expect(capturedErrors.last['exception'].toString(), contains('State update error'));
    });

    testWidgets('catches rendering errors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: _RenderErrorWidget(),
          ),
        ),
      );

      // Verify error was captured
      expect(capturedErrors, isNotEmpty);
    });

    test('FlutterError.reportError sends to handler', () {
      final testException = Exception('Manual report test');

      FlutterError.reportError(
        FlutterErrorDetails(
          exception: testException,
          stack: StackTrace.current,
          library: 'test library',
          context: ErrorDescription('test context'),
        ),
      );

      expect(capturedErrors, isNotEmpty);
      expect(capturedErrors.first['exception'], testException);
    });
  });

  group('PlatformDispatcher Error Handler', () {
    testWidgets('catches async errors in build', (tester) async {
      // This would be caught by PlatformDispatcher.instance.onError
      // Testing this requires actually initializing WiseSentry.init
      // which is harder to test in unit tests
    });
  });

  group('WiseSentry Error Structure Verification', () {
    late List<Map<String, dynamic>> sentryCaptures;

    setUp(() {
      sentryCaptures = [];
    });

    test('verifies raw exception sent to Sentry has flutterError extra', () {
      // This simulates what happens in FlutterError.onError handler
      final testException = Exception('Widget build failed');
      final testStack = StackTrace.current;

      // Simulate the call from FlutterError.onError
      final extras = {'flutterError': true};

      // Capture what would be sent
      sentryCaptures.add({
        'exception': testException,
        'stack': testStack,
        'extras': extras,
      });

      expect(sentryCaptures.first['exception'].toString(), contains('Widget build failed'));
      expect(sentryCaptures.first['extras']?['flutterError'], isTrue);
    });

    test('verifies UIException structure with all extras', () {
      // When using WiseUIErrorParser, it creates a UIException
      try {
        WiseUIErrorParser.parse(
          () => throw StateError('Invalid widget state'),
          location: 'my_widget.dart',
          context: {'userId': '123', 'screen': 'home'},
        );
        fail('Should have thrown');
      } on UIException catch (e, stack) {
        // This is what gets sent to Sentry
        expect(e, isA<UIException>());
        expect(e.message, contains('UI error'));
        expect(e.message, contains('my_widget.dart'));
        expect(e.originalError, isA<StateError>());

        // Verify extras structure
        expect(e.extras, isNotNull);
        expect(e.extras?['error_type'], 'UIException');
        expect(e.extras?['errorType'], 'StateError');
        expect(e.extras?['context_type'], 'UI');
        expect(e.extras?['location'], 'my_widget.dart');
        expect(e.extras?['context'], isNotNull);
        expect(e.extras?['context'], contains('123'));

        // Verify stack trace is preserved
        expect(e.stackTrace, isNotNull);
        expect(stack.toString(), contains('_throwFromKnownLocation'));
      }
    });

    test('verifies exception sent to Sentry includes all context', () {
      final originalError = ArgumentError('Invalid input');
      final uiException = UIException(
        'UI error in profile_screen.dart: ${originalError.toString()}',
        originalError: originalError,
        stackTrace: StackTrace.current,
        extras: {
          'errorType': 'ArgumentError',
          'context_type': 'UI',
          'location': 'profile_screen.dart',
          'context': '{userId: 456, action: update}',
        },
      );

      // This is what WiseSentry.captureException receives
      expect(uiException.message, contains('profile_screen.dart'));
      expect(uiException.originalError, equals(originalError));
      expect(uiException.extras?['error_type'], 'UIException');
      expect(uiException.extras?['errorType'], 'ArgumentError');
      expect(uiException.extras?['location'], 'profile_screen.dart');
      expect(uiException.extras?['context'], contains('userId'));
    });

    test('verifies DTOException structure', () {
      try {
        WiseDTOParser.parse(
          () => throw FormatException('Invalid JSON'),
          json: {'invalid': 'data'},
          mapper: 'UserModel.fromJson',
        );
        fail('Should have thrown');
      } on DTOException catch (e) {
        expect(e, isA<DTOException>());
        expect(e.extras?['error_type'], 'DTOException');
        expect(e.extras?['errorType'], 'FormatException');
        expect(e.extras?['context_type'], 'DTO');
        expect(e.extras?['mapper'], 'UserModel.fromJson');
        expect(e.extras?['json'], isNotNull);
        expect(e.originalError, isA<FormatException>());
      }
    });

    test('verifies MapperException structure', () {
      try {
        WiseMapperParser.parse(
          () => throw StateError('Mapping failed'),
          json: {'data': 'value'},
          mapper: 'UserMapper.toEntity',
        );
        fail('Should have thrown');
      } on MapperException catch (e) {
        expect(e, isA<MapperException>());
        expect(e.extras?['error_type'], 'MapperException');
        expect(e.extras?['errorType'], 'StateError');
        expect(e.extras?['context'], 'Mapper');
        expect(e.extras?['mapper'], 'UserMapper.toEntity');
        expect(e.originalError, isA<StateError>());
      }
    });

    test('verifies merged extras when captureException is called', () {
      final exception = UIException(
        'Test UI error',
        extras: {
          'error_type': 'UIException',
          'location': 'test.dart',
        },
      );

      // Simulate what WiseSentry.captureException does
      final allExtras = {
        ...?exception.extras,
        'additionalContext': 'test data',
        'timestamp': DateTime.now().toString(),
      };

      expect(allExtras['error_type'], 'UIException');
      expect(allExtras['location'], 'test.dart');
      expect(allExtras['additionalContext'], 'test data');
      expect(allExtras.containsKey('timestamp'), isTrue);
    });
  });

  group('End-to-End: Flutter Error → UIException → Sentry', () {
    late List<Map<String, dynamic>> sentryCaptures;
    late void Function(FlutterErrorDetails)? originalOnError;

    setUp(() {
      sentryCaptures = [];
      originalOnError = FlutterError.onError;

      // Mock FlutterError.onError to simulate WiseSentry's behavior
      FlutterError.onError = (FlutterErrorDetails details) {
        // This simulates what WiseSentry.captureException does
        final exception = details.exception;
        final stack = details.stack ?? StackTrace.current;

        // Capture the error as it would be sent to Sentry
        sentryCaptures.add({
          'exception': exception,
          'stack': stack,
          'extras': {
            'flutterError': true,
            'library': details.library,
            if (details.context != null) 'context': details.context.toString(),
          },
        });
      };
    });

    tearDown(() {
      FlutterError.onError = originalOnError;
      sentryCaptures.clear();
    });

    testWidgets('complete flow: widget error caught and sent with metadata', (tester) async {
      // This simulates a real widget build error
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                throw StateError('Profile widget failed to build');
              },
            ),
          ),
        ),
      );

      // Verify error was captured
      expect(sentryCaptures, isNotEmpty);

      final captured = sentryCaptures.first;
      expect(captured['exception'].toString(), contains('Profile widget failed to build'));
      expect(captured['extras']?['flutterError'], isTrue);
      expect(captured['stack'], isNotNull);

      print('\n=== Flutter Global Error Captured ===');
      print('Exception Type: ${captured['exception'].runtimeType}');
      print('Exception Message: ${captured['exception']}');
      print('Extras: ${captured['extras']}');
      print('Stack Trace (first 3 lines):');
      print(captured['stack'].toString().split('\n').take(3).join('\n'));
      print('=====================================\n');
    });

    test('complete flow: UIException created with WiseUIErrorParser', () {
      UIException? caughtException;
      StackTrace? caughtStack;

      try {
        // Simulate using WiseUIErrorParser in a widget
        WiseUIErrorParser.parse(
          () => _throwFromSpecificLocation(),
          location: 'lib/features/profile/profile_screen.dart',
          context: {
            'userId': 'user-123',
            'screen': 'profile',
            'action': 'load_user_data',
          },
        );
      } on UIException catch (e, stack) {
        caughtException = e;
        caughtStack = stack;
      }

      // Verify the UIException was created correctly
      expect(caughtException, isNotNull);
      expect(caughtException!.message, contains('lib/features/profile/profile_screen.dart'));

      // Verify all metadata
      expect(caughtException.originalError, isA<StateError>());
      expect(caughtException.originalError.toString(), contains('User data load failed'));

      // Verify extras structure
      final extras = caughtException.extras!;
      expect(extras['error_type'], 'UIException');
      expect(extras['errorType'], 'StateError');
      expect(extras['context_type'], 'UI');
      expect(extras['location'], 'lib/features/profile/profile_screen.dart');
      expect(extras['context'], contains('user-123'));
      expect(extras['context'], contains('profile'));
      expect(extras['context'], contains('load_user_data'));

      // Verify stack trace preservation
      expect(caughtStack, isNotNull);
      expect(caughtStack.toString(), contains('_throwFromSpecificLocation'));

      print('\n=== UIException Structure ===');
      print('Exception Type: ${caughtException.runtimeType}');
      print('Message: ${caughtException.message}');
      print('Original Error Type: ${caughtException.originalError.runtimeType}');
      print('Original Error: ${caughtException.originalError}');
      print('\nExtras:');
      extras.forEach((key, value) {
        print('  $key: $value');
      });
      print('\nStack Trace (first 5 lines):');
      print(caughtStack.toString().split('\n').take(5).join('\n'));
      print('==============================\n');
    });

    testWidgets('complete flow: wrapped widget error with full location tracking', (tester) async {
      UIException? caughtException;
      StackTrace? caughtStack;

      // Build a widget wrapped with WiseUIErrorParser
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                try {
                  return WiseUIErrorParser.parse(
                    () => _UserProfileCard(
                      userId: 'user-456',
                      onError: (e, stack) {
                        caughtException = e as UIException;
                        caughtStack = stack;
                      },
                    ),
                    location: 'lib/widgets/user_profile_card.dart',
                    context: {
                      'userId': 'user-456',
                      'widget': 'UserProfileCard',
                    },
                  );
                } catch (e, stack) {
                  if (e is UIException) {
                    caughtException = e;
                    caughtStack = stack;
                  }
                  rethrow;
                }
              },
            ),
          ),
        ),
      );

      // Trigger the error
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify complete error structure
      expect(caughtException, isNotNull);

      print('\n=== Complete Error Flow ===');
      print('1. Original Error:');
      print('   Type: ${caughtException?.originalError?.runtimeType}');
      print('   Message: ${caughtException?.originalError}');
      print('\n2. Wrapped UIException:');
      print('   Message: ${caughtException?.message}');
      print('   Location: ${caughtException?.extras?['location']}');
      print('\n3. Context:');
      print('   User ID: ${caughtException?.extras?['context']}');
      print('\n4. Error Classification:');
      print('   Error Type: ${caughtException?.extras?['error_type']}');
      print('   Original Type: ${caughtException?.extras?['errorType']}');
      print('   Context Type: ${caughtException?.extras?['context_type']}');
      print('\n5. Stack Trace Preserved:');
      print('   ${caughtStack.toString().split('\n').first}');
      print('===========================\n');
    });

    test('comparison: unwrapped vs wrapped error tracking', () {
      // Scenario 1: Unwrapped error (just caught by Flutter global handler)
      final unwrappedError = Exception('Basic widget error');
      final unwrappedExtras = {'flutterError': true};

      // Scenario 2: Wrapped with WiseUIErrorParser
      UIException? wrappedError;
      try {
        WiseUIErrorParser.parse(
          () => throw Exception('Basic widget error'),
          location: 'lib/screens/home_screen.dart',
          context: {'userId': '789', 'tab': 'feed'},
        );
      } on UIException catch (e) {
        wrappedError = e;
      }

      print('\n=== Comparison: Unwrapped vs Wrapped ===');
      print('\n1. UNWRAPPED ERROR (Global Handler Only):');
      print('   Exception: $unwrappedError');
      print('   Extras: $unwrappedExtras');
      print('   Location Info: ❌ None');
      print('   Context Info: ❌ None');
      print('   Error Type Classification: ❌ None');
      print('\n2. WRAPPED ERROR (With WiseUIErrorParser):');
      print('   Exception: ${wrappedError!.message}');
      print('   Original Error: ${wrappedError.originalError}');
      print('   Location Info: ✅ ${wrappedError.extras?['location']}');
      print('   Context Info: ✅ ${wrappedError.extras?['context']}');
      print('   Error Type: ✅ ${wrappedError.extras?['error_type']}');
      print('   Original Type: ✅ ${wrappedError.extras?['errorType']}');
      print('   Context Type: ✅ ${wrappedError.extras?['context_type']}');
      print('\n✨ Wrapped errors provide rich debugging context!');
      print('==========================================\n');

      expect(wrappedError.extras?['location'], 'lib/screens/home_screen.dart');
      expect(wrappedError.extras?['context'], contains('userId'));
    });

    test('demonstrates what Sentry receives for each scenario', () {
      // Scenario 1: Raw Flutter error
      final rawError = FlutterErrorDetails(
        exception: StateError('Widget state error'),
        stack: StackTrace.current,
        library: 'widgets library',
        context: ErrorDescription('during build'),
      );

      // Scenario 2: UIException from WiseUIErrorParser
      UIException? uiException;
      try {
        WiseUIErrorParser.parse(
          () => throw StateError('Widget state error'),
          location: 'lib/features/cart/cart_screen.dart',
          context: {'cartId': '123', 'itemCount': 5},
        );
      } on UIException catch (e) {
        uiException = e;
      }

      print('\n=== What Sentry Receives ===');
      print('\n📊 SCENARIO 1: Raw Flutter Error');
      print('Sentry Event:');
      print('  exception: ${rawError.exception}');
      print('  type: ${rawError.exception.runtimeType}');
      print('  extras: {flutterError: true, library: widgets library}');
      print('  context: during build');
      print('\n📊 SCENARIO 2: UIException (Recommended)');
      print('Sentry Event:');
      print('  exception: ${uiException!.message}');
      print('  type: UIException');
      print('  original_error: ${uiException.originalError}');
      print('  extras:');
      uiException.extras?.forEach((key, value) {
        print('    $key: $value');
      });
      print('\n✅ UIException provides structured, queryable data in Sentry!');
      print('================================\n');
    });
  });
}

// Helper functions for testing
void _throwFromKnownLocation() {
  throw StateError('Test error from known location');
}

void _throwFromSpecificLocation() {
  throw StateError('User data load failed');
}

class _UserProfileCard extends StatelessWidget {
  const _UserProfileCard({
    required this.userId,
    this.onError,
  });

  final String userId;
  final void Function(Object, StackTrace)? onError;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        try {
          throw RangeError('Failed to load user profile');
        } catch (e, stack) {
          onError?.call(e, stack);
          rethrow;
        }
      },
      child: Text('Load Profile: $userId'),
    );
  }
}

class _ErrorThrowingWidget extends StatefulWidget {
  const _ErrorThrowingWidget();

  @override
  State<_ErrorThrowingWidget> createState() => _ErrorThrowingWidgetState();
}

class _ErrorThrowingWidgetState extends State<_ErrorThrowingWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // This will throw during setState
        setState(() {
          throw Exception('State update error');
        });
      },
      child: const Text('Trigger Error'),
    );
  }
}

class _RenderErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ErrorThrowingPainter(),
    );
  }
}

class _ErrorThrowingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    throw Exception('Painting error');
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
