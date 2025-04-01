import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wisewidgetslibrary/src/platform_widgets/platform_search_bar.dart';

class FakeBuildContext extends Fake implements BuildContext {}

class MockOnSearchChangedCallback extends Mock {
  void call(String value);
}

void main() {
  late MockOnSearchChangedCallback mockOnSearchChanged;

  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
  });

  setUp(() {
    mockOnSearchChanged = MockOnSearchChangedCallback();
  });

  testWidgets('createCupertinoWidget displays initial state', (tester) async {
    await tester.pumpWidget(
      CupertinoApp(
        home: Scaffold(
          body: PlatformSearchBar(
            backgroundColor: Colors.white,
            textColor: Colors.black,
            placeholderColor: Colors.grey,
            buttonColor: Colors.blue,
            onSearchChanged: mockOnSearchChanged.call,
          ).createCupertinoWidget(FakeBuildContext()),
        ),
      ),
    );

    expect(find.byType(CupertinoSearchTextField), findsOneWidget);
  });

  testWidgets('createMaterialWidget displays initial state', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformSearchBar(
            backgroundColor: Colors.white,
            textColor: Colors.black,
            placeholderColor: Colors.grey,
            buttonColor: Colors.blue,
            onSearchChanged: mockOnSearchChanged.call,
          ).createMaterialWidget(FakeBuildContext()),
        ),
      ),
    );

    expect(find.byType(SearchBar), findsOneWidget);
  });

  testWidgets('calls onSearchChanged callback when text changes (Cupertino)',
      (tester) async {
    await tester.pumpWidget(
      CupertinoApp(
        home: Scaffold(
          body: PlatformSearchBar(
            backgroundColor: Colors.white,
            textColor: Colors.black,
            placeholderColor: Colors.grey,
            buttonColor: Colors.blue,
            onSearchChanged: mockOnSearchChanged.call,
          ).createCupertinoWidget(FakeBuildContext()),
        ),
      ),
    );

    await tester.enterText(find.byType(CupertinoSearchTextField), 'test');
    await tester.pumpAndSettle();

    verify(() => mockOnSearchChanged('test')).called(1);
  });

  testWidgets(
      'calls onSearchChanged callback with empty string when canceled (Cupertino)',
      (tester) async {
    await tester.pumpWidget(
      CupertinoApp(
        home: Scaffold(
          body: PlatformSearchBar(
            backgroundColor: Colors.white,
            textColor: Colors.black,
            placeholderColor: Colors.grey,
            buttonColor: Colors.blue,
            onSearchChanged: mockOnSearchChanged.call,
          ).createCupertinoWidget(FakeBuildContext()),
        ),
      ),
    );

    await tester.enterText(find.byType(CupertinoSearchTextField), 'test');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    verify(() => mockOnSearchChanged('')).called(1);
  });

  testWidgets('calls onSearchChanged callback when text changes (Material)',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformSearchBar(
            backgroundColor: Colors.white,
            textColor: Colors.black,
            placeholderColor: Colors.grey,
            buttonColor: Colors.blue,
            onSearchChanged: mockOnSearchChanged.call,
          ).createMaterialWidget(FakeBuildContext()),
        ),
      ),
    );

    await tester.enterText(find.byType(SearchBar), 'test');
    await tester.pumpAndSettle();

    verify(() => mockOnSearchChanged('test')).called(1);
  });

  testWidgets(
      'calls onSearchChanged callback with empty string when cancel is clicked (Material)',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformSearchBar(
            backgroundColor: Colors.white,
            textColor: Colors.black,
            placeholderColor: Colors.grey,
            buttonColor: Colors.blue,
            onSearchChanged: mockOnSearchChanged.call,
          ).createMaterialWidget(FakeBuildContext()),
        ),
      ),
    );

    await tester.enterText(find.byType(SearchBar), 'test');
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.clear));
    await tester.pumpAndSettle();

    verify(() => mockOnSearchChanged('')).called(1);
  });
}
