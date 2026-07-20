import 'package:wise_text/src/models/item_span.dart';

/// The kind of content a [ItemSpan] represents.
///
/// These mirror the `NSDataDetector`-supported `NSTextCheckingResult` types on iOS,
/// and `TextClassifier`-supported types on Android
/// plus [text] for the plain runs in between detected items.
enum WiseTextItemType {
  /// Default fallback value for unclassified text
  text,

  /// `NSTextCheckingResult.date` or `TextClassifier.TYPE_DATE, TextClassifier.TYPE_DATE_TIME`
  /// e.g. June 24, 2026 at 3:00 PM
  date,

  /// `NSTextCheckingResult.address` or `TextClassifier.TYPE_ADDRESS`
  /// e.g. June 24, 2026 at 3:00 PM
  address,

  /// `NSTextCheckingResult.link` or `TextClassifier.TYPE_URL`
  /// e.g. https://pub.dev/
  link,

  /// `NSTextCheckingResult.link` with mailTo scheme or `TextClassifier.TYPE_EMAIL`
  /// e.g. test@mail.com
  email,

  /// `NSTextCheckingResult.phoneNumber` or `TextClassifier.TYPE_PHONE`
  /// e.g. +1 (408) 555-0123
  phoneNumber;

  /// Maps the integer type code produced by the native classifiers to a value.
  ///
  /// The codes are a stable wire contract shared with the Swift and Kotlin
  /// sides (see `SwiftTextClassifier` / `WiseTextPlugin`):
  /// `0 = date, 1 = address, 2 = link, 3 = email, 4 = phoneNumber`. Unknown codes fall
  /// back to [text].
  static WiseTextItemType fromCode(int code) {
    switch (code) {
      case 0:
        return WiseTextItemType.date;
      case 1:
        return WiseTextItemType.address;
      case 2:
        return WiseTextItemType.link;
      case 3:
        return WiseTextItemType.email;
      case 4:
        return WiseTextItemType.phoneNumber;
      default:
        return WiseTextItemType.text;
    }
  }

  /// Tagged text used for xml formatting
  ///
  /// Remains untagged in case of [WiseTextItemType.text]
  String tag(String text) {
    switch (this) {
      case .text:
        return text;
      // ignore: no_default_cases
      default:
        return '<$tagName>$text</$tagName>';
    }
  }

  /// Name used within xml tags
  String get tagName => name.toUpperCase();
}
