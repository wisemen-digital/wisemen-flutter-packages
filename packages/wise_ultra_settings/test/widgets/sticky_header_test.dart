import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wise_ultra_settings/src/features/settings/widgets/sticky_header.dart';

Widget wrapWithTheming(Widget child) {
  final theming = WiseTheming(
    supportedThemes: supportedThemes,
    targetPlatform: TargetPlatform.iOS,
  );

  return MaterialApp(
    theme: theming.lightTheme,
    darkTheme: theming.darkTheme,
    home: Scaffold(body: child),
  );
}

void main() {
  group('StickyHeader Widget Tests', () {
    test('StickyHeader class exists', () {
      expect(StickyHeader, isNotNull);
    });

    test('StickyHeader can be instantiated', () {
      const widget = StickyHeader(
        title: 'Test',
        isPinned: false,
        scrollPercentage: 0.0,
      );
      expect(widget, isA<StickyHeader>());
    });

    test('StickyHeader is a StatelessWidget', () {
      const widget = StickyHeader(
        title: 'Test',
        isPinned: false,
        scrollPercentage: 0.0,
      );
      expect(widget, isA<StatelessWidget>());
    });
  });

  group('StickyHeader Constructor Tests', () {
    test('required parameters only', () {
      const widget = StickyHeader(
        title: 'Section Title',
        isPinned: false,
        scrollPercentage: 0.0,
      );
      expect(widget.title, equals('Section Title'));
      expect(widget.isPinned, isFalse);
      expect(widget.scrollPercentage, equals(0.0));
    });

    test('with all parameters', () {
      const trailing = Icon(Icons.arrow_forward);
      const widget = StickyHeader(
        title: 'Title',
        isPinned: true,
        scrollPercentage: 0.5,
        outerPadding: EdgeInsets.all(20),
        trailing: trailing,
        trailingEnd: true,
        topPadding: 15,
        bottomPadding: 10,
      );
      expect(widget.title, equals('Title'));
      expect(widget.isPinned, isTrue);
      expect(widget.scrollPercentage, equals(0.5));
      expect(widget.outerPadding, equals(const EdgeInsets.all(20)));
      expect(widget.trailing, equals(trailing));
      expect(widget.trailingEnd, isTrue);
      expect(widget.topPadding, equals(15));
      expect(widget.bottomPadding, equals(10));
    });

    test('with key', () {
      const key = Key('header-key');
      const widget = StickyHeader(
        key: key,
        title: 'Test',
        isPinned: false,
        scrollPercentage: 0.0,
      );
      expect(widget.key, equals(key));
    });
  });

  group('StickyHeader Properties Tests', () {
    test('title property', () {
      const widget = StickyHeader(
        title: 'My Title',
        isPinned: false,
        scrollPercentage: 0.0,
      );
      expect(widget.title, equals('My Title'));
    });

    test('isPinned property', () {
      const widget1 = StickyHeader(
        title: 'Test',
        isPinned: true,
        scrollPercentage: 0.0,
      );
      const widget2 = StickyHeader(
        title: 'Test',
        isPinned: false,
        scrollPercentage: 0.0,
      );
      expect(widget1.isPinned, isTrue);
      expect(widget2.isPinned, isFalse);
    });

    test('scrollPercentage property', () {
      const widget = StickyHeader(
        title: 'Test',
        isPinned: false,
        scrollPercentage: 0.75,
      );
      expect(widget.scrollPercentage, equals(0.75));
    });

    test('trailing property', () {
      const trailing = Icon(Icons.settings);
      const widget = StickyHeader(
        title: 'Test',
        isPinned: false,
        scrollPercentage: 0.0,
        trailing: trailing,
      );
      expect(widget.trailing, equals(trailing));
    });

    test('trailingEnd property', () {
      const widget = StickyHeader(
        title: 'Test',
        isPinned: false,
        scrollPercentage: 0.0,
        trailingEnd: true,
      );
      expect(widget.trailingEnd, isTrue);
    });

    test('padding properties', () {
      const widget = StickyHeader(
        title: 'Test',
        isPinned: false,
        scrollPercentage: 0.0,
        topPadding: 20,
        bottomPadding: 15,
      );
      expect(widget.topPadding, equals(20));
      expect(widget.bottomPadding, equals(15));
    });
  });

  group('StickyHeader Edge Cases', () {
    test('empty title', () {
      const widget = StickyHeader(
        title: '',
        isPinned: false,
        scrollPercentage: 0.0,
      );
      expect(widget.title, equals(''));
    });

    test('scrollPercentage at 0', () {
      const widget = StickyHeader(
        title: 'Test',
        isPinned: false,
        scrollPercentage: 0.0,
      );
      expect(widget.scrollPercentage, equals(0.0));
    });

    test('scrollPercentage at 1', () {
      const widget = StickyHeader(
        title: 'Test',
        isPinned: true,
        scrollPercentage: 1.0,
      );
      expect(widget.scrollPercentage, equals(1.0));
    });

    test('scrollPercentage at 0.5', () {
      const widget = StickyHeader(
        title: 'Test',
        isPinned: true,
        scrollPercentage: 0.5,
      );
      expect(widget.scrollPercentage, equals(0.5));
    });

    test('very long title', () {
      const longTitle = 'This is a very long title that might wrap to multiple lines';
      const widget = StickyHeader(
        title: longTitle,
        isPinned: false,
        scrollPercentage: 0.0,
      );
      expect(widget.title, equals(longTitle));
    });

    test('title with special characters', () {
      const title = 'Settings & Preferences';
      const widget = StickyHeader(
        title: title,
        isPinned: false,
        scrollPercentage: 0.0,
      );
      expect(widget.title, equals(title));
    });

    test('title with unicode', () {
      const title = '设置';
      const widget = StickyHeader(
        title: title,
        isPinned: false,
        scrollPercentage: 0.0,
      );
      expect(widget.title, equals(title));
    });

    test('zero padding', () {
      const widget = StickyHeader(
        title: 'Test',
        isPinned: false,
        scrollPercentage: 0.0,
        topPadding: 0,
        bottomPadding: 0,
      );
      expect(widget.topPadding, equals(0));
      expect(widget.bottomPadding, equals(0));
    });

    test('negative scrollPercentage', () {
      const widget = StickyHeader(
        title: 'Test',
        isPinned: false,
        scrollPercentage: -0.5,
      );
      expect(widget.scrollPercentage, equals(-0.5));
    });

    test('scrollPercentage greater than 1', () {
      const widget = StickyHeader(
        title: 'Test',
        isPinned: false,
        scrollPercentage: 1.5,
      );
      expect(widget.scrollPercentage, equals(1.5));
    });
  });

  group('StickyHeader Rendering Tests', () {
    testWidgets('StickyHeader renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const StickyHeader(
            title: 'Test Header',
            isPinned: false,
            scrollPercentage: 0.0,
          ),
        ),
      );

      expect(find.byType(StickyHeader), findsOneWidget);
    });

    testWidgets('StickyHeader displays title', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const StickyHeader(
            title: 'My Section',
            isPinned: false,
            scrollPercentage: 0.0,
          ),
        ),
      );

      expect(find.text('My Section'), findsOneWidget);
    });

    testWidgets('StickyHeader renders Container', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const StickyHeader(
            title: 'Test',
            isPinned: false,
            scrollPercentage: 0.0,
          ),
        ),
      );

      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('StickyHeader renders Row', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const StickyHeader(
            title: 'Test',
            isPinned: false,
            scrollPercentage: 0.0,
          ),
        ),
      );

      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('StickyHeader with trailing widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const StickyHeader(
            title: 'Test',
            isPinned: false,
            scrollPercentage: 0.0,
            trailing: Icon(Icons.arrow_forward),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('StickyHeader without trailing widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const StickyHeader(
            title: 'Test',
            isPinned: false,
            scrollPercentage: 0.0,
          ),
        ),
      );

      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('StickyHeader with key', (WidgetTester tester) async {
      const key = Key('header-test');

      await tester.pumpWidget(
        wrapWithTheming(
          const StickyHeader(
            key: key,
            title: 'Test',
            isPinned: false,
            scrollPercentage: 0.0,
          ),
        ),
      );

      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets('StickyHeader pinned state', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const StickyHeader(
            title: 'Pinned Header',
            isPinned: true,
            scrollPercentage: 0.5,
          ),
        ),
      );

      expect(find.text('Pinned Header'), findsOneWidget);
    });

    testWidgets('StickyHeader unpinned state', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const StickyHeader(
            title: 'Unpinned Header',
            isPinned: false,
            scrollPercentage: 0.0,
          ),
        ),
      );

      expect(find.text('Unpinned Header'), findsOneWidget);
    });

    testWidgets('Multiple StickyHeaders render independently', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          Column(
            children: const [
              StickyHeader(
                title: 'Header 1',
                isPinned: false,
                scrollPercentage: 0.0,
              ),
              StickyHeader(
                title: 'Header 2',
                isPinned: true,
                scrollPercentage: 0.5,
              ),
            ],
          ),
        ),
      );

      expect(find.text('Header 1'), findsOneWidget);
      expect(find.text('Header 2'), findsOneWidget);
    });

    testWidgets('StickyHeader with empty title renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const StickyHeader(
            title: '',
            isPinned: false,
            scrollPercentage: 0.0,
          ),
        ),
      );

      expect(find.byType(StickyHeader), findsOneWidget);
    });

    testWidgets('StickyHeader with unicode title', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const StickyHeader(
            title: '设置',
            isPinned: false,
            scrollPercentage: 0.0,
          ),
        ),
      );

      expect(find.text('设置'), findsOneWidget);
    });

    testWidgets('StickyHeader with trailingEnd true', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const StickyHeader(
            title: 'Test',
            isPinned: false,
            scrollPercentage: 0.0,
            trailing: Icon(Icons.settings),
            trailingEnd: true,
          ),
        ),
      );

      expect(find.byType(Expanded), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('StickyHeader with trailingEnd false', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const StickyHeader(
            title: 'Test',
            isPinned: false,
            scrollPercentage: 0.0,
            trailing: Icon(Icons.settings),
            trailingEnd: false,
          ),
        ),
      );

      expect(find.byType(Flexible), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });
  });

  group('StickyHeader Type Checks', () {
    test('StickyHeader is StatelessWidget', () {
      const widget = StickyHeader(
        title: 'Test',
        isPinned: false,
        scrollPercentage: 0.0,
      );
      expect(widget, isA<StatelessWidget>());
    });

    test('StickyHeader is Widget', () {
      const widget = StickyHeader(
        title: 'Test',
        isPinned: false,
        scrollPercentage: 0.0,
      );
      expect(widget, isA<Widget>());
    });
  });

  group('StickyHeader State Combinations', () {
    test('pinned with 0% scroll', () {
      const widget = StickyHeader(
        title: 'Test',
        isPinned: true,
        scrollPercentage: 0.0,
      );
      expect(widget.isPinned, isTrue);
      expect(widget.scrollPercentage, equals(0.0));
    });

    test('pinned with 50% scroll', () {
      const widget = StickyHeader(
        title: 'Test',
        isPinned: true,
        scrollPercentage: 0.5,
      );
      expect(widget.isPinned, isTrue);
      expect(widget.scrollPercentage, equals(0.5));
    });

    test('pinned with 100% scroll', () {
      const widget = StickyHeader(
        title: 'Test',
        isPinned: true,
        scrollPercentage: 1.0,
      );
      expect(widget.isPinned, isTrue);
      expect(widget.scrollPercentage, equals(1.0));
    });

    test('unpinned with various scroll percentages', () {
      const widget1 = StickyHeader(
        title: 'Test',
        isPinned: false,
        scrollPercentage: 0.0,
      );
      const widget2 = StickyHeader(
        title: 'Test',
        isPinned: false,
        scrollPercentage: 0.5,
      );
      const widget3 = StickyHeader(
        title: 'Test',
        isPinned: false,
        scrollPercentage: 1.0,
      );

      expect(widget1.isPinned, isFalse);
      expect(widget2.isPinned, isFalse);
      expect(widget3.isPinned, isFalse);
    });
  });
}
