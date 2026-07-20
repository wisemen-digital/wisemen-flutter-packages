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

      expect(spans.map((s) => s.type).toList(), [
        WiseTextItemType.text,
        WiseTextItemType.phoneNumber,
        WiseTextItemType.text,
        WiseTextItemType.date,
      ]);
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

      expect(spans, [
        const ItemSpan(text: 'just text', type: WiseTextItemType.text),
      ]);
    });

    test('empty input yields no spans', () {
      expect(ItemSpan.spansFromRanges('', const []), isEmpty);
    });

    test('a match at the very start emits no leading text gap', () {
      const source = 'Monday works';
      final spans = ItemSpan.spansFromRanges(source, [0, 6, 0]);

      expect(spans, [
        const ItemSpan(text: 'Monday', type: WiseTextItemType.date),
        const ItemSpan(text: ' works', type: WiseTextItemType.text),
      ]);
    });

    test('skips overlapping, backwards, or out-of-range triples', () {
      const source = 'abcdef';
      // Valid 0..2, then a backwards/overlapping 1..3, then out-of-range 4..10.
      final triples = [0, 2, 2, 1, 2, 2, 4, 6, 2];

      final spans = ItemSpan.spansFromRanges(source, triples);

      expect(spans, [
        const ItemSpan(text: 'ab', type: WiseTextItemType.link),
        const ItemSpan(text: 'cdef', type: WiseTextItemType.text),
      ]);
    });

    test('ignores a trailing partial triple', () {
      const source = 'abcdef';
      // One full triple (0..2 link) plus a dangling pair that must be ignored.
      final triples = [0, 2, 2, 4, 2];

      final spans = ItemSpan.spansFromRanges(source, triples);

      expect(spans, [
        const ItemSpan(text: 'ab', type: WiseTextItemType.link),
        const ItemSpan(text: 'cdef', type: WiseTextItemType.text),
      ]);
    });
  });

  group('Equals and hashCode', () {
    test('spans with the same text and type are equal', () {
      const a = ItemSpan(text: 'test@mail.com', type: WiseTextItemType.email);
      const b = ItemSpan(text: 'test@mail.com', type: WiseTextItemType.email);

      expect(a, b);
      expect(a.hashCode, b.hashCode);
    });

    test('spans differing in text are not equal', () {
      const a = ItemSpan(text: 'Monday', type: WiseTextItemType.date);
      const b = ItemSpan(text: 'Tuesday', type: WiseTextItemType.date);

      expect(a, isNot(b));
    });

    test('spans differing in type are not equal', () {
      const a = ItemSpan(text: 'same', type: WiseTextItemType.link);
      const b = ItemSpan(text: 'same', type: WiseTextItemType.text);

      expect(a, isNot(b));
    });

    test('a span is not equal to an object of another type', () {
      const span = ItemSpan(text: 'same', type: WiseTextItemType.text);

      // ignore: unrelated_type_equality_checks
      expect(span == 'same', isFalse);
    });

    test('identical spans are equal to themselves', () {
      const span = ItemSpan(text: 'self', type: WiseTextItemType.phoneNumber);

      expect(span, span);
    });
  });

  group('ItemSpan tags', () {
    test('plain text spans remain untagged', () {
      const span = ItemSpan(text: 'just text', type: WiseTextItemType.text);

      expect(span.tag, 'just text');
    });

    test('classified spans are wrapped in uppercase xml tags', () {
      expect(
        const ItemSpan(text: 'Monday', type: WiseTextItemType.date).tag,
        '<DATE>Monday</DATE>',
      );
      expect(
        const ItemSpan(text: '1 Main St', type: WiseTextItemType.address).tag,
        '<ADDRESS>1 Main St</ADDRESS>',
      );
      expect(
        const ItemSpan(
          text: 'https://pub.dev/',
          type: WiseTextItemType.link,
        ).tag,
        '<LINK>https://pub.dev/</LINK>',
      );
      expect(
        const ItemSpan(text: 'test@mail.com', type: WiseTextItemType.email).tag,
        '<EMAIL>test@mail.com</EMAIL>',
      );
      expect(
        const ItemSpan(
          text: '555-1234',
          type: WiseTextItemType.phoneNumber,
        ).tag,
        '<PHONENUMBER>555-1234</PHONENUMBER>',
      );
    });

    test('tagName uppercases the enum name', () {
      expect(WiseTextItemType.email.tagName, 'EMAIL');
      expect(WiseTextItemType.phoneNumber.tagName, 'PHONENUMBER');
    });
  });
}
