import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';
import '../support/fake_transport.dart';

FeedbackReport _report() => FeedbackReport(
      title: 't',
      description: 'd',
      screenshotPng: Uint8List.fromList([0]),
    );

void main() {
  group('FakeTransport', () {
    test('FakeTransport records sent reports and returns its result', () async {
      final transport =
          FakeTransport(result: const FeedbackResult(issueId: 'X-1'));
      final result = await transport.send(_report());
      expect(transport.sent, hasLength(1));
      expect(result.issueId, 'X-1');
    });

    test('FakeTransport throws when configured to', () async {
      final transport =
          FakeTransport(throwError: const FeedbackException('nope'));
      expect(
        () => transport.send(_report()),
        throwsA(isA<FeedbackException>()),
      );
    });
  });
}
