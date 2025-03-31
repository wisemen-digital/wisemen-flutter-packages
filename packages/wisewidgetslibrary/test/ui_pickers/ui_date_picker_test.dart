import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wisewidgetslibrary/src/ui_pickers/ui_date_picker.dart';

class MockOnChangedCallback extends Mock {
  void call(DateTime date);
}

void main() {
  late MockOnChangedCallback mockOnChanged;

  setUp(() {
    mockOnChanged = MockOnChangedCallback();
  });

  testWidgets('UIDatePicker displays initial state', (tester) async {
    final initialDate = DateTime(2025, 3, 16);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UIDatePicker(
            date: initialDate,
            onChanged: mockOnChanged.call,
          ),
        ),
      ),
    );

    final datePicker = tester.widget(find.byType(UIDatePicker)) as UIDatePicker;

    expect(datePicker.date, initialDate);
  });
}