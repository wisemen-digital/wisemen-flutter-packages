/// Translated text for the signing component, supplied by the app.
abstract class SigningStrings {
  /// Creates signing text without installing a localization delegate.
  const SigningStrings();

  /// Label for the signer's name input.
  String get signerName;

  /// Label and accessibility description for the drawing area.
  String get signHere;

  /// Clear action label.
  String get clear;

  /// Error when the trimmed name is empty.
  String get nameRequired;

  /// Error when no acceptable signature has been drawn.
  String get signatureRequired;
}

/// Default English text. Apps can supply their own [SigningStrings].
class SigningStringsEn extends SigningStrings {
  /// Creates the English signing text.
  const SigningStringsEn();

  @override
  String get signerName => 'Name of the signer';

  @override
  String get signHere => 'Sign here';

  @override
  String get clear => 'Clear';

  @override
  String get nameRequired => 'Enter the signer’s name.';

  @override
  String get signatureRequired => 'Draw a signature.';
}
