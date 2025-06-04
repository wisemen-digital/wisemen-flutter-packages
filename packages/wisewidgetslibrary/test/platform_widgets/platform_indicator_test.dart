import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/src/platform_widgets/platform_indicator.dart';

void main() {
  testWidgets(
    'createCupertinoWidget creates CupertinoActivityIndicator with correct properties',
    (tester) async {
      const radius = 15.0;
      const color = CupertinoColors.activeBlue;

      const PlatformLoadingIndicator(
        radius: radius,
        color: color,
      );

      await tester.pumpWidget(
        CupertinoApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return const PlatformLoadingIndicator(
                  radius: radius,
                  color: color,
                ).createCupertinoWidget(context);
              },
            ),
          ),
        ),
      );

      final cupertinoActivityIndicator = tester
          .widget<CupertinoActivityIndicator>(
            find.byType(CupertinoActivityIndicator),
          );
      expect(cupertinoActivityIndicator.radius, equals(radius));
      expect(cupertinoActivityIndicator.color, equals(color));
    },
  );

  testWidgets(
    'createMaterialWidget creates CircularProgressIndicator with correct properties',
    (tester) async {
      const radius = 15.0;
      const color = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return const PlatformLoadingIndicator(
                  radius: radius,
                  color: color,
                ).createMaterialWidget(context);
              },
            ),
          ),
        ),
      );

      final circularProgressIndicator = tester
          .widget<CircularProgressIndicator>(
            find.byType(CircularProgressIndicator),
          );
      expect(circularProgressIndicator.value, isNull);
      expect(circularProgressIndicator.strokeWidth, equals(radius / 4));
      expect(circularProgressIndicator.valueColor?.value, equals(color));
    },
  );
}
