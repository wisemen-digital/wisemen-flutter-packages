/// Thrown by transports when a submission cannot be completed.
class FeedbackException implements Exception {
  /// Creates an exception with a human-readable [message] and optional [cause].
  const FeedbackException(this.message, {this.cause});

  /// Human-readable description of the failure.
  final String message;

  /// The underlying error, if any.
  final Object? cause;

  @override
  String toString() => 'FeedbackException: $message';
}
