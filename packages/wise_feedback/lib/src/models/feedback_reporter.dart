/// Identifies who submitted a report.
///
/// All fields are optional; supply whatever your app knows about the current
/// user. Attached to the report so triagers can follow up.
class FeedbackReporter {
  /// Creates a reporter. Any field may be null.
  const FeedbackReporter({this.id, this.name, this.email});

  /// Stable user identifier, if available.
  final String? id;

  /// Display name, if available.
  final String? name;

  /// Contact email, if available.
  final String? email;

  /// Whether no identifying information was provided.
  bool get isEmpty => id == null && name == null && email == null;
}
