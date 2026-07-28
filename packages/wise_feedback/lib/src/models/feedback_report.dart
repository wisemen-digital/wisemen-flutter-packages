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

  /// [metadata] key under which the navigation breadcrumb is stored.
  ///
  /// The value is a `List<String>` of route names, oldest first. Templates read
  /// it via `FeedbackTemplate.breadcrumbsOf` and format it themselves, so the
  /// trail is never flattened to a display string in transit.
  static const String navigationKey = 'navigation';

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
}
