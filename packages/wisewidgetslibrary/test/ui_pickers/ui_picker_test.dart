import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wisewidgetslibrary/src/ui_pickers/ui_picker.dart';

class MockOnChangedCallback extends Mock {
  void call(int index);
}

void main() {
  late MockOnChangedCallback mockOnChanged;
  const items = ['Item 1', 'Item 2', 'Item 3'];

  setUp(() {
    mockOnChanged = MockOnChangedCallback();
  });

  testWidgets('UIPicker displays initial state', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UIPicker(
            items: items,
            selectedIndex: 1,
            onChanged: mockOnChanged.call,
          ),
        ),
      ),
    );

    final picker = tester.widget(find.byType(UIPicker)) as UIPicker;

    expect(picker.items, items);
  });
}
