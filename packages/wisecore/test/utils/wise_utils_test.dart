import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wisecore/src/utils/wise_utils.dart';

class MockScrollMetrics extends Mock implements ScrollMetrics {}

void main() {
  group('Optional', () {
    test('should hold value', () {
      const optional = Optional.value(42);
      expect(optional.value, 42);
    });
  });

  group('prettyJson', () {
    test('should pretty print JSON', () {
      final input = {'key': 'value'};
      final output = prettyJson(input);
      expect(output, contains('key'));
      expect(output, contains('value'));
      expect(output, contains('    '));
    });
  });

  group('Debouncer', () {
    test('should debounce function calls', () async {
      final debouncer = Debouncer(duration: const Duration(milliseconds: 100));
      var counter = 0;

      debouncer
        ..run(() => counter++)
        ..run(() => counter++);
      await Future<Void?>.delayed(const Duration(milliseconds: 150));
      expect(counter, 1);
    });
  });

  group('makePeriodicTimer', () {
    test('should call callback periodically', () async {
      var count = 0;
      final timer = makePeriodicTimer(
        const Duration(milliseconds: 50),
        (_) => count++,
      );

      await Future<Void?>.delayed(const Duration(milliseconds: 120));
      timer.cancel();
      expect(count, greaterThan(1));
    });

    test('should fire immediately if fireNow is true', () {
      var count = 0;
      makePeriodicTimer(
        const Duration(seconds: 1),
        (_) => count++,
        fireNow: true,
      ).cancel();

      expect(count, 1);
    });
  });

  group('CustomLockScrollPhysics', () {
    final fakeMetrics = FixedScrollMetrics(
      pixels: 0,
      minScrollExtent: 0,
      maxScrollExtent: 100,
      viewportDimension: 100,
      axisDirection: AxisDirection.right,
      devicePixelRatio: 1,
    );

    test('should lock scrolling when configured', () {
      final physics = CustomLockScrollPhysics(lockLeft: true);
      final offset = physics.applyPhysicsToUserOffset(
        fakeMetrics,
        10,
      );
      expect(offset, 0);
    });

    test('should allow scrolling when unlocked', () {
      final physics = CustomLockScrollPhysics();
      final offset = physics.applyPhysicsToUserOffset(
        fakeMetrics,
        10,
      );
      expect(offset, 10);
    });

    test('applyTo returns new instance with same lock flags', () {
      final physics = CustomLockScrollPhysics(lockLeft: true);
      final applied = physics.applyTo(null);
      expect(applied.lockLeft, isTrue);
      expect(applied.lockRight, isFalse);
    });

    group('applyBoundaryConditions tests', () {
      final physics = CustomLockScrollPhysics(lockLeft: true);
      final metrics = MockScrollMetrics();

      setUp(() {
        when(() => metrics.pixels).thenReturn(50);
        when(() => metrics.minScrollExtent).thenReturn(0);
        when(() => metrics.maxScrollExtent).thenReturn(100);
        when(() => metrics.viewportDimension).thenReturn(100);
        when(() => metrics.axisDirection).thenReturn(AxisDirection.right);
      });

      group('under-scroll', () {
        test('should return the value when past minScrollExtent', () {
          when(() => metrics.pixels).thenReturn(0);

          final underScrollMetrics = metrics;
          expect(
            physics.applyBoundaryConditions(underScrollMetrics, -10),
            equals(-10),
          );
        });
      });

      group('over-scroll', () {
        test('should return the value when past maxScrollExtent', () {
          when(() => metrics.pixels).thenReturn(100);

          final overScrollMetrics = metrics;
          expect(
            physics.applyBoundaryConditions(overScrollMetrics, 110),
            equals(10),
          );
        });
      });

      group('top edge', () {
        test('should return correct value when hitting top edge', () {
          final topEdgeMetrics = metrics;
          expect(
            physics.applyBoundaryConditions(topEdgeMetrics, -10),
            equals(-60), // -10 - 50
          );
        });
      });

      group('bottom edge', () {
        test('should return correct value when hitting bottom edge', () {
          final bottomEdgeMetrics = metrics;
          expect(
            physics.applyBoundaryConditions(bottomEdgeMetrics, 110),
            equals(60),
          );
        });
      });
    });
  });

  group('platform', () {
    test('isWeb returns correct value', () {
      expect(isWeb, equals(false));
    });

    test('isIos returns correct value', () {
      expect(isIos, equals(Platform.isIOS));
    });

    test('isAndroid returns correct value', () {
      expect(isAndroid, equals(Platform.isAndroid));
    });
  });

  testWidgets('shows snackbar with message', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: ElevatedButton(
                onPressed: () =>
                    showSnackBar(context: context, message: 'Test'),
                child: const Text('Show'),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Show'));
    await tester.pump(); // start snackbar animation
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Test'), findsOneWidget);
  });
}
