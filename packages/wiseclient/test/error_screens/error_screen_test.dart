import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiseclient/src/error_screens/base_client_error.dart';
import 'package:wiseclient/src/error_screens/base_server_error.dart';
import 'package:wiseclient/src/error_screens/error_screens.dart';
import 'package:wiseclient/src/error_screens/messages.dart';

void main() {
  testWidgets('BaseClientError displays error information',
      (WidgetTester tester) async {
    const errorInformation = 'An error occurred';

    await tester.pumpWidget(
      const MaterialApp(
        home: BaseClientError(errorInformation: errorInformation),
      ),
    );

    expect(find.text(getClientErrorTitle('en')), findsOneWidget);
    expect(find.text(getDetailedClientErrorMessage('en')), findsOneWidget);
    expect(find.text(getViewFullMessage('en')), findsOneWidget);
    expect(find.text(errorInformation), findsNothing);

    await tester.tap(find.text(getViewFullMessage('en')));
    await tester.pumpAndSettle();

    expect(find.text(errorInformation), findsOneWidget);
  });

  testWidgets('BaseClientError toggles full message visibility',
      (WidgetTester tester) async {
    const errorInformation = 'An error occurred';

    await tester.pumpWidget(
      const MaterialApp(
        home: BaseClientError(errorInformation: errorInformation),
      ),
    );

    expect(find.text(errorInformation), findsNothing);

    await tester.tap(find.text(getViewFullMessage('en')));
    await tester.pumpAndSettle();

    expect(find.text(errorInformation), findsOneWidget);

    await tester.tap(find.text(getViewFullMessage('en')));
    await tester.pumpAndSettle();

    expect(find.text(errorInformation), findsNothing);
  });

  testWidgets('BaseServerError displays error information',
      (WidgetTester tester) async {
    const errorInformation = 'A server error occurred';

    await tester.pumpWidget(
      const MaterialApp(
        home: BaseServerError(errorInformation: errorInformation),
      ),
    );

    expect(find.text(getServerErrorTitle('en')), findsOneWidget);
    expect(find.text(getDetailedServerErrorMesssage('en')), findsOneWidget);
    expect(find.text(getViewFullMessage('en')), findsOneWidget);
    expect(find.text(errorInformation), findsNothing);

    await tester.tap(find.text(getViewFullMessage('en')));
    await tester.pumpAndSettle();

    expect(find.text(errorInformation), findsOneWidget);
  });

  testWidgets('BaseServerError toggles full message visibility',
      (WidgetTester tester) async {
    const errorInformation = 'A server error occurred';

    await tester.pumpWidget(
      const MaterialApp(
        home: BaseServerError(errorInformation: errorInformation),
      ),
    );

    expect(find.text(errorInformation), findsNothing);

    await tester.tap(find.text(getViewFullMessage('en')));
    await tester.pumpAndSettle();

    expect(find.text(errorInformation), findsOneWidget);

    await tester.tap(find.text(getViewFullMessage('en')));
    await tester.pumpAndSettle();

    expect(find.text(errorInformation), findsNothing);
  });

  late GlobalKey<NavigatorState> navigatorKey;
  late NavigatorObserver mockObserver;
  late Widget testApp;

  setUp(() {
    mockObserver = MockNavigatorObserver();
    navigatorKey = GlobalKey<NavigatorState>();
    testApp = MaterialApp(
      navigatorObservers: [mockObserver],
      navigatorKey: navigatorKey,
      home: Container()
    );
  });

  DioException createDioException(int statusCode) {
    return DioException(
      requestOptions: RequestOptions(path: ''),
      response: Response(
          statusCode: statusCode, requestOptions: RequestOptions(path: '')),
    );
  }

  group('WiseErrorHandler', () {
    testWidgets('pushes custom widget for 404 error', (WidgetTester tester) async {
      final handler = WiseErrorHandler(
        navigatorKey: navigatorKey,
        notFound: const Text('404 - Not Found'),
      );

      await tester.pumpWidget(testApp);

      final exception = createDioException(404);
      await handler.pushErrorDetail(exception: exception);

      await tester.pump(Duration(seconds: 1));

      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('404 - Not Found'), findsOneWidget);
    });

    testWidgets('pushes custom widget for 500 error', (tester) async {
      final handler = WiseErrorHandler(
        navigatorKey: navigatorKey,
        internalServerError: const Text('500 - Server Error'),
      );

      await tester.pumpWidget(testApp);

      final exception = createDioException(500);
      await handler.pushErrorDetail(exception: exception);
      await tester.pumpAndSettle();

      expect(find.text('500 - Server Error'), findsOneWidget);
    });

    testWidgets('pushes BaseClientError if no custom widget for 400',
        (tester) async {
      final handler = WiseErrorHandler(navigatorKey: navigatorKey);

      await tester.pumpWidget(testApp);

      final exception = createDioException(400);
      await handler.pushErrorDetail(exception: exception);
      await tester.pumpAndSettle();

      expect(find.byType(BaseClientError), findsOneWidget);
    });

    testWidgets('pushes BaseServerError if no custom widget for 500',
        (tester) async {
      final handler = WiseErrorHandler(navigatorKey: navigatorKey);

      await tester.pumpWidget(testApp);

      final exception = createDioException(500);
      await handler.pushErrorDetail(exception: exception);
      await tester.pumpAndSettle();

      expect(find.byType(BaseServerError), findsOneWidget);
    });

    testWidgets('pushes otherClientError widget if provided', (tester) async {
      final handler = WiseErrorHandler(
        navigatorKey: navigatorKey,
        otherClientError: const Text('Other Client Error'),
      );

      await tester.pumpWidget(testApp);

      final exception = createDioException(400);
      await handler.pushErrorDetail(exception: exception);
      await tester.pumpAndSettle();

      expect(find.text('Other Client Error'), findsOneWidget);
    });

    testWidgets('pushes otherServerError widget if provided', (tester) async {
      final handler = WiseErrorHandler(
        navigatorKey: navigatorKey,
        otherServerError: const Text('Other Server Error'),
      );

      await tester.pumpWidget(testApp);

      final exception = createDioException(505);
      await handler.pushErrorDetail(exception: exception);
      await tester.pumpAndSettle();

      expect(find.text('Other Server Error'), findsOneWidget);
    });

    testWidgets('pushes widget for unhandled code when showAllErrors = true',
        (tester) async {
      final handler = WiseErrorHandler(
        navigatorKey: navigatorKey,
        showAllErrors: true,
        otherServerError: const Text('Unhandled Error'),
      );

      await tester.pumpWidget(testApp);

      final exception = createDioException(999);
      await handler.pushErrorDetail(exception: exception);
      await tester.pumpAndSettle();

      expect(find.text('Unhandled Error'), findsOneWidget);
    });

    testWidgets('does nothing if navigatorKey has no currentState',
        (tester) async {
      final key = GlobalKey<NavigatorState>(); // Not attached to app
      final handler = WiseErrorHandler(navigatorKey: key);

      final exception = createDioException(404);

      // Should not throw
      await handler.pushErrorDetail(exception: exception);
    });
  });
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
