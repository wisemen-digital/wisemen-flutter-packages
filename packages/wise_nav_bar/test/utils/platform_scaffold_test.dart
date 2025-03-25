import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_nav_bar/src/utils/utils.dart';

void main() {
  testWidgets('createCupertinoWidget returns CupertinoPageScaffold',
      (WidgetTester tester) async {
    const platformScaffold = PlatformScaffold(
      body: Text('Body'),
    );

    final materialWidget = platformScaffold
        .createCupertinoWidget(tester.element(find.byType(Container)));

    expect(materialWidget, isA<CupertinoPageScaffold>());
  });

  testWidgets('createMaterialWidget returns Scaffold',
      (WidgetTester tester) async {
    const platformScaffold = PlatformScaffold(
      body: Text('Body'),
    );

    final materialWidget = platformScaffold
        .createMaterialWidget(tester.element(find.byType(Container)));

    expect(materialWidget, isA<Scaffold>());
  });
}
