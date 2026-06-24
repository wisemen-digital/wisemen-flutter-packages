import 'package:flutter/foundation.dart';

import 'wise_text_item_type.dart';

/// A contiguous span of classified text.
///
/// [text] is the matched substring as it appears in the source and [type] is
/// the detected kind.
@immutable
class ItemSpan {
  /// Creates [ItemSpan] instance
  const ItemSpan({required this.text, required this.type});

  /// Text in it's entirety
  /// Either a classified string or the parts in between
  final String text;

  /// Classified text type
  final WiseTextItemType type;

  /// Tagged text used for xml formatting
  ///
  /// Remains untagged in case of [WiseTextItemType.text]
  String get tag => type.tag(text);

  /// Rebuilds the ordered list of spans from the flat `(start, length, code)`
  /// triples emitted by the native classifiers.
  ///
  /// The native side only reports the *detected* ranges; the runs between them
  /// (and any leading/trailing remainder) are emitted here as
  /// [WiseTextItemType.text] spans, so concatenating every [text] reproduces
  /// the original [source]. Offsets are UTF-16 code-unit based, which matches
  /// `NSString`, Kotlin `String`, and Dart [String] indexing alike.
  ///
  /// Triples that run backwards or fall outside [source] are skipped so a
  /// misbehaving detector can never produce out-of-range substrings.
  static List<ItemSpan> spansFromRanges(String source, List<int> triples) {
    final spans = <ItemSpan>[];
    var cursor = 0;

    for (var i = 0; i + 2 < triples.length; i += 3) {
      final start = triples[i];
      final length = triples[i + 1];
      final code = triples[i + 2];

      // Guard against overlapping/backwards or out-of-range ranges.
      if (length <= 0 || start < cursor || start + length > source.length) {
        continue;
      }

      // Emit the plain text between the previous match and this one.
      if (start > cursor) {
        spans.add(ItemSpan(text: source.substring(cursor, start), type: WiseTextItemType.text));
      }

      spans.add(ItemSpan(text: source.substring(start, start + length), type: WiseTextItemType.fromCode(code)));
      cursor = start + length;
    }

    // Emit any trailing plain text after the last match.
    if (cursor < source.length) {
      spans.add(ItemSpan(text: source.substring(cursor), type: WiseTextItemType.text));
    }

    return List.unmodifiable(spans);
  }

  @override
  bool operator ==(Object other) => other is ItemSpan && other.text == text && other.type == type;

  @override
  int get hashCode => Object.hash(text, type);

  @override
  String toString() => 'ItemSpan(text: $text, type: ${type.name})';
}
