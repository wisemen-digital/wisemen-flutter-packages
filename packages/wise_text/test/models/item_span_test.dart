import 'package:flutter_test/flutter_test.dart';
import 'package:wise_text/wise_text.dart';

void main() {
  group('WiseTextItemType.fromCode', () {
    test('maps known codes', () {
      expect(WiseTextItemType.fromCode(0), WiseTextItemType.date);
      expect(WiseTextItemType.fromCode(1), WiseTextItemType.address);
      expect(WiseTextItemType.fromCode(2), WiseTextItemType.link);
      expect(WiseTextItemType.fromCode(3), WiseTextItemType.email);
      expect(WiseTextItemType.fromCode(4), WiseTextItemType.phoneNumber);
    });

    test('falls back to text for an unknown code', () {
      expect(WiseTextItemType.fromCode(99), WiseTextItemType.text);
      expect(WiseTextItemType.fromCode(-1), WiseTextItemType.text);
    });
  });

  group('ItemSpan.spansFromRanges', () {
    test('rebuilds ordered spans and fills the gaps', () {
      // "Call 555-1234 on Monday" — phoneNumber at 5..13, date at 17..23.
      const source = 'Call 555-1234 on Monday';
      final triples = [5, 8, 4, 17, 6, 0];

      final spans = ItemSpan.spansFromRanges(source, triples);

      expect(spans.map((s) => s.type).toList(), [WiseTextItemType.text, WiseTextItemType.phoneNumber, WiseTextItemType.text, WiseTextItemType.date]);
      // Concatenating the spans reproduces the original input.
      expect(spans.map((s) => s.text).join(), source);
    });

    test('builds an email span', () {
      // "Mail test@mail.com now" — email at 5..18.
      const source = 'Mail test@mail.com now';
      final spans = ItemSpan.spansFromRanges(source, [5, 13, 3]);

      expect(spans, [
        const ItemSpan(text: 'Mail ', type: WiseTextItemType.text),
        const ItemSpan(text: 'test@mail.com', type: WiseTextItemType.email),
        const ItemSpan(text: ' now', type: WiseTextItemType.text),
      ]);
    });

    test('no ranges yields a single text span covering the whole input', () {
      final spans = ItemSpan.spansFromRanges('just text', const []);

      expect(spans, [const ItemSpan(text: 'just text', type: WiseTextItemType.text)]);
    });

    test('empty input yields no spans', () {
      expect(ItemSpan.spansFromRanges('', const []), isEmpty);
    });

    test('a match at the very start emits no leading text gap', () {
      const source = 'Monday works';
      final spans = ItemSpan.spansFromRanges(source, [0, 6, 0]);

      expect(spans, [const ItemSpan(text: 'Monday', type: WiseTextItemType.date), const ItemSpan(text: ' works', type: WiseTextItemType.text)]);
    });

    test('skips overlapping, backwards, or out-of-range triples', () {
      const source = 'abcdef';
      // Valid 0..2, then a backwards/overlapping 1..3, then out-of-range 4..10.
      final triples = [0, 2, 2, 1, 2, 2, 4, 6, 2];

      final spans = ItemSpan.spansFromRanges(source, triples);

      expect(spans, [const ItemSpan(text: 'ab', type: WiseTextItemType.link), const ItemSpan(text: 'cdef', type: WiseTextItemType.text)]);
    });

    test('ignores a trailing partial triple', () {
      const source = 'abcdef';
      // One full triple (0..2 link) plus a dangling pair that must be ignored.
      final triples = [0, 2, 2, 4, 2];

      final spans = ItemSpan.spansFromRanges(source, triples);

      expect(spans, [const ItemSpan(text: 'ab', type: WiseTextItemType.link), const ItemSpan(text: 'cdef', type: WiseTextItemType.text)]);
    });
  });

  group('ItemSpan tags', () {});
}
