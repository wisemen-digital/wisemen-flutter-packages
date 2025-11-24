import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wise_ultra_settings/src/features/settings/widgets/initials.dart';

Widget wrapWithTheming(Widget child) {
  final theming = WiseTheming(
    supportedThemes: supportedThemes,
    targetPlatform: TargetPlatform.iOS,
  );

  return MaterialApp(
    theme: theming.lightTheme,
    darkTheme: theming.darkTheme,
    home: Scaffold(body: child),
  );
}

void main() {
  group('Initials Widget Tests', () {
    test('Initials class exists', () {
      expect(Initials, isNotNull);
    });

    test('Initials can be instantiated', () {
      const widget = Initials(firstName: 'John', lastName: 'Doe');
      expect(widget, isA<Initials>());
    });

    test('Initials is a StatelessWidget', () {
      const widget = Initials(firstName: 'John', lastName: 'Doe');
      expect(widget, isA<StatelessWidget>());
    });

    test('Initials is a Widget', () {
      const widget = Initials(firstName: 'John', lastName: 'Doe');
      expect(widget, isA<Widget>());
    });
  });

  group('Initials Constructor Tests', () {
    test('default constructor with required parameters', () {
      const widget = Initials(firstName: 'John', lastName: 'Doe');
      expect(widget.firstName, equals('John'));
      expect(widget.lastName, equals('Doe'));
    });

    test('default constructor with key', () {
      const key = Key('initials-key');
      const widget = Initials(
        key: key,
        firstName: 'Jane',
        lastName: 'Smith',
      );
      expect(widget.key, equals(key));
      expect(widget.firstName, equals('Jane'));
      expect(widget.lastName, equals('Smith'));
    });

    test('fromFullName constructor with simple name', () {
      final widget = Initials.fromFullName(fullName: 'John Doe');
      expect(widget.firstName, equals('John'));
      expect(widget.lastName, equals('Doe'));
    });

    test('fromFullName constructor with three names', () {
      final widget = Initials.fromFullName(fullName: 'John Middle Doe');
      expect(widget.firstName, equals('John'));
      expect(widget.lastName, equals('Doe'));
    });

    test('fromFullName constructor with single name', () {
      final widget = Initials.fromFullName(fullName: 'John');
      expect(widget.firstName, equals('John'));
      expect(widget.lastName, equals('John'));
    });

    test('fromFullName constructor with key', () {
      const key = Key('fullname-key');
      final widget = Initials.fromFullName(
        key: key,
        fullName: 'Jane Smith',
      );
      expect(widget.key, equals(key));
      expect(widget.firstName, equals('Jane'));
      expect(widget.lastName, equals('Smith'));
    });
  });

  group('Initials Properties Tests', () {
    test('firstName property is accessible', () {
      const widget = Initials(firstName: 'Test', lastName: 'User');
      expect(widget.firstName, equals('Test'));
    });

    test('lastName property is accessible', () {
      const widget = Initials(firstName: 'Test', lastName: 'User');
      expect(widget.lastName, equals('User'));
    });

    test('key property is accessible', () {
      const key = Key('test-key');
      const widget = Initials(key: key, firstName: 'Test', lastName: 'User');
      expect(widget.key, equals(key));
    });

    test('properties with empty strings', () {
      const widget = Initials(firstName: '', lastName: '');
      expect(widget.firstName, equals(''));
      expect(widget.lastName, equals(''));
    });

    test('properties with single characters', () {
      const widget = Initials(firstName: 'J', lastName: 'D');
      expect(widget.firstName, equals('J'));
      expect(widget.lastName, equals('D'));
    });

    test('properties with special characters', () {
      const widget = Initials(firstName: "O'Brien", lastName: 'Müller-Schmidt');
      expect(widget.firstName, equals("O'Brien"));
      expect(widget.lastName, equals('Müller-Schmidt'));
    });

    test('properties with unicode characters', () {
      const widget = Initials(firstName: '李', lastName: '明');
      expect(widget.firstName, equals('李'));
      expect(widget.lastName, equals('明'));
    });

    test('properties with very long names', () {
      const longFirst = 'Verylongfirstnamethatgoesononandon';
      const longLast = 'Verylonglastnamethatgoesononandon';
      const widget = Initials(firstName: longFirst, lastName: longLast);
      expect(widget.firstName, equals(longFirst));
      expect(widget.lastName, equals(longLast));
    });
  });

  group('Initials fromFullName Edge Cases', () {
    test('fromFullName with multiple spaces', () {
      final widget = Initials.fromFullName(fullName: 'John  Doe');
      expect(widget.firstName, equals('John'));
    });

    test('fromFullName with leading space', () {
      final widget = Initials.fromFullName(fullName: ' John Doe');
      expect(widget.firstName, equals(''));
      expect(widget.lastName, equals('Doe'));
    });

    test('fromFullName with trailing space', () {
      final widget = Initials.fromFullName(fullName: 'John Doe ');
      expect(widget.firstName, equals('John'));
    });

    test('fromFullName with four names', () {
      final widget = Initials.fromFullName(fullName: 'John Middle Another Doe');
      expect(widget.firstName, equals('John'));
      expect(widget.lastName, equals('Doe'));
    });

    test('fromFullName with hyphenated last name', () {
      final widget = Initials.fromFullName(fullName: 'John Smith-Jones');
      expect(widget.firstName, equals('John'));
      expect(widget.lastName, equals('Smith-Jones'));
    });

    test('fromFullName with special characters', () {
      final widget = Initials.fromFullName(fullName: "O'Brien Müller");
      expect(widget.firstName, equals("O'Brien"));
      expect(widget.lastName, equals('Müller'));
    });

    test('fromFullName with unicode characters', () {
      final widget = Initials.fromFullName(fullName: '李 明');
      expect(widget.firstName, equals('李'));
      expect(widget.lastName, equals('明'));
    });
  });

  group('Initials Widget Equality Tests', () {
    test('widgets with same parameters have same runtime type', () {
      const widget1 = Initials(firstName: 'John', lastName: 'Doe');
      const widget2 = Initials(firstName: 'John', lastName: 'Doe');
      expect(widget1.runtimeType, equals(widget2.runtimeType));
    });

    test('widgets with different parameters have same runtime type', () {
      const widget1 = Initials(firstName: 'John', lastName: 'Doe');
      const widget2 = Initials(firstName: 'Jane', lastName: 'Smith');
      expect(widget1.runtimeType, equals(widget2.runtimeType));
    });

    test('default and fromFullName constructors have same runtime type', () {
      const widget1 = Initials(firstName: 'John', lastName: 'Doe');
      final widget2 = Initials.fromFullName(fullName: 'Jane Smith');
      expect(widget1.runtimeType, equals(widget2.runtimeType));
    });
  });

  group('Initials Multiple Instances Tests', () {
    test('multiple instances with different names', () {
      const widget1 = Initials(firstName: 'John', lastName: 'Doe');
      const widget2 = Initials(firstName: 'Jane', lastName: 'Smith');
      const widget3 = Initials(firstName: 'Bob', lastName: 'Johnson');

      expect(widget1.firstName, equals('John'));
      expect(widget2.firstName, equals('Jane'));
      expect(widget3.firstName, equals('Bob'));
    });

    test('multiple instances with different keys', () {
      const widget1 = Initials(key: Key('key1'), firstName: 'John', lastName: 'Doe');
      const widget2 = Initials(key: Key('key2'), firstName: 'Jane', lastName: 'Smith');
      const widget3 = Initials(key: Key('key3'), firstName: 'Bob', lastName: 'Johnson');

      expect(widget1.key, equals(const Key('key1')));
      expect(widget2.key, equals(const Key('key2')));
      expect(widget3.key, equals(const Key('key3')));
    });
  });

  group('Initials Rendering Tests', () {
    testWidgets('Initials renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const Initials(firstName: 'John', lastName: 'Doe'),
        ),
      );

      expect(find.byType(Initials), findsOneWidget);
    });

    testWidgets('Initials renders with key', (WidgetTester tester) async {
      const key = Key('initials-test');

      await tester.pumpWidget(
        wrapWithTheming(
          const Initials(key: key, firstName: 'John', lastName: 'Doe'),
        ),
      );

      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets('Initials renders ColoredBox', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const SizedBox(
            width: 100,
            height: 100,
            child: Initials(firstName: 'John', lastName: 'Doe'),
          ),
        ),
      );

      expect(find.byType(ColoredBox), findsWidgets);
      expect(find.byType(Initials), findsOneWidget);
    });

    testWidgets('Initials renders Center widgets', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const Initials(firstName: 'John', lastName: 'Doe'),
        ),
      );

      expect(find.byType(Center), findsWidgets);
    });

    testWidgets('Initials renders FractionallySizedBox', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const Initials(firstName: 'John', lastName: 'Doe'),
        ),
      );

      expect(find.byType(FractionallySizedBox), findsOneWidget);
    });

    testWidgets('Initials displays correct initials', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const Initials(firstName: 'John', lastName: 'Doe'),
        ),
      );

      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('Initials displays uppercase initials', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const Initials(firstName: 'john', lastName: 'doe'),
        ),
      );

      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('Initials with different names', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const Initials(firstName: 'Alice', lastName: 'Brown'),
        ),
      );

      expect(find.text('AB'), findsOneWidget);
    });

    testWidgets('Initials fromFullName renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          Initials.fromFullName(fullName: 'Jane Smith'),
        ),
      );

      expect(find.text('JS'), findsOneWidget);
    });

    testWidgets('Initials with hyphenated last name', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const SizedBox(
            width: 100,
            height: 100,
            child: Initials(firstName: 'John', lastName: 'Smith-Jones'),
          ),
        ),
      );

      expect(find.text('JS'), findsOneWidget);
    });

    testWidgets('Initials with multiple last names', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const Initials(firstName: 'John', lastName: 'Van Der Berg'),
        ),
      );

      expect(find.text('JB'), findsOneWidget);
    });

    testWidgets('Multiple Initials widgets render independently', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const Column(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Initials(firstName: 'John', lastName: 'Doe'),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Initials(firstName: 'Jane', lastName: 'Smith'),
              ),
            ],
          ),
        ),
      );

      expect(find.text('JD'), findsOneWidget);
      expect(find.text('JS'), findsOneWidget);
    });

    testWidgets('Initials with single character names', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const Initials(firstName: 'J', lastName: 'D'),
        ),
      );

      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('Initials with special characters displays first character', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          const Initials(firstName: "O'Brien", lastName: 'Müller'),
        ),
      );

      expect(find.text('OM'), findsOneWidget);
    });
  });

  group('Initials Type Checks', () {
    test('Initials is StatelessWidget', () {
      const widget = Initials(firstName: 'John', lastName: 'Doe');
      expect(widget, isA<StatelessWidget>());
    });

    test('Initials is Widget', () {
      const widget = Initials(firstName: 'John', lastName: 'Doe');
      expect(widget, isA<Widget>());
    });

    test('fromFullName creates Initials', () {
      final widget = Initials.fromFullName(fullName: 'John Doe');
      expect(widget, isA<Initials>());
    });

    test('fromFullName creates StatelessWidget', () {
      final widget = Initials.fromFullName(fullName: 'John Doe');
      expect(widget, isA<StatelessWidget>());
    });
  });
}
