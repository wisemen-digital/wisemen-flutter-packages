import 'dart:typed_data';

/// An immutable bug report captured from the app.
class FeedbackReport {
  /// Creates a report. [metadata] defaults to an empty, unmodifiable map.
  const FeedbackReport({
    required this.title,
    required this.description,
    required this.screenshotPng,
    this.metadata = const {},
  });

  /// Short summary of the issue.
  final String title;

  /// Longer description of the issue.
  final String description;

  /// PNG-encoded screenshot bytes.
  final Uint8List screenshotPng;

  /// Open extension bag for forward-compatible metadata (device, route, ...).
  final Map<String, Object?> metadata;
}
