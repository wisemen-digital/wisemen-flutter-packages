/// The outcome of a successful submission.
class FeedbackResult {
  /// Creates a result. Both fields may be null if the transport does not
  /// return issue identifiers.
  const FeedbackResult({this.issueId, this.issueUrl});

  /// Builds a result from the proxy backend's JSON body
  /// (`{"issueId": ..., "issueUrl": ...}`); missing fields decode to `null`.
  factory FeedbackResult.fromJson(Map<String, dynamic> json) {
    return FeedbackResult(
      issueId: json['issueId'] as String?,
      issueUrl: json['issueUrl'] as String?,
    );
  }

  /// The created Linear issue id, if known.
  final String? issueId;

  /// The created Linear issue URL, if known.
  final String? issueUrl;
}
