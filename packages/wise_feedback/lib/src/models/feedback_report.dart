import 'dart:typed_data';

import 'feedback_priority.dart';
import 'feedback_reporter.dart';

/// An immutable bug report captured from the app.
class FeedbackReport {
  /// Creates a report. [metadata] defaults to an empty, unmodifiable map and
  /// [priority] defaults to [FeedbackPriority.none].
  const FeedbackReport({
    required this.title,
    required this.description,
    required this.screenshotPng,
    this.metadata = const {},
    this.reporter,
    this.priority = FeedbackPriority.none,
    this.category,
  });

  /// Short summary of the issue.
  final String title;

  /// Longer description of the issue.
  final String description;

  /// PNG-encoded screenshot bytes.
  final Uint8List screenshotPng;

  /// Open extension bag for forward-compatible metadata (device, route, ...).
  final Map<String, Object?> metadata;

  /// Who submitted the report, if known.
  final FeedbackReporter? reporter;

  /// Severity the reporter assigned.
  final FeedbackPriority priority;

  /// Optional free-form category (e.g. `Bug`, `Idea`).
  final String? category;
}
