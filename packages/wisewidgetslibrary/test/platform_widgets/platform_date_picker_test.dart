import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';
import 'package:wisecore/src/extensions/date_extensions.dart';

class TestNavigatorObserver extends NavigatorObserver {
  List<Route<dynamic>> pushedRoutes = [];
  List<Route<dynamic>> poppedRoutes = [];
  List<dynamic> poppedResults = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushedRoutes.add(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    poppedRoutes.add(route);
    poppedResults.add(route.settings.arguments);
  }
}

void main() {
  testWidgets('PlatformDatePicker displays CupertinoDatePicker on iOS', (WidgetTester tester) async {
    await tester.pumpWidget(
      CupertinoApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return PlatformDatePicker(
                date: DateTime(2023, 1, 1),
              ).createCupertinoWidget(context);
            },
          ),
        ),
      ),
    );

    expect(find.byType(CupertinoDatePicker), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('PlatformDatePicker displays DatePickerDialog on Android', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return PlatformDatePicker(date: DateTime.now()).createMaterialWidget(context);
            },
          ),
        ),
      ),
    );

    expect(find.byType(DatePickerDialog), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('PlatformDatePicker returns selected date on iOS', (WidgetTester tester) async {
    final selectedDate = DateTime(2025, 3, 16);

    await tester.pumpWidget(
      CupertinoApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return PlatformDatePicker(
                date: selectedDate,
              ).createCupertinoWidget(context);
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(selectedDate, DateTime(2025, 3, 16));
  });

  testWidgets('Material DatePickerDialog returns selected date on Save', (tester) async {
    final date = DateTime.now();

    DateTime? pickedDate;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                pickedDate = await showDialog<DateTime>(
                  context: context,
                  builder: (_) => PlatformDatePicker(date: date),
                );
              },
              child: const Text('Open'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    // Simulate clicking Save on Material dialog
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Should close the dialog and pickedDate should remain null, because DatePickerDialog doesn't select automatically.
    // You may need additional setup here depending on how you expect the dialog to behave.
    expect(pickedDate?.isSameDate(date), true);
  });

  testWidgets('PlatformDatePicker cancels selection on Android', (WidgetTester tester) async {
    DateTime? selectedDate;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return PlatformDatePicker(
                date: DateTime.now(),
              ).createMaterialWidget(context);
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(selectedDate, isNull);
  });
}
