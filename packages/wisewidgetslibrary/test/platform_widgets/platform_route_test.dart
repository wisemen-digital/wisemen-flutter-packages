import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

void main() {
  late Widget testWidget;
  late Widget currentWidget;

  setUp(() {
    testWidget = const Scaffold(body: Text('New Page'));
    currentWidget = const Scaffold(body: Text('Current Page'));
  });

  testWidgets('Returns MaterialPageRoute on Web', (tester) async {
    final route = platformRoute<dynamic>(route: testWidget, isWeb: true);
    expect(route, isA<MaterialPageRoute<dynamic>>());
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('Returns PageTransition on Android without currentRoute',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    final route = platformRoute<dynamic>(route: testWidget);
    expect(route, isA<PageTransition<dynamic>>());
    expect((route as PageTransition).type, PageTransitionType.rightToLeft);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('Returns PageTransition on Android with currentRoute',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    final route =
        platformRoute<dynamic>(route: testWidget, currentRoute: currentWidget);
    expect(route, isA<PageTransition<dynamic>>());
    expect(
      (route as PageTransition).type,
      PageTransitionType.rightToLeftJoined,
    );

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('Returns CupertinoPageRoute on iOS', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    final route = platformRoute<dynamic>(route: testWidget);
    expect(route, isA<CupertinoPageRoute<dynamic>>());

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('Returns MaterialPageRoute for other platforms', (tester) async {
    debugDefaultTargetPlatformOverride =
        TargetPlatform.fuchsia; // Simulating an unknown platform

    final route = platformRoute<dynamic>(route: testWidget);
    expect(route, isA<MaterialPageRoute<dynamic>>());

    debugDefaultTargetPlatformOverride = null;
  });
}
