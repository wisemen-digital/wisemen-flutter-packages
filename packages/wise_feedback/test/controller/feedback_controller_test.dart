import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/src/controller/feedback_controller.dart';
import 'package:wise_feedback/wise_feedback.dart';
import '../support/fake_transport.dart';

FeedbackReport _report() => FeedbackReport(
      title: 't',
      description: 'd',
      screenshotPng: Uint8List.fromList([1]),
    );

void main() {
  group('FeedbackController', () {
    test('submit transitions idle -> submitting -> success', () async {
      final transport =
          FakeTransport(result: const FeedbackResult(issueId: 'C-1'));
      final controller = FeedbackController(transport);
      final states = <Type>[controller.value.runtimeType];
      controller.addListener(() => states.add(controller.value.runtimeType));

      await controller.submit(_report());

      expect(states, [
        FeedbackIdle,
        FeedbackSubmitting,
        FeedbackSuccess,
      ]);
      expect((controller.value as FeedbackSuccess).result.issueId, 'C-1');
      expect(transport.sent, hasLength(1));
    });

    test('submit sets failure and does not throw when transport fails',
        () async {
      final transport = FakeTransport(throwError: const FeedbackException('x'));
      final controller = FeedbackController(transport);

      await controller.submit(_report());

      expect(controller.value, isA<FeedbackFailure>());
      expect(
        (controller.value as FeedbackFailure).error,
        isA<FeedbackException>(),
      );
    });

    test('show invokes the bound handler', () {
      final controller = FeedbackController(FakeTransport());
      var called = 0;
      controller
        ..bindShow(() => called++)
        ..show();
      expect(called, 1);
    });

    test('isSubmitting is true while in flight', () async {
      final transport = FakeTransport(autoComplete: false);
      final controller = FeedbackController(transport);
      final future = controller.submit(_report());
      expect(controller.value.isSubmitting, isTrue);
      transport.complete();
      await future;
      expect(controller.value, isA<FeedbackSuccess>());
    });
  });
}
