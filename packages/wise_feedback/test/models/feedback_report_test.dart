import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';

void main() {
  test('FeedbackReport stores fields and defaults metadata to empty', () {
    final report = FeedbackReport(
      title: 'Crash on save',
      description: 'Tapping save crashes',
      screenshotPng: Uint8List.fromList([1, 2, 3]),
    );
    expect(report.title, 'Crash on save');
    expect(report.description, 'Tapping save crashes');
    expect(report.screenshotPng, Uint8List.fromList([1, 2, 3]));
    expect(report.metadata, isEmpty);
  });

  test('FeedbackReport keeps provided metadata', () {
    final report = FeedbackReport(
      title: 't',
      description: 'd',
      screenshotPng: Uint8List(0),
      metadata: const {'route': '/home'},
    );
    expect(report.metadata['route'], '/home');
  });
}
