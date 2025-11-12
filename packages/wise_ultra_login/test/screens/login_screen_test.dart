import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wise_ultra_login/wise_ultra_login.dart';

import '../utils/fake_ref.dart';
import '../utils/mock_auth.dart';

Widget wrapWithTheming(Widget child) {
  final theming = WiseTheming(
    supportedThemes: supportedThemes,
    targetPlatform: TargetPlatform.iOS,
  );

  return MaterialApp(
    theme: theming.lightTheme,
    darkTheme: theming.darkTheme,
    home: child,
  );
}

void main() {
  setUp(() {
    mockPlatformAlerts();
    loginCalls = 0;
  });

  setUpAll(() {
    LoginFeature.init(
      loginFlavors: FakeLoginFlavors(),
      loginLocalizations: FakeLoginLocalizations(),
      loginAssets: FakeLoginAssets(),
      loginRepository: Provider<LoginRepository>((ref) => MockLoginRepository()),
    );
  });

  group('LoginScreen Widget Tests', () {
    test('LoginScreen class exists', () {
      expect(LoginScreen, isNotNull);
    });

    test('LoginScreen can be instantiated', () {
      const screen = LoginScreen();
      expect(screen, isA<LoginScreen>());
    });

    test('LoginScreen accepts optional parameters', () {
      const screen = LoginScreen();
      expect(screen.belowTitleHeader, isNull);
      expect(screen.footer, isNull);
    });

    testWidgets('LoginScreen creates state', (WidgetTester tester) async {
      const screen = LoginScreen();
      final state = screen.createState();
      expect(state, isA<State<LoginScreen>>());
    });
  });

  group('LoginScreen Widget Properties', () {
    test('default properties', () {
      const screen = LoginScreen();
      expect(screen.belowTitleHeader, isNull);
      expect(screen.footer, isNull);
      expect(screen.key, isNull);
    });

    test('custom properties', () {
      const header = Text('Header');
      const footer = Text('Footer');
      const key = Key('test-key');

      const screen = LoginScreen(
        key: key,
        belowTitleHeader: header,
        footer: footer,
      );

      expect(screen.belowTitleHeader, equals(header));
      expect(screen.footer, equals(footer));
      expect(screen.key, equals(key));
    });

    test('widget equality', () {
      const screen1 = LoginScreen();
      const screen2 = LoginScreen();
      const screen3 = LoginScreen(belowTitleHeader: Text('Different'));

      expect(screen1.runtimeType, equals(screen2.runtimeType));
      expect(screen1.runtimeType, equals(screen3.runtimeType));
    });
  });

  group('LoginScreen Integration Tests', () {
    test('LoginScreen with all optional parameters', () {
      const testKey = Key('login-screen-key');
      const header = Text('Welcome Back');
      const footer = Text('Terms and Conditions');

      const screen = LoginScreen(
        key: testKey,
        belowTitleHeader: header,
        footer: footer,
      );

      expect(screen.key, equals(testKey));
      expect(screen.belowTitleHeader, equals(header));
      expect(screen.footer, equals(footer));
    });

    test('Multiple LoginScreen instances', () {
      const screen1 = LoginScreen(key: Key('screen1'));
      const screen2 = LoginScreen(key: Key('screen2'));
      const screen3 = LoginScreen(key: Key('screen3'));

      expect(screen1.key, equals(const Key('screen1')));
      expect(screen2.key, equals(const Key('screen2')));
      expect(screen3.key, equals(const Key('screen3')));
    });

    test('LoginScreen properties are accessible', () {
      const screen = LoginScreen(
        belowTitleHeader: Text('Test Header'),
        footer: Text('Test Footer'),
      );

      expect(screen.belowTitleHeader, isNotNull);
      expect(screen.footer, isNotNull);
    });
  });

  group('LoginScreen Edge Cases', () {
    test('LoginScreen with null key', () {
      const screen = LoginScreen();
      expect(screen.key, isNull);
    });

    test('LoginScreen with explicit null parameters', () {
      const screen = LoginScreen();
      expect(screen.belowTitleHeader, isNull);
      expect(screen.footer, isNull);
    });

    testWidgets('LoginScreen state creation multiple times', (WidgetTester tester) async {
      const screen = LoginScreen();

      final state1 = screen.createState();
      final state2 = screen.createState();
      final state3 = screen.createState();

      expect(identical(state1, state2), isFalse);
      expect(identical(state2, state3), isFalse);
      expect(identical(state1, state3), isFalse);
    });

    testWidgets('LoginScreen with complex header widget', (WidgetTester tester) async {
      final complexHeader = Column(
        children: [
          const Text('Line 1'),
          const Text('Line 2'),
          Container(height: 10),
          const Icon(Icons.info),
        ],
      );

      final screen = LoginScreen(belowTitleHeader: complexHeader);

      expect(screen.belowTitleHeader, equals(complexHeader));
    });

    testWidgets('LoginScreen with complex footer widget', (WidgetTester tester) async {
      final complexFooter = Row(
        children: [
          const Text('Terms'),
          const SizedBox(width: 10),
          const Text('Privacy'),
          const SizedBox(width: 10),
          TextButton(onPressed: () {}, child: const Text('Learn More')),
        ],
      );

      final screen = LoginScreen(footer: complexFooter);

      expect(screen.footer, equals(complexFooter));
    });
  });

  group('LoginScreen Type Checks', () {
    test('LoginScreen is a ConsumerStatefulWidget', () {
      const screen = LoginScreen();
      expect(screen, isA<ConsumerStatefulWidget>());
    });

    test('LoginScreen is a StatefulWidget', () {
      const screen = LoginScreen();
      expect(screen, isA<StatefulWidget>());
    });

    test('LoginScreen is a Widget', () {
      const screen = LoginScreen();
      expect(screen, isA<Widget>());
    });

    testWidgets('LoginScreen state is ConsumerState', (WidgetTester tester) async {
      const screen = LoginScreen();
      final state = screen.createState();
      expect(state, isA<ConsumerState>());
    });

    testWidgets('LoginScreen state is State', (WidgetTester tester) async {
      const screen = LoginScreen();
      final state = screen.createState();
      expect(state, isA<State>());
    });
  });

  group('LoginScreen Constructor Variations', () {
    test('LoginScreen with only key', () {
      const screen = LoginScreen(key: Key('test'));
      expect(screen.key, equals(const Key('test')));
      expect(screen.belowTitleHeader, isNull);
      expect(screen.footer, isNull);
    });

    test('LoginScreen with only header', () {
      const screen = LoginScreen(belowTitleHeader: Text('Header'));
      expect(screen.key, isNull);
      expect(screen.belowTitleHeader, isNotNull);
      expect(screen.footer, isNull);
    });

    test('LoginScreen with only footer', () {
      const screen = LoginScreen(footer: Text('Footer'));
      expect(screen.key, isNull);
      expect(screen.belowTitleHeader, isNull);
      expect(screen.footer, isNotNull);
    });

    test('LoginScreen with key and header', () {
      const screen = LoginScreen(
        key: Key('test'),
        belowTitleHeader: Text('Header'),
      );
      expect(screen.key, equals(const Key('test')));
      expect(screen.belowTitleHeader, isNotNull);
      expect(screen.footer, isNull);
    });

    test('LoginScreen with key and footer', () {
      const screen = LoginScreen(
        key: Key('test'),
        footer: Text('Footer'),
      );
      expect(screen.key, equals(const Key('test')));
      expect(screen.belowTitleHeader, isNull);
      expect(screen.footer, isNotNull);
    });

    test('LoginScreen with header and footer', () {
      const screen = LoginScreen(
        belowTitleHeader: Text('Header'),
        footer: Text('Footer'),
      );
      expect(screen.key, isNull);
      expect(screen.belowTitleHeader, isNotNull);
      expect(screen.footer, isNotNull);
    });

    test('LoginScreen with all parameters', () {
      const screen = LoginScreen(
        key: Key('all-params'),
        belowTitleHeader: Text('Header'),
        footer: Text('Footer'),
      );
      expect(screen.key, equals(const Key('all-params')));
      expect(screen.belowTitleHeader, isNotNull);
      expect(screen.footer, isNotNull);
    });
  });

  group('LoginScreen State Creation', () {
    test('createState returns new instance each time', () {
      const screen = LoginScreen();
      final state1 = screen.createState();
      final state2 = screen.createState();

      expect(state1, isNot(same(state2)));
    });

    test('createState with different screens', () {
      const screen1 = LoginScreen();
      const screen2 = LoginScreen(belowTitleHeader: Text('Test'));

      final state1 = screen1.createState();
      final state2 = screen2.createState();

      expect(state1.runtimeType, equals(state2.runtimeType));
    });
  });

  group('LoginScreen Rendering Tests', () {
    testWidgets('LoginScreen renders with disableAnimations', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(disableAnimations: true),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('LoginScreen displays title and subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(disableAnimations: true),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Welcome'), findsOneWidget);
      expect(find.text('Choose your login method'), findsOneWidget);
    });

    testWidgets('LoginScreen displays login methods', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(disableAnimations: true),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Sign in with Google'), findsOneWidget);
      expect(find.text('Sign in with Apple'), findsOneWidget);
      expect(find.text('Sign in with Email'), findsOneWidget);
    });

    testWidgets('LoginScreen displays custom header', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(
              disableAnimations: true,
              belowTitleHeader: Text('Custom Header'),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Custom Header'), findsOneWidget);
    });

    testWidgets('LoginScreen displays custom footer', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(
              disableAnimations: true,
              footer: Text('Custom Footer'),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Custom Footer'), findsOneWidget);
    });

    testWidgets('LoginScreen displays both header and footer', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(
              disableAnimations: true,
              belowTitleHeader: Text('Header Widget'),
              footer: Text('Footer Widget'),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Header Widget'), findsOneWidget);
      expect(find.text('Footer Widget'), findsOneWidget);
    });

    testWidgets('LoginScreen login button tap triggers login', (WidgetTester tester) async {
      loginCalls = 0;

      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(disableAnimations: true),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final googleButton = find.text('Sign in with Google');
      expect(googleButton, findsOneWidget);

      await tester.tap(googleButton);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(loginCalls, equals(1));
    });

    testWidgets('LoginScreen multiple login methods can be tapped', (WidgetTester tester) async {
      loginCalls = 0;

      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(disableAnimations: true),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      await tester.tap(find.text('Sign in with Google'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      await tester.tap(find.text('Sign in with Apple'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      await tester.tap(find.text('Sign in with Email'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(loginCalls, equals(3));
    });

    testWidgets('LoginScreen renders InkWell for each login method', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(disableAnimations: true),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(InkWell), findsNWidgets(3));
    });

    testWidgets('LoginScreen renders Material widgets for login buttons', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(disableAnimations: true),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(Material), findsWidgets);
    });

    testWidgets('LoginScreen without header shows no header widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(disableAnimations: true),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Custom Header'), findsNothing);
    });

    testWidgets('LoginScreen without footer shows no footer widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(disableAnimations: true),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Custom Footer'), findsNothing);
    });

    testWidgets('LoginScreen with key can be found by key', (WidgetTester tester) async {
      const testKey = Key('login-screen-test');

      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(
              key: testKey,
              disableAnimations: true,
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byKey(testKey), findsOneWidget);
    });

    testWidgets('LoginScreen renders Stack layout', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(disableAnimations: true),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(Stack), findsWidgets);
    });

    testWidgets('LoginScreen renders Column for login options', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(disableAnimations: true),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('LoginScreen renders Positioned widgets', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(disableAnimations: true),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(Positioned), findsWidgets);
    });

    testWidgets('LoginScreen renders AnimatedOpacity widgets', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(disableAnimations: true),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(AnimatedOpacity), findsWidgets);
    });

    testWidgets('LoginScreen complex header renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            LoginScreen(
              disableAnimations: true,
              belowTitleHeader: Column(
                children: [
                  const Text('Line 1'),
                  const Text('Line 2'),
                  Container(height: 10),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Line 1'), findsOneWidget);
      expect(find.text('Line 2'), findsOneWidget);
    });

    testWidgets('LoginScreen complex footer renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(
              disableAnimations: true,
              footer: Row(
                children: [
                  Text('Terms'),
                  SizedBox(width: 10),
                  Text('Privacy'),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Terms'), findsOneWidget);
      expect(find.text('Privacy'), findsOneWidget);
    });

    testWidgets('LoginScreen renders with all parameters', (WidgetTester tester) async {
      const testKey = Key('full-screen');

      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithTheming(
            const LoginScreen(
              key: testKey,
              disableAnimations: true,
              belowTitleHeader: Text('Full Header'),
              footer: Text('Full Footer'),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byKey(testKey), findsOneWidget);
      expect(find.text('Full Header'), findsOneWidget);
      expect(find.text('Full Footer'), findsOneWidget);
      expect(find.text('Welcome'), findsOneWidget);
      expect(find.text('Sign in with Google'), findsOneWidget);
    });

    testWidgets('LoginScreen disableAnimations parameter works', (WidgetTester tester) async {
      const screen = LoginScreen(disableAnimations: true);
      expect(screen.disableAnimations, isTrue);

      const screen2 = LoginScreen();
      expect(screen2.disableAnimations, isFalse);

      const screen3 = LoginScreen();
      expect(screen3.disableAnimations, isFalse);
    });
  });
}
