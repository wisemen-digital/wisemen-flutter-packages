import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';
import 'fake_transport.dart';

void main() {
  group('FakeTransport', () {
    test('send returns configured result', () async {
      const expectedResult = FeedbackResult(
        issueId: 'ISSUE-123',
        issueUrl: 'https://linear.app/issue/123',
      );
      final transport = FakeTransport(result: expectedResult);

      final report = FeedbackReport(
        title: 'Test title',
        description: 'Test description',
        screenshotPng: Uint8List(0),
      );

      final result = await transport.send(report);

      expect(result, expectedResult);
    });

    test('send records call for verification', () async {
      final transport = FakeTransport(
        result: const FeedbackResult(),
      );
      final report = FeedbackReport(
        title: 'Test title',
        description: 'Test description',
        screenshotPng: Uint8List(0),
      );

      await transport.send(report);

      expect(transport.sendWasCalled, isTrue);
      expect(transport.lastReport, report);
    });

    test('send can be called multiple times', () async {
      final transport = FakeTransport(
        result: const FeedbackResult(),
      );
      final report1 = FeedbackReport(
        title: 'Title 1',
        description: 'Description 1',
        screenshotPng: Uint8List(0),
      );
      final report2 = FeedbackReport(
        title: 'Title 2',
        description: 'Description 2',
        screenshotPng: Uint8List(0),
      );

      await transport.send(report1);
      await transport.send(report2);

      expect(transport.sendCallCount, 2);
      expect(transport.lastReport, report2);
    });

    test('send works without configured result', () async {
      final transport = FakeTransport();

      final report = FeedbackReport(
        title: 'Test title',
        description: 'Test description',
        screenshotPng: Uint8List(0),
      );

      final result = await transport.send(report);

      expect(result, isA<FeedbackResult>());
    });
  });
}
