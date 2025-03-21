import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisecore/src/extensions/scroll_extensions.dart';

void main() {
  group('ScrollExtensions', () {
    testWidgets('scrollToBottom should scroll to the bottom of the list',
        (WidgetTester tester) async {
      final controller = ScrollController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              controller: controller,
              itemCount: 100,
              itemBuilder: (context, index) =>
                  ListTile(title: Text('Item $index')),
            ),
          ),
        ),
      );

      unawaited(
          controller.scrollToBottom(duration: const Duration(seconds: 1)),);
      await tester.pumpAndSettle();

      expect(controller.offset, controller.position.maxScrollExtent);
    });

    testWidgets('scrollToTop should scroll to the top of the list',
        (WidgetTester tester) async {
      final controller = ScrollController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              controller: controller,
              itemCount: 100,
              itemBuilder: (context, index) =>
                  ListTile(title: Text('Item $index')),
            ),
          ),
        ),
      );

      unawaited(
          controller.scrollToBottom(duration: const Duration(seconds: 1)),);
      await tester.pumpAndSettle();

      unawaited(controller.scrollToTop(duration: const Duration(seconds: 1)));
      await tester.pumpAndSettle();

      expect(controller.offset, controller.position.minScrollExtent);
    });
  });
}
