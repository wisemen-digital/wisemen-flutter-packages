import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/src/widgets/animated_clip_rect.dart';

void main() {
  testWidgets('AnimatedClipRect opens and closes vertically',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedClipRect(
          open: true,
          child: Container(height: 100, width: 100, color: Colors.red),
        ),
      ),
    );

    expect(find.byType(AnimatedClipRect), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);

    await tester.pumpAndSettle();

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedClipRect(
          open: false,
          child: Container(height: 100, width: 100, color: Colors.red),
        ),
      ),
    );

    await tester.pumpAndSettle();
  });

  testWidgets('AnimatedClipRect opens and closes horizontally',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedClipRect(
          open: true,
          horizontalAnimation: true,
          verticalAnimation: false,
          child: Container(height: 100, width: 100, color: Colors.red),
        ),
      ),
    );

    expect(find.byType(AnimatedClipRect), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);

    await tester.pumpAndSettle();

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedClipRect(
          open: false,
          horizontalAnimation: true,
          verticalAnimation: false,
          child: Container(height: 100, width: 100, color: Colors.red),
        ),
      ),
    );

    await tester.pumpAndSettle();
  });

  testWidgets('AnimatedClipRect respects alignment',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedClipRect(
          open: true,
          alignment: Alignment.topLeft,
          child: Container(height: 100, width: 100, color: Colors.red),
        ),
      ),
    );

    expect(find.byType(AnimatedClipRect), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);

    await tester.pumpAndSettle();
  });

  testWidgets('AnimatedClipRect respects custom duration and curve',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedClipRect(
          open: true,
          duration: const Duration(milliseconds: 500),
          curve: Curves.bounceIn,
          child: Container(height: 100, width: 100, color: Colors.red),
        ),
      ),
    );

    expect(find.byType(AnimatedClipRect), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);

    await tester.pumpAndSettle();
  });

  testWidgets('AnimatedClipRect respects reverse duration and reverse curve',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedClipRect(
          open: true,
          reverseDuration: const Duration(milliseconds: 200),
          reverseCurve: Curves.easeOut,
          child: Container(height: 100, width: 100, color: Colors.red),
        ),
      ),
    );

    expect(find.byType(AnimatedClipRect), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);

    await tester.pumpAndSettle();

    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedClipRect(
          open: false,
          reverseDuration: const Duration(milliseconds: 200),
          reverseCurve: Curves.easeOut,
          child: Container(height: 100, width: 100, color: Colors.red),
        ),
      ),
    );

    await tester.pumpAndSettle();
  });
}
