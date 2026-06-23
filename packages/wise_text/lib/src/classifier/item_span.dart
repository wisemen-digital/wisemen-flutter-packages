/// The kind of content a [ItemSpan] represents.
///
/// These mirror the `NSDataDetector`-supported `NSTextCheckingResult` types,
/// plus [text] for the plain runs in between detected items.
enum WiseTextItemType {
  text,
  date,
  address,
  link,
  phoneNumber,
  transitInformation;

  /// Maps the raw string produced by the native classifier to a value.
  /// Unknown strings fall back to [text].
  static WiseTextItemType fromRaw(String raw) {
    for (final value in WiseTextItemType.values) {
      if (value.name == raw) return value;
    }
    return WiseTextItemType.text;
  }
}

/// A contiguous span of classified text.
///
/// [text] is the matched substring as it appears in the source, [type] is the
/// detected kind, and [rawValue] is a normalized representation of the match
/// (e.g. an ISO-8601 date, an absolute URL, or a `key=value;` component list).
/// For plain [WiseTextItemType.text] spans, [rawValue] equals [text].
class ItemSpan {
  const ItemSpan({required this.text, required this.type});

  factory ItemSpan.fromJson(Map<String, dynamic> json) {
    return ItemSpan(text: json['text'] as String? ?? '', type: WiseTextItemType.fromRaw(json['type'] as String? ?? 'text'));
  }

  final String text;
  final WiseTextItemType type;

  @override
  String toString() => 'ItemSpan(text: $text, type: ${type.name})';

  @override
  bool operator ==(Object other) => other is ItemSpan && other.text == text && other.type == type;

  @override
  int get hashCode => Object.hash(text, type);
}
