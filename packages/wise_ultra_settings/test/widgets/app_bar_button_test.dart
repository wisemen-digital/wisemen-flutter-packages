import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wise_ultra_settings/src/features/settings/widgets/app_bar_button.dart';

Widget wrapWithTheming(Widget child) {
  final theming = WiseTheming(
    supportedThemes: supportedThemes,
    targetPlatform: TargetPlatform.iOS,
  );

  return MaterialApp(
    theme: theming.lightTheme,
    darkTheme: theming.darkTheme,
    home: Scaffold(
      appBar: AppBar(actions: [child]),
    ),
  );
}

void main() {
  group('AppBarButton Widget Tests', () {
    test('AppBarButton class exists', () {
      expect(AppBarButton, isNotNull);
    });

    test('AppBarButton can be instantiated', () {
      final widget = AppBarButton(
        title: 'Done',
        onPressed: () {},
      );
      expect(widget, isA<AppBarButton>());
    });

    test('AppBarButton is a StatelessWidget', () {
      final widget = AppBarButton(
        title: 'Done',
        onPressed: () {},
      );
      expect(widget, isA<StatelessWidget>());
    });

    test('AppBarButton is a Widget', () {
      final widget = AppBarButton(
        title: 'Done',
        onPressed: () {},
      );
      expect(widget, isA<Widget>());
    });
  });

  group('AppBarButton Constructor Tests', () {
    test('required parameters only', () {
      final widget = AppBarButton(
        title: 'Save',
        onPressed: () {},
      );
      expect(widget.title, equals('Save'));
      expect(widget.onPressed, isNotNull);
      expect(widget.isLoading, isFalse);
      expect(widget.isDisabled, isFalse);
      expect(widget.isBold, isFalse);
    });

    test('with all parameters', () {
      final widget = AppBarButton(
        title: 'Done',
        onPressed: () {},
        isLoading: true,
        isDisabled: true,
        isBold: true,
      );
      expect(widget.title, equals('Done'));
      expect(widget.isLoading, isTrue);
      expect(widget.isDisabled, isTrue);
      expect(widget.isBold, isTrue);
    });

    test('with key', () {
      const key = Key('button-key');
      final widget = AppBarButton(
        key: key,
        title: 'Cancel',
        onPressed: () {},
      );
      expect(widget.key, equals(key));
    });

    test('with null onPressed', () {
      const widget = AppBarButton(
        title: 'Disabled',
        onPressed: null,
      );
      expect(widget.onPressed, isNull);
    });

    test('with isLoading true', () {
      final widget = AppBarButton(
        title: 'Loading',
        onPressed: () {},
        isLoading: true,
      );
      expect(widget.isLoading, isTrue);
    });

    test('with isDisabled true', () {
      final widget = AppBarButton(
        title: 'Disabled',
        onPressed: () {},
        isDisabled: true,
      );
      expect(widget.isDisabled, isTrue);
    });

    test('with isBold true', () {
      final widget = AppBarButton(
        title: 'Bold',
        onPressed: () {},
        isBold: true,
      );
      expect(widget.isBold, isTrue);
    });
  });

  group('AppBarButton Properties Tests', () {
    test('title property is accessible', () {
      final widget = AppBarButton(
        title: 'Test Title',
        onPressed: () {},
      );
      expect(widget.title, equals('Test Title'));
    });

    test('onPressed property is accessible', () {
      void callback() {}
      final widget = AppBarButton(
        title: 'Test',
        onPressed: callback,
      );
      expect(widget.onPressed, equals(callback));
    });

    test('isLoading property is accessible', () {
      final widget = AppBarButton(
        title: 'Test',
        onPressed: () {},
        isLoading: true,
      );
      expect(widget.isLoading, isTrue);
    });

    test('isDisabled property is accessible', () {
      final widget = AppBarButton(
        title: 'Test',
        onPressed: () {},
        isDisabled: true,
      );
      expect(widget.isDisabled, isTrue);
    });

    test('isBold property is accessible', () {
      final widget = AppBarButton(
        title: 'Test',
        onPressed: () {},
        isBold: true,
      );
      expect(widget.isBold, isTrue);
    });

    test('default values', () {
      final widget = AppBarButton(
        title: 'Test',
        onPressed: () {},
      );
      expect(widget.isLoading, isFalse);
      expect(widget.isDisabled, isFalse);
      expect(widget.isBold, isFalse);
    });
  });

  group('AppBarButton Edge Cases', () {
    test('empty title', () {
      final widget = AppBarButton(
        title: '',
        onPressed: () {},
      );
      expect(widget.title, equals(''));
    });

    test('very long title', () {
      const longTitle = 'This is a very long title that might not fit';
      final widget = AppBarButton(
        title: longTitle,
        onPressed: () {},
      );
      expect(widget.title, equals(longTitle));
    });

    test('title with special characters', () {
      const title = 'Done! ✓';
      final widget = AppBarButton(
        title: title,
        onPressed: () {},
      );
      expect(widget.title, equals(title));
    });

    test('title with unicode characters', () {
      const title = '完成';
      final widget = AppBarButton(
        title: title,
        onPressed: () {},
      );
      expect(widget.title, equals(title));
    });

    test('both isLoading and isDisabled true', () {
      final widget = AppBarButton(
        title: 'Test',
        onPressed: () {},
        isLoading: true,
        isDisabled: true,
      );
      expect(widget.isLoading, isTrue);
      expect(widget.isDisabled, isTrue);
    });

    test('all boolean flags true', () {
      final widget = AppBarButton(
        title: 'Test',
        onPressed: () {},
        isLoading: true,
        isDisabled: true,
        isBold: true,
      );
      expect(widget.isLoading, isTrue);
      expect(widget.isDisabled, isTrue);
      expect(widget.isBold, isTrue);
    });
  });

  group('AppBarButton Multiple Instances Tests', () {
    test('multiple instances with different titles', () {
      final widget1 = AppBarButton(title: 'Save', onPressed: () {});
      final widget2 = AppBarButton(title: 'Cancel', onPressed: () {});
      final widget3 = AppBarButton(title: 'Done', onPressed: () {});

      expect(widget1.title, equals('Save'));
      expect(widget2.title, equals('Cancel'));
      expect(widget3.title, equals('Done'));
    });

    test('multiple instances with different states', () {
      final widget1 =
          AppBarButton(title: 'Test', onPressed: () {}, isLoading: true);
      final widget2 =
          AppBarButton(title: 'Test', onPressed: () {}, isDisabled: true);
      final widget3 =
          AppBarButton(title: 'Test', onPressed: () {}, isBold: true);

      expect(widget1.isLoading, isTrue);
      expect(widget2.isDisabled, isTrue);
      expect(widget3.isBold, isTrue);
    });
  });

  group('AppBarButton Rendering Tests', () {
    testWidgets('AppBarButton renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          AppBarButton(
            title: 'Done',
            onPressed: () {},
          ),
        ),
      );

      expect(find.byType(AppBarButton), findsOneWidget);
    });

    testWidgets('AppBarButton renders with key', (WidgetTester tester) async {
      const key = Key('button-test');

      await tester.pumpWidget(
        wrapWithTheming(
          AppBarButton(
            key: key,
            title: 'Done',
            onPressed: () {},
          ),
        ),
      );

      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets('AppBarButton displays title', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          AppBarButton(
            title: 'Save',
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('AppBarButton renders Stack', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          AppBarButton(
            title: 'Done',
            onPressed: () {},
          ),
        ),
      );

      expect(find.byType(Stack), findsWidgets);
      expect(find.byType(AppBarButton), findsOneWidget);
    });

    testWidgets('AppBarButton renders AnimatedOpacity widgets',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          AppBarButton(
            title: 'Done',
            onPressed: () {},
          ),
        ),
      );

      expect(find.byType(AnimatedOpacity), findsNWidgets(2));
    });

    testWidgets('AppBarButton renders CupertinoButton',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          AppBarButton(
            title: 'Done',
            onPressed: () {},
          ),
        ),
      );

      expect(find.byType(CupertinoButton), findsOneWidget);
    });

    testWidgets('AppBarButton tap triggers callback',
        (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        wrapWithTheming(
          AppBarButton(
            title: 'Done',
            onPressed: () {
              tapped = true;
            },
          ),
        ),
      );

      await tester.tap(find.text('Done'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('AppBarButton disabled does not trigger callback',
        (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        wrapWithTheming(
          AppBarButton(
            title: 'Done',
            onPressed: () {
              tapped = true;
            },
            isDisabled: true,
          ),
        ),
      );

      await tester.tap(find.text('Done'));
      await tester.pump();

      expect(tapped, isFalse);
    });

    testWidgets('AppBarButton with null onPressed does not crash',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const AppBarButton(
            title: 'Done',
            onPressed: null,
          ),
        ),
      );

      expect(find.text('Done'), findsOneWidget);
    });

    testWidgets('AppBarButton multiple taps', (WidgetTester tester) async {
      var tapCount = 0;

      await tester.pumpWidget(
        wrapWithTheming(
          AppBarButton(
            title: 'Done',
            onPressed: () {
              tapCount++;
            },
          ),
        ),
      );

      await tester.tap(find.text('Done'));
      await tester.pump();
      await tester.tap(find.text('Done'));
      await tester.pump();
      await tester.tap(find.text('Done'));
      await tester.pump();

      expect(tapCount, equals(3));
    });

    testWidgets('AppBarButton with different titles render independently',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              actions: [
                AppBarButton(title: 'Save', onPressed: () {}),
                AppBarButton(title: 'Cancel', onPressed: () {}),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Save'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('AppBarButton with empty title renders',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          AppBarButton(
            title: '',
            onPressed: () {},
          ),
        ),
      );

      expect(find.byType(AppBarButton), findsOneWidget);
    });

    testWidgets('AppBarButton with special characters renders',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          AppBarButton(
            title: 'Done! ✓',
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Done! ✓'), findsOneWidget);
    });

    testWidgets('AppBarButton with unicode characters renders',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          AppBarButton(
            title: '完成',
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('完成'), findsOneWidget);
    });
  });

  group('AppBarButton Type Checks', () {
    test('AppBarButton is StatelessWidget', () {
      final widget = AppBarButton(title: 'Test', onPressed: () {});
      expect(widget, isA<StatelessWidget>());
    });

    test('AppBarButton is Widget', () {
      final widget = AppBarButton(title: 'Test', onPressed: () {});
      expect(widget, isA<Widget>());
    });
  });

  group('AppBarButton State Combinations', () {
    test('not loading, not disabled, not bold', () {
      final widget = AppBarButton(
        title: 'Test',
        onPressed: () {},
      );
      expect(widget.isLoading, isFalse);
      expect(widget.isDisabled, isFalse);
      expect(widget.isBold, isFalse);
    });

    test('loading, not disabled, not bold', () {
      final widget = AppBarButton(
        title: 'Test',
        onPressed: () {},
        isLoading: true,
      );
      expect(widget.isLoading, isTrue);
      expect(widget.isDisabled, isFalse);
      expect(widget.isBold, isFalse);
    });

    test('not loading, disabled, not bold', () {
      final widget = AppBarButton(
        title: 'Test',
        onPressed: () {},
        isDisabled: true,
      );
      expect(widget.isLoading, isFalse);
      expect(widget.isDisabled, isTrue);
      expect(widget.isBold, isFalse);
    });

    test('not loading, not disabled, bold', () {
      final widget = AppBarButton(
        title: 'Test',
        onPressed: () {},
        isBold: true,
      );
      expect(widget.isLoading, isFalse);
      expect(widget.isDisabled, isFalse);
      expect(widget.isBold, isTrue);
    });
  });
}
