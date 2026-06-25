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
}

/// A classifier whose [classifyText] always fails, to exercise the fallback.
class _ThrowingClassifier implements WiseTextClassifierInterface {
  @override
  Future<List<ItemSpan>> classifyText(String text) async {
    throw Exception('classification failed');
  }
}

/// A classifier that only completes when the test tells it to, so the pending
/// state of the [FutureBuilder] can be observed.
class _DeferredClassifier implements WiseTextClassifierInterface {
  final completer = Completer<List<ItemSpan>>();

  @override
  Future<List<ItemSpan>> classifyText(String text) => completer.future;
}

void main() {
  /// Wraps [child] in the minimal ancestors [StyledText] needs to render.
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  /// The single [StyledText] rendered by the widget under test.
  StyledText styledTextOf(WidgetTester tester) => tester.widget<StyledText>(find.byType(StyledText));

  group('WiseTextWidget without classification', () {
    testWidgets('renders the raw text and never calls the classifier', (tester) async {
      final stub = _StubClassifier(const []);

      await tester.pumpWidget(wrap(WiseTextWidget('Plain text', classifier: stub)));
      await tester.pumpAndSettle();

      expect(styledTextOf(tester).text, 'Plain text');
      expect(stub.callCount, 0);
    });

    testWidgets('passes layout properties through to StyledText', (tester) async {
      await tester.pumpWidget(
        wrap(
          const WiseTextWidget(
            'Plain text',
            maxLines: 2,
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
    testWidgets('classifies the text and renders the tagged result', (tester) async {
      final stub = _StubClassifier(const [
        ItemSpan(text: 'Mail ', type: WiseTextItemType.text),
        ItemSpan(text: 'test@mail.com', type: WiseTextItemType.email),
        ItemSpan(text: ' now', type: WiseTextItemType.text),
      ]);

      await tester.pumpWidget(
        wrap(WiseTextWidget('Mail test@mail.com now', classified: true, classifier: stub)),
      );
      await tester.pumpAndSettle();

      expect(stub.callCount, 1);
      expect(stub.lastText, 'Mail test@mail.com now');
      expect(styledTextOf(tester).text, 'Mail <EMAIL>test@mail.com</EMAIL> now');
    });

    testWidgets('falls back to the original text when the classifier throws', (tester) async {
      await tester.pumpWidget(
        wrap(WiseTextWidget('Mail test@mail.com', classified: true, classifier: _ThrowingClassifier())),
      );
      await tester.pumpAndSettle();

      expect(styledTextOf(tester).text, 'Mail test@mail.com');
    });

    testWidgets('shows the original text while classification is pending', (tester) async {
      final deferred = _DeferredClassifier();

      await tester.pumpWidget(
        wrap(WiseTextWidget('Call Monday', classified: true, classifier: deferred)),
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
    testWidgets('renders a selectable StyledText backed by SelectableText', (tester) async {
      await tester.pumpWidget(wrap(const WiseTextWidget('Plain text', selectable: true)));
      await tester.pumpAndSettle();

      expect(styledTextOf(tester).selectable, isTrue);
      expect(find.byType(SelectableText), findsOneWidget);
    });

    testWidgets('classifies before rendering the selectable variant', (tester) async {
      final stub = _StubClassifier(const [
        ItemSpan(text: 'Monday', type: WiseTextItemType.date),
      ]);

      await tester.pumpWidget(
        wrap(WiseTextWidget('Monday', selectable: true, classified: true, classifier: stub)),
      );
      await tester.pumpAndSettle();

      expect(stub.callCount, 1);
      expect(styledTextOf(tester).text, '<DATE>Monday</DATE>');
      expect(styledTextOf(tester).selectable, isTrue);
    });
  });
}
