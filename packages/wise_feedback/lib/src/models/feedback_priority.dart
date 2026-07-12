/// Severity the reporter assigned to a report.
///
/// [linearValue] maps to Linear's native issue priority scale.
enum FeedbackPriority {
  /// No priority set (Linear `0`).
  none(0, 'None'),

  /// Urgent (Linear `1`).
  urgent(1, 'Urgent'),

  /// High (Linear `2`).
  high(2, 'High'),

  /// Medium (Linear `3`).
  medium(3, 'Medium'),

  /// Low (Linear `4`).
  low(4, 'Low');

  const FeedbackPriority(this.linearValue, this.label);

  /// The value understood by Linear's `issueCreate` `priority` input.
  final int linearValue;

  /// Human-readable label shown in the form and rendered into the issue.
  final String label;
}
