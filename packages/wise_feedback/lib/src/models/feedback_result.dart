/// The outcome of a successful submission.
class FeedbackResult {
  /// Creates a result. Both fields may be null if the transport does not
  /// return issue identifiers.
  const FeedbackResult({this.issueId, this.issueUrl});

  /// The created Linear issue id, if known.
  final String? issueId;

  /// The created Linear issue URL, if known.
  final String? issueUrl;
}
