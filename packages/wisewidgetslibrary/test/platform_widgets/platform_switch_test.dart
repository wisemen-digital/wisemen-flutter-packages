import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wisewidgetslibrary/src/platform_widgets/platform_switch.dart';

class FakeBuildContext extends Fake implements BuildContext {}

class MockOnChangedCallback extends Mock {
  void call(bool value);
}

void main() {
  late MockOnChangedCallback mockOnChanged;

  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
  });

  setUp(() {
    mockOnChanged = MockOnChangedCallback();
  });

  testWidgets('createCupertinoWidget returns CupertinoSwitch', (tester) async {
    final platformSwitch = PlatformSwitch(
      value: true,
      onChanged: mockOnChanged.call,
      activeColor: CupertinoColors.activeBlue,
    );

    final cupertinoSwitch = platformSwitch.createCupertinoWidget(FakeBuildContext());

    expect(cupertinoSwitch, isA<CupertinoSwitch>());
    expect(cupertinoSwitch.value, true);
    expect(cupertinoSwitch.activeTrackColor, CupertinoColors.activeBlue);
  });

  testWidgets('createMaterialWidget returns Switch', (tester) async {
    final platformSwitch = PlatformSwitch(
      value: false,
      onChanged: mockOnChanged.call,
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
    );

    final materialSwitch = platformSwitch.createMaterialWidget(FakeBuildContext());

    expect(materialSwitch, isA<Switch>());
    expect(materialSwitch.value, false);
    expect(materialSwitch.activeColor, Colors.blue);
    expect(materialSwitch.inactiveThumbColor, Colors.grey);
  });

  testWidgets('calls onChanged callback when toggled (Material)', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformSwitch(
            value: false,
            onChanged: mockOnChanged.call,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    verify(() => mockOnChanged(true)).called(1);
  });

  testWidgets('calls onChanged callback when toggled (Cupertino)', (tester) async {
    await tester.pumpWidget(
      CupertinoApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return PlatformSwitch(
                value: false,
                onChanged: mockOnChanged.call,
              ).createCupertinoWidget(context);
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byType(CupertinoSwitch));
    await tester.pumpAndSettle();

    verify(() => mockOnChanged(true)).called(1);
  });
}