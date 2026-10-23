/// [UnknownException] wraps a non-Dio error thrown by a `w`-prefixed request
class UnknownException implements Exception {
  /// Constructor requires message
  UnknownException(this.message);

  /// [message] field to show the caught exception message
  String message;
}
