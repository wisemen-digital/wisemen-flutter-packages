import 'dart:typed_data';

/// A confirmed signature snapshot. Metadata is separate from the ink-only PNG.
class SigningResult {
  /// Creates a snapshot of [signerName], [pngBytes] and [signedAt].
  const SigningResult({
    required this.signerName,
    required Uint8List pngBytes,
    required this.signedAt,
  }) : _pngBytes = pngBytes;

  final Uint8List _pngBytes;

  /// The signer's name with leading and trailing whitespace removed.
  final String signerName;

  /// Transparent PNG bytes. A copy protects the snapshot and works with image
  /// codecs that require native typed data on the web.
  Uint8List get pngBytes => Uint8List.fromList(_pngBytes);

  /// Device-local time when the first ink appeared after the last Clear.
  final DateTime signedAt;
}
