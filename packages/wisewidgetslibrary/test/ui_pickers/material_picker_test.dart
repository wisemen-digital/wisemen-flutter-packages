import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wisewidgetslibrary/src/ui_pickers/material_picker.dart';

class MockOnChangedCallback extends Mock {
  void call(int index);
}

void main() {
  late MockOnChangedCallback mockOnChanged;
  const items = ['Item 1', 'Item 2', 'Item 3'];

  setUp(() {
    mockOnChanged = MockOnChangedCallback();
  });

  testWidgets('MaterialPicker displays initial state', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MaterialPicker(
            value: 1,
            items: items,
            onChanged: mockOnChanged.call,
          ),
        ),
      ),
    );

    final picker = tester.widget(find.byType(MaterialPicker)) as MaterialPicker;

    expect(picker.items, items);
  });

  testWidgets('calls onChanged callback when item is selected', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MaterialPicker(
            value: 1,
            items: items,
            onChanged: mockOnChanged.call,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Item 2'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Item 3').last);
    await tester.pumpAndSettle();

    verify(() => mockOnChanged(2)).called(1);
  });
}