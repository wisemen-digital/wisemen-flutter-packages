import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/src/models/dropdown_model.dart';

class TestDropdownModel implements DropdownModel {
  @override
  String getString(BuildContext context) {
    return 'Test String';
  }

  @override
  Widget? get icon => const Icon(Icons.abc);
}

void main() {
  testWidgets('DropdownModel getString returns correct string',
      (WidgetTester tester) async {
    final model = TestDropdownModel();

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            expect(model.getString(context), 'Test String');
            return Container();
          },
        ),
      ),
    );
  });

  test('DropdownModel icon returns a icon', () {
    final model = TestDropdownModel();
    expect(model.icon, isA<Icon>());
    final icon = model.icon! as Icon;
    expect(icon.icon, Icons.abc);
  });
}
