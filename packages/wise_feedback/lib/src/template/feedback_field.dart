/// A single editable text field shown in the feedback form.
class FeedbackField {
  /// Creates a field. [key] identifies its value in `FeedbackReport.fields`.
  ///
  /// A null [label] lets the form resolve a localized label for built-in field
  /// keys; custom fields should provide their own (translated) label.
  const FeedbackField({
    required this.key,
    this.label,
    this.minLines = 2,
    this.maxLines = 4,
  });

  /// Stable key used to store and read the value (e.g. `currentSituation`).
  final String key;

  /// Label shown above the input, or null to use the localized default for a
  /// built-in field key.
  final String? label;

  /// Minimum visible lines.
  final int minLines;

  /// Maximum visible lines before scrolling.
  final int maxLines;
}
