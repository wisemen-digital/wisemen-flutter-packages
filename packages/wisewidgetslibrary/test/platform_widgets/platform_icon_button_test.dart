import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wisewidgetslibrary/src/platform_widgets/platform_icon_button.dart';

class MockCallback extends Mock {
  void call();
}

void main() {
  late VoidCallback onPressed;

  setUp(() {
    onPressed = MockCallback();
  });

  Widget buildTestableWidget({
    required Widget icon,
    required VoidCallback onPressed,
    Color backgroundColor = Colors.transparent,
    Color? splashColor,
    double? splashRadius,
    double minSize = 5,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: PlatformIconButton(
          icon: icon,
          onPressed: onPressed,
          backgroundColor: backgroundColor,
          splashColor: splashColor,
          splashRadius: splashRadius,
          minSize: minSize,
        ),
      ),
    );
  }

  PlatformIconButton buildTestablePlatformIconButton({
    required Widget icon,
    required VoidCallback onPressed,
    Color backgroundColor = Colors.transparent,
    Color? splashColor,
    double? splashRadius,
    double minSize = 5,
  }) {
    return PlatformIconButton(
      icon: icon,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      splashColor: splashColor,
      splashRadius: splashRadius,
      minSize: minSize,
    );
  }

  testWidgets('displays icon widget', (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        icon: const Icon(Icons.add),
        onPressed: onPressed,
      ),
    );

    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('calls onPressed callback when tapped', (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        icon: const Icon(Icons.add),
        onPressed: onPressed,
      ),
    );

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    verify(() => onPressed()).called(1);
  });

  testWidgets('cupertinoWidget displays icon widget', (tester) async {
    await tester.pumpWidget(CupertinoApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return buildTestablePlatformIconButton(
              icon: const Icon(Icons.add),
              onPressed: onPressed,
            ).createCupertinoWidget(context);
          },
        ),
      ),
    ));

    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('(cupertino) calls onPressed callback when tapped', (tester) async {
    await tester.pumpWidget(
      CupertinoApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return buildTestablePlatformIconButton(
                icon: const Icon(Icons.add),
                onPressed: onPressed,
              ).createCupertinoWidget(context);
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    verify(() => onPressed()).called(1);
  });
}