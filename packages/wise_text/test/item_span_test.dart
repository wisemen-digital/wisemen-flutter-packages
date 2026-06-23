import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:wise_text/wise_text.dart';

void main() {
  group('ItemSpan.fromJson', () {
    test('parses a known type', () {
      final span = ItemSpan.fromJson({'text': 'https://example.com', 'type': 'link'});

      expect(span.type, WiseTextItemType.link);
      expect(span.text, 'https://example.com');
    });

    test('falls back to text for an unknown type', () {
      final span = ItemSpan.fromJson({'text': 'hi', 'type': 'correction'});

      expect(span.type, WiseTextItemType.text);
    });

    test('tolerates missing fields', () {
      final span = ItemSpan.fromJson(const {});

      expect(span.text, '');
      expect(span.type, WiseTextItemType.text);
    });
  });

  test('decodes the native JSON array contract into ordered spans', () {
    // Mirrors the JSON shape produced by SwiftTextClassifier.classifyText.
    const payload = '''
[
  {"text": "Call ", "type": "text"},
  {"text": "555-1234", "type": "phoneNumber"},
  {"text": " on ", "type": "text"},
  {"text": "Monday", "type": "date"}
]''';

    final spans = (jsonDecode(payload) as List).whereType<Map<String, dynamic>>().map(ItemSpan.fromJson).toList();

    expect(spans.map((s) => s.type).toList(), [WiseTextItemType.text, WiseTextItemType.phoneNumber, WiseTextItemType.text, WiseTextItemType.date]);
    // Concatenating the spans reproduces the original input.
    expect(spans.map((s) => s.text).join(), 'Call 555-1234 on Monday');
  });
}
