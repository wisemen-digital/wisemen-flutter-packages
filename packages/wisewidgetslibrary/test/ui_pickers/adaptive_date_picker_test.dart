import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wisewidgetslibrary/src/ui_pickers/adaptive_date_picker.dart';

class MockOnChangedCallback extends Mock {
  void call(DateTime date);
}

void main() {
  late MockOnChangedCallback mockOnChanged;
  final initialDate = DateTime(2025, 3, 16);
  final firstDate = DateTime(2020, 3, 16);
  final lastDate = DateTime(2030, 3, 16);

  setUp(() {
    mockOnChanged = MockOnChangedCallback();
  });

  testWidgets('AdaptiveDatePicker displays initial state', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AdaptiveDatePicker(
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
            onChanged: mockOnChanged.call,
          ),
        ),
      ),
    );

    final picker = tester.widget(find.byType(AdaptiveDatePicker)) as AdaptiveDatePicker;

    expect(picker.initialDate, initialDate);
    expect(picker.firstDate, firstDate);
    expect(picker.lastDate, lastDate);
  });
}
