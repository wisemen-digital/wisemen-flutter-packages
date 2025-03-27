import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/src/widgets/labeled_text_field.dart';

void main() {
  Widget buildTestableWidget({
    required Widget child,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  testWidgets('displays label', (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        child: const LabeledTextField(
          label: 'Test Label',
        ),
      ),
    );

    expect(find.text('Test Label'), findsOneWidget);
  });

  testWidgets('displays text field', (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        child: const LabeledTextField(),
      ),
    );

    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('handles text input', (tester) async {
    final controller = TextEditingController();
    await tester.pumpWidget(
      buildTestableWidget(
        child: LabeledTextField(
          controller: controller,
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Test Input');
    expect(controller.text, 'Test Input');
  });

  testWidgets('handles onChanged callback', (tester) async {
    String? changedText;
    await tester.pumpWidget(
      buildTestableWidget(
        child: LabeledTextField(
          onChanged: (text) {
            changedText = text;
          },
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Changed Text');
    expect(changedText, 'Changed Text');
  });

  testWidgets('handles onFieldSubmitted callback', (tester) async {
    String? submittedText;
    await tester.pumpWidget(
      buildTestableWidget(
        child: LabeledTextField(
          onFieldSubmitted: (text) {
            submittedText = text;
          },
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Submitted Text');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    expect(submittedText, 'Submitted Text');
  });

  testWidgets('handles onEditingComplete callback', (tester) async {
    var editingComplete = false;
    await tester.pumpWidget(
      buildTestableWidget(
        child: LabeledTextField(
          onEditingComplete: () {
            editingComplete = true;
          },
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Editing Complete');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    expect(editingComplete, isTrue);
  });

  testWidgets('displays disabled text field', (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        child: const LabeledTextField(
          disabled: true,
        ),
      ),
    );

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.enabled, isFalse);
  });

  testWidgets('displays read-only text field', (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        child: const LabeledTextField(
          readOnly: true,
        ),
      ),
    );

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.readOnly, isTrue);
  });

  testWidgets('displays Android label', (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        child: const LabeledTextField(
          label: 'Android Label',
          showAndroidLabel: true,
        ),
      ),
    );

    expect(find.text('Android Label'), findsOneWidget);
  });
}
