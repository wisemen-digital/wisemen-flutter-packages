import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wise_ultra_settings/src/features/settings/models/user.dart';
import 'package:wise_ultra_settings/src/features/settings/widgets/profile_summary.dart';

Widget wrapWithTheming(Widget child) {
  final theming = WiseTheming(
    supportedThemes: supportedThemes,
    targetPlatform: TargetPlatform.iOS,
  );

  return ProviderScope(
    child: MaterialApp(
      theme: theming.lightTheme,
      darkTheme: theming.darkTheme,
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  final testUser = User(
    uuid: '123',
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@example.com',
    profilePictureUrl: 'https://example.com/avatar.jpg',
    birthDate: null,
  );

  group('ProfileSummary Widget Tests', () {
    test('ProfileSummary class exists', () {
      expect(ProfileSummary, isNotNull);
    });

    test('ProfileSummary can be instantiated', () {
      final widget = ProfileSummary(user: testUser);
      expect(widget, isA<ProfileSummary>());
    });

    test('ProfileSummary is a ConsumerWidget', () {
      final widget = ProfileSummary(user: testUser);
      expect(widget, isA<ConsumerWidget>());
    });

    test('ProfileSummary is a Widget', () {
      final widget = ProfileSummary(user: testUser);
      expect(widget, isA<Widget>());
    });
  });

  group('ProfileSummary Constructor Tests', () {
    test('required user parameter', () {
      final widget = ProfileSummary(user: testUser);
      expect(widget.user, equals(testUser));
    });

    test('with key', () {
      const key = Key('profile-key');
      final widget = ProfileSummary(key: key, user: testUser);
      expect(widget.key, equals(key));
    });

    test('with different user', () {
      final user2 = User(
        uuid: '456',
        firstName: 'Jane',
        lastName: 'Smith',
        email: 'jane@example.com',
        profilePictureUrl: null,
        birthDate: null,
      );
      final widget = ProfileSummary(user: user2);
      expect(widget.user, equals(user2));
    });
  });

  group('ProfileSummary Properties Tests', () {
    test('user property is accessible', () {
      final widget = ProfileSummary(user: testUser);
      expect(widget.user, equals(testUser));
    });

    test('user with all fields', () {
      final user = User(
        uuid: '789',
        firstName: 'Bob',
        lastName: 'Johnson',
        email: 'bob@example.com',
        profilePictureUrl: 'https://example.com/bob.jpg',
        phone: '+1234567890',
        mobilePhone: '+0987654321',
        birthDate: DateTime(1990, 1, 1),
      );
      final widget = ProfileSummary(user: user);
      expect(widget.user.uuid, equals('789'));
      expect(widget.user.firstName, equals('Bob'));
      expect(widget.user.lastName, equals('Johnson'));
    });

    test('user with null profile picture', () {
      final user = User(
        uuid: '999',
        firstName: 'Alice',
        lastName: 'Brown',
        email: 'alice@example.com',
        profilePictureUrl: null,
        birthDate: null,
      );
      final widget = ProfileSummary(user: user);
      expect(widget.user.profilePictureUrl, isNull);
    });
  });

  group('ProfileSummary Constants Tests', () {
    test('IMAGE_SIZE constant', () {
      expect(ProfileSummary.IMAGE_SIZE, equals(80));
    });

    test('IMAGE_OVERLAP constant', () {
      expect(ProfileSummary.IMAGE_OVERLAP, equals(0.33));
    });
  });

  group('ProfileSummary Rendering Tests', () {
    testWidgets('ProfileSummary renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          ProfileSummary(user: testUser),
        ),
      );

      expect(find.byType(ProfileSummary), findsOneWidget);
    });

    testWidgets('ProfileSummary displays user full name', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          ProfileSummary(user: testUser),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
    });

    testWidgets('ProfileSummary renders Stack', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          ProfileSummary(user: testUser),
        ),
      );

      expect(find.byType(Stack), findsWidgets);
    });

    testWidgets('ProfileSummary renders Container', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          ProfileSummary(user: testUser),
        ),
      );

      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('ProfileSummary renders ClipOval', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheming(
          ProfileSummary(user: testUser),
        ),
      );

      expect(find.byType(ClipOval), findsOneWidget);
    });

    testWidgets('ProfileSummary with key', (WidgetTester tester) async {
      const key = Key('profile-test');

      await tester.pumpWidget(
        wrapWithTheming(
          ProfileSummary(key: key, user: testUser),
        ),
      );

      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets('ProfileSummary with different user names', (WidgetTester tester) async {
      final user = User(
        uuid: '456',
        firstName: 'Jane',
        lastName: 'Smith',
        email: 'jane@example.com',
        profilePictureUrl: null,
        birthDate: null,
      );

      await tester.pumpWidget(
        wrapWithTheming(
          ProfileSummary(user: user),
        ),
      );

      expect(find.text('Jane Smith'), findsOneWidget);
    });

    testWidgets('ProfileSummary with special characters in name', (WidgetTester tester) async {
      final user = User(
        uuid: '789',
        firstName: "O'Brien",
        lastName: 'Müller',
        email: 'test@example.com',
        profilePictureUrl: null,
        birthDate: null,
      );

      await tester.pumpWidget(
        wrapWithTheming(
          ProfileSummary(user: user),
        ),
      );

      expect(find.text("O'Brien Müller"), findsOneWidget);
    });

    testWidgets('ProfileSummary with unicode characters', (WidgetTester tester) async {
      final user = User(
        uuid: '999',
        firstName: '李',
        lastName: '明',
        email: 'test@example.com',
        profilePictureUrl: null,
        birthDate: null,
      );

      await tester.pumpWidget(
        wrapWithTheming(
          ProfileSummary(user: user),
        ),
      );

      expect(find.text('李 明'), findsOneWidget);
    });

    testWidgets('Multiple ProfileSummary widgets render independently', (WidgetTester tester) async {
      final user1 = User(
        uuid: '1',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        profilePictureUrl: null,
        birthDate: null,
      );

      final user2 = User(
        uuid: '2',
        firstName: 'Jane',
        lastName: 'Smith',
        email: 'jane@example.com',
        profilePictureUrl: null,
        birthDate: null,
      );

      await tester.pumpWidget(
        wrapWithTheming(
          Column(
            children: [
              ProfileSummary(user: user1),
              ProfileSummary(user: user2),
            ],
          ),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Jane Smith'), findsOneWidget);
    });
  });

  group('ProfileSummary Type Checks', () {
    test('ProfileSummary is ConsumerWidget', () {
      final widget = ProfileSummary(user: testUser);
      expect(widget, isA<ConsumerWidget>());
    });

    test('ProfileSummary is Widget', () {
      final widget = ProfileSummary(user: testUser);
      expect(widget, isA<Widget>());
    });
  });

  group('ProfileSummary Edge Cases', () {
    test('user with empty name', () {
      final user = User(
        uuid: '000',
        firstName: '',
        lastName: '',
        email: 'empty@example.com',
        profilePictureUrl: null,
        birthDate: null,
      );
      final widget = ProfileSummary(user: user);
      expect(widget.user.fullName, equals(' '));
    });

    test('user with single character names', () {
      final user = User(
        uuid: '111',
        firstName: 'J',
        lastName: 'D',
        email: 'jd@example.com',
        profilePictureUrl: null,
        birthDate: null,
      );
      final widget = ProfileSummary(user: user);
      expect(widget.user.fullName, equals('J D'));
    });

    test('user with very long names', () {
      final user = User(
        uuid: '222',
        firstName: 'Verylongfirstnamethatgoesononandon',
        lastName: 'Verylonglastnamethatgoesononandon',
        email: 'long@example.com',
        profilePictureUrl: null,
        birthDate: null,
      );
      final widget = ProfileSummary(user: user);
      expect(widget.user.firstName, equals('Verylongfirstnamethatgoesononandon'));
    });

    test('user with empty profile picture URL', () {
      final user = User(
        uuid: '333',
        firstName: 'Test',
        lastName: 'User',
        email: 'test@example.com',
        profilePictureUrl: '',
        birthDate: null,
      );
      final widget = ProfileSummary(user: user);
      expect(widget.user.profilePictureUrl, equals(''));
    });
  });
}
