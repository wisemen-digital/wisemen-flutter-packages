import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_text/wise_text.dart';

/// A controllable [WiseTextClassifierInterface] stub.
///
/// Returns [spans] for every call and records what it was asked to classify so
/// tests can assert the widget delegated correctly.
class _StubClassifier implements WiseTextClassifierInterface {
  _StubClassifier(this.spans);

  final List<ItemSpan> spans;
  int callCount = 0;
  String? lastText;

  @override
  Future<List<ItemSpan>> classifyText(String text) async {
    callCount++;
    lastText = text;
    return spans;
  }

  @override
  void dispose() {}
}

/// A classifier whose [classifyText] always fails, to exercise the fallback.
class _ThrowingClassifier implements WiseTextClassifierInterface {
  @override
  Future<List<ItemSpan>> classifyText(String text) async {
    throw Exception('classification failed');
  }

  @override
  void dispose() {}
}

/// A classifier that only completes when the test tells it to, so the pending
/// state of the [FutureBuilder] can be observed.
class _DeferredClassifier implements WiseTextClassifierInterface {
  final completer = Completer<List<ItemSpan>>();

  @override
  Future<List<ItemSpan>> classifyText(String text) => completer.future;

  @override
  void dispose() {}
}

void main() {
  /// Wraps [child] in the minimal ancestors [StyledText] needs to render.
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  /// The single [StyledText] rendered by the widget under test.
  StyledText styledTextOf(WidgetTester tester) => tester.widget<StyledText>(find.byType(StyledText));

  group('WiseTextWidget without classification', () {
    testWidgets('renders the raw text and never calls the classifier', (
      tester,
    ) async {
      final stub = _StubClassifier(const []);

      await tester.pumpWidget(
        wrap(WiseTextWidget('Plain text', classifier: stub)),
      );
      await tester.pumpAndSettle();

      expect(styledTextOf(tester).text, 'Plain text');
      expect(stub.callCount, 0);
    });

    testWidgets('passes layout properties through to StyledText', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          WiseTextWidget(
            'Plain text',
            maxLines: 2,
            classifier: _StubClassifier([
              const ItemSpan(text: 'Plain text', type: WiseTextItemType.text),
            ]),
            textAlign: TextAlign.center,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final styled = styledTextOf(tester);
      expect(styled.maxLines, 2);
      expect(styled.textAlign, TextAlign.center);
      expect(styled.selectable, isFalse);
    });
  });

  group('WiseTextWidget with classification', () {
    testWidgets('classifies the text and renders the tagged result', (
      tester,
    ) async {
      final stub = _StubClassifier(const [
        ItemSpan(text: 'Mail ', type: WiseTextItemType.text),
        ItemSpan(text: 'test@mail.com', type: WiseTextItemType.email),
        ItemSpan(text: ' now', type: WiseTextItemType.text),
      ]);

      await tester.pumpWidget(
        wrap(
          WiseTextWidget(
            'Mail test@mail.com now',
            classified: true,
            classifier: stub,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(stub.callCount, 1);
      expect(stub.lastText, 'Mail test@mail.com now');
      expect(
        styledTextOf(tester).text,
        'Mail <EMAIL>test@mail.com</EMAIL> now',
      );
    });

    testWidgets('falls back to the original text when the classifier throws', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          WiseTextWidget(
            'Mail test@mail.com',
            classified: true,
            classifier: _ThrowingClassifier(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(styledTextOf(tester).text, 'Mail test@mail.com');
    });

    testWidgets('shows the original text while classification is pending', (
      tester,
    ) async {
      final deferred = _DeferredClassifier();

      await tester.pumpWidget(
        wrap(
          WiseTextWidget('Call Monday', classified: true, classifier: deferred),
        ),
      );
      await tester.pump();

      // Before the future resolves the FutureBuilder uses the original text.
      expect(styledTextOf(tester).text, 'Call Monday');

      deferred.completer.complete(const [
        ItemSpan(text: 'Call ', type: WiseTextItemType.text),
        ItemSpan(text: 'Monday', type: WiseTextItemType.date),
      ]);
      await tester.pumpAndSettle();

      expect(styledTextOf(tester).text, 'Call <DATE>Monday</DATE>');
    });
  });

  group('WiseTextWidget selectable variant', () {
    testWidgets('renders a selectable StyledText backed by SelectableText', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          WiseTextWidget(
            'Plain text',
            selectable: true,
            classifier: _StubClassifier([
              const ItemSpan(text: 'Plain text', type: WiseTextItemType.text),
            ]),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(styledTextOf(tester).selectable, isTrue);
      expect(find.byType(SelectableText), findsOneWidget);
    });

    testWidgets('classifies before rendering the selectable variant', (
      tester,
    ) async {
      final stub = _StubClassifier(const [
        ItemSpan(text: 'Monday', type: WiseTextItemType.date),
      ]);

      await tester.pumpWidget(
        wrap(
          WiseTextWidget(
            'Monday',
            selectable: true,
            classified: true,
            classifier: stub,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(stub.callCount, 1);
      expect(styledTextOf(tester).text, '<DATE>Monday</DATE>');
      expect(styledTextOf(tester).selectable, isTrue);
    });
  });

  group('WiseTextWidget update widget', () {
    testWidgets('renders the widget again when text changes', (
      tester,
    ) async {
      final stub = _StubClassifier(const [
        ItemSpan(text: 'Monday', type: WiseTextItemType.date),
      ]);

      await tester.pumpWidget(
        wrap(WiseTextWidget('First', classified: true, classifier: stub)),
      );
      await tester.pumpAndSettle();
      expect(stub.callCount, 1);

      await tester.pumpWidget(
        wrap(WiseTextWidget('Second', classified: true, classifier: stub)),
      );
      await tester.pumpAndSettle();

      expect(stub.callCount, 2);
      expect(stub.lastText, 'Second');
      expect(styledTextOf(tester).text, '<DATE>Monday</DATE>');
    });

    testWidgets('does not classify when irrelevant parameter changes', (
      tester,
    ) async {
      final stub = _StubClassifier(const [
        ItemSpan(text: 'Same text', type: WiseTextItemType.text),
      ]);

      await tester.pumpWidget(
        wrap(
          WiseTextWidget(
            'Same text',
            maxLines: 1,
            classified: true,
            classifier: stub,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        wrap(
          WiseTextWidget(
            'Same text',
            maxLines: 3,
            classified: true,
            classifier: stub,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // The widget rebuilt with the new layout, but did not reclassify.
      expect(styledTextOf(tester).maxLines, 3);
      expect(stub.callCount, 1);
    });

    testWidgets('reclassifies with the new classifier when it changes', (
      tester,
    ) async {
      final first = _StubClassifier(const [
        ItemSpan(text: 'Monday', type: WiseTextItemType.date),
      ]);
      final second = _StubClassifier(const [
        ItemSpan(text: 'Monday', type: WiseTextItemType.text),
      ]);

      await tester.pumpWidget(
        wrap(WiseTextWidget('Monday', classified: true, classifier: first)),
      );
      await tester.pumpAndSettle();
      expect(first.callCount, 1);
      expect(styledTextOf(tester).text, '<DATE>Monday</DATE>');

      await tester.pumpWidget(
        wrap(WiseTextWidget('Monday', classified: true, classifier: second)),
      );
      await tester.pumpAndSettle();

      // The same text is reclassified by the new classifier, not the old one.
      expect(first.callCount, 1);
      expect(second.callCount, 1);
      expect(styledTextOf(tester).text, 'Monday');
    });
  });
}
