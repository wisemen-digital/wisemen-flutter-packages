import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wisewidgetslibrary/src/models/dropdown_model.dart';
import 'package:wisewidgetslibrary/src/platform_widgets/platform_dropdown_picker.dart';

class MockDropdownModel extends Mock implements DropdownModel {
  @override
  String getString(BuildContext context) => 'Option';
}

void main() {
  late MockDropdownModel option1;
  late MockDropdownModel option2;
  late FocusNode focusNode;

  setUp(() {
    option1 = MockDropdownModel();
    option2 = MockDropdownModel();
    focusNode = FocusNode();
  });

  Widget buildTestableWidget({
    required Widget child,
    required List<DropdownModel> options,
    required void Function(DropdownModel? option) onChanged,
    DropdownModel? selected,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: PlatformDropdownPicker<DropdownModel>(
          options: options,
          onChanged: onChanged,
          borderRadius: BorderRadius.circular(8),
          focusNode: focusNode,
          selected: selected,
          child: child,
        ),
      ),
    );
  }

  PlatformDropdownPicker buildTestablePlatformDropdownPicker({
    required Widget child,
    required List<DropdownModel> options,
    required void Function(DropdownModel? option) onChanged,
    DropdownModel? selected,
  }) {
    return PlatformDropdownPicker<DropdownModel>(
      options: options,
      onChanged: onChanged,
      borderRadius: BorderRadius.circular(8),
      focusNode: focusNode,
      selected: selected,
      child: child,
    );
  }

  testWidgets('displays child widget', (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        child: const Text('Open Dropdown'),
        options: [option1, option2],
        onChanged: (_) {},
      ),
    );

    expect(find.text('Open Dropdown'), findsOneWidget);
  });

  testWidgets('opens dropdown menu on tap', (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        child: const Text('Open Dropdown'),
        options: [option1, option2],
        onChanged: (_) {},
      ),
    );

    await tester.tap(find.text('Open Dropdown'));
    await tester.pumpAndSettle();

    expect(find.text('Option'), findsNWidgets(2));
  });

  testWidgets('calls onChanged callback when an option is selected', (
    tester,
  ) async {
    DropdownModel? selectedOption;
    await tester.pumpWidget(
      buildTestableWidget(
        child: const Text('Open Dropdown'),
        options: [option1, option2],
        onChanged: (option) {
          selectedOption = option;
        },
      ),
    );

    await tester.tap(find.text('Open Dropdown'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Option').first);
    await tester.pumpAndSettle();

    expect(selectedOption, equals(option1));
  });

  testWidgets('cupertinoWidget displays child widget', (tester) async {
    await tester.pumpWidget(
      CupertinoApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return buildTestablePlatformDropdownPicker(
                child: const Text('Open Dropdown'),
                options: [option1, option2],
                onChanged: (_) {},
              ).createCupertinoWidget(context);
            },
          ),
        ),
      ),
    );

    expect(find.text('Open Dropdown'), findsOneWidget);
  });

  testWidgets('(cupertino) opens dropdown menu on tap', (tester) async {
    await tester.pumpWidget(
      CupertinoApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return buildTestablePlatformDropdownPicker(
                child: const Text('Open Dropdown'),
                options: [option1, option2],
                onChanged: (_) {},
              ).createCupertinoWidget(context);
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open Dropdown'));
    await tester.pumpAndSettle();

    expect(find.text('Option'), findsNWidgets(2));
  });

  testWidgets(
    '(cupertino) calls onChanged callback when an option is selected',
    (tester) async {
      DropdownModel? selectedOption;

      await tester.pumpWidget(
        CupertinoApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return buildTestablePlatformDropdownPicker(
                  child: const Text('Open Dropdown'),
                  options: [option1, option2],
                  onChanged: (option) {
                    selectedOption = option;
                  },
                ).createCupertinoWidget(context);
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Option').first);
      await tester.pumpAndSettle();

      expect(selectedOption, equals(option1));
    },
  );
}
