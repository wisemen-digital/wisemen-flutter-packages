/// [TokenParseException] is thrown when a stored token can't be parsed
class TokenParseException implements Exception {
  /// Constructor requires message
  TokenParseException(this.message);

  /// [message] field describing why the token could not be parsed
  final String message;

  @override
  String toString() => 'TokenParseException: $message';
}
