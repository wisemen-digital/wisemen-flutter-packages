import 'package:flutter_test/flutter_test.dart';
import 'package:wise_text/wise_text.dart';

void main() {
  group('NoOpTextClassifier', () {
    final classifier = NoOpTextClassifier();

    test('returns the whole input as a single untyped text span', () async {
      final spans = await classifier.classifyText('Call 555-1234 on Monday');

      expect(spans, [
        const ItemSpan(
          text: 'Call 555-1234 on Monday',
          type: WiseTextItemType.text,
        ),
      ]);
    });

    test('never classifies detectable content', () async {
      // An email/date/link that a real detector would tag stays plain text here.
      final spans = await classifier.classifyText('Mail test@mail.com');

      expect(spans, hasLength(1));
      expect(spans.single.type, WiseTextItemType.text);
      expect(spans.single.text, 'Mail test@mail.com');
    });

    test('preserves an empty string as a single empty span', () async {
      final spans = await classifier.classifyText('');

      expect(spans, [const ItemSpan(text: '', type: WiseTextItemType.text)]);
    });

    test('returns the text verbatim so spans reproduce the input', () async {
      const source = 'Special <chars> & "quotes" \n newlines';
      final spans = await classifier.classifyText(source);

      expect(spans.map((s) => s.text).join(), source);
    });

    test('dispose call succeeds and is a void', () {
      expect(classifier.dispose, returnsNormally);
    });
  });
}
