/// [UnknownException] is an exception thrown when refreshing toking goes wrong
class UnknownException implements Exception {
  /// Constructor requires message
  UnknownException(this.message);

  /// [message] field to show the caught exception message
  String message;
}
