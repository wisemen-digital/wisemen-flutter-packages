import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wisewidgetslibrary/src/ui_pickers/material_date_picker.dart';

class MockOnChangedCallback extends Mock {
  void call(DateTime date);
}

void main() {
  late MockOnChangedCallback mockOnChanged;

  setUp(() {
    mockOnChanged = MockOnChangedCallback();
  });

  testWidgets('MaterialDatePicker displays initial state', (tester) async {
    final initialDate = DateTime(2023, 3, 16);
    final firstDate = DateTime(2020, 3, 16);
    final lastDate = DateTime(2025, 3, 16);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MaterialDatePicker(
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
            onChanged: mockOnChanged.call,
          ),
        ),
      ),
    );

    final picker =
        tester.widget(find.byType(MaterialDatePicker)) as MaterialDatePicker;

    expect(picker.initialDate, initialDate);
    expect(picker.firstDate, firstDate);
    expect(picker.lastDate, lastDate);
  });
}
