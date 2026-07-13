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
    this.fields = const {},
    this.reporter,
    this.priority = FeedbackPriority.none,
    this.category,
    this.createdAt,
  });

  /// Short summary of the issue.
  final String title;

  /// The issue body. When a `FeedbackTemplate` is used this holds the rendered
  /// template output; otherwise it is the raw description text.
  final String description;

  /// PNG-encoded screenshot bytes.
  final Uint8List screenshotPng;

  /// Open extension bag for forward-compatible metadata (device, route, ...).
  final Map<String, Object?> metadata;

  /// Raw values of the form's template fields, keyed by field key.
  final Map<String, String> fields;

  /// Who submitted the report, if known.
  final FeedbackReporter? reporter;

  /// Severity the reporter assigned.
  final FeedbackPriority priority;

  /// Optional free-form category (e.g. `Bug`, `Idea`).
  final String? category;

  /// When the report was captured.
  final DateTime? createdAt;

  /// Returns a copy with the given fields replaced.
  FeedbackReport copyWith({String? description}) => FeedbackReport(
        title: title,
        description: description ?? this.description,
        screenshotPng: screenshotPng,
        metadata: metadata,
        fields: fields,
        reporter: reporter,
        priority: priority,
        category: category,
        createdAt: createdAt,
      );
}
