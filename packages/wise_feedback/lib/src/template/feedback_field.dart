/// A single editable text field shown in the feedback form.
class FeedbackField {
  /// Creates a field. [key] identifies its value in `FeedbackReport.fields`.
  const FeedbackField({
    required this.key,
    required this.label,
    this.minLines = 2,
    this.maxLines = 4,
  });

  /// Stable key used to store and read the value (e.g. `currentSituation`).
  final String key;

  /// Label shown above the input.
  final String label;

  /// Minimum visible lines.
  final int minLines;

  /// Maximum visible lines before scrolling.
  final int maxLines;
}
