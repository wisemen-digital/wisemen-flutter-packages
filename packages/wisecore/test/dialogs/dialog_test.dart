import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wisecore/src/dialogs/error_dialog_helper.dart';
import 'package:dio/dio.dart';
import 'package:wisecore/src/dialogs/platform_alert_service.dart';

class MockPlatformAlertService extends Mock implements PlatformAlertService {}

void main() {
  late ErrorDialog errorDialog;
  const networkErrorString = 'Network error occurred';
  const appName = 'TestApp';
  final mockAlertService = MockPlatformAlertService();

  setUpAll(() {
    registerFallbackValue(IconStyle.error);
  });

  setUp(() {
    errorDialog = ErrorDialog(
      networkErrorString: networkErrorString,
      appName: appName,
      alertService: mockAlertService,
    );
  });

  test('getErrorMessage returns null if no error or loading', () {
    final asyncValue = AsyncValue<int>.loading();
    final message = errorDialog.getErrorMessage(value: asyncValue);
    expect(message, isNull);
  });

  test('getErrorMessage returns error message from DioException', () {
    final dioError = DioException(
      requestOptions: RequestOptions(path: ''),
      response: Response(
        requestOptions: RequestOptions(path: ''),
        data: {'message': 'Dio error occurred'},
      ),
    );
    final asyncValue = AsyncValue<int>.error(dioError, StackTrace.current);
    final message = errorDialog.getErrorMessage(value: asyncValue);
    expect(message, 'Dio error occurred');
  });

  test(
      'getErrorMessage returns networkErrorString if no message in DioException',
      () {
    final dioError = DioException(
      requestOptions: RequestOptions(path: ''),
    );
    final asyncValue = AsyncValue<int>.error(dioError, StackTrace.current);
    final message = errorDialog.getErrorMessage(value: asyncValue);
    expect(message, networkErrorString);
  });

  test('getErrorMessage returns error message from Exception', () {
    final exception = Exception('General error occurred');
    final asyncValue = AsyncValue<int>.error(exception, StackTrace.current);
    final message = errorDialog.getErrorMessage(value: asyncValue);
    expect(message, 'General error occurred');
  });

  testWidgets('showErrorDialog calls alert with custom error message',
      (tester) async {
    final mockAlertService = MockPlatformAlertService();
    final dialog = ErrorDialog(
      networkErrorString: 'Network Error',
      appName: 'TestApp',
      alertService: mockAlertService,
    );
    final asyncValue =
        AsyncValue<int>.error(Exception('Error'), StackTrace.current);

    // Stub the alert
    when(() => mockAlertService.showAlert(
          title: any(named: 'title'),
          message: any(named: 'message'),
          iconStyle: any(named: 'iconStyle'),
        )).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            dialog.showErrorDialog(context, asyncValue,
                customErrorMessage: 'Custom error');
            return Container();
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    verify(() => mockAlertService.showAlert(
          title: 'TestApp',
          message: 'Custom error',
          iconStyle: IconStyle.error,
        )).called(1);
  });

  testWidgets('showErrorDialog shows dialog with error message from AsyncValue',
      (WidgetTester tester) async {
    final mockAlertService = MockPlatformAlertService();
    final dialog = ErrorDialog(
      networkErrorString: 'Network Error',
      appName: 'TestApp',
      alertService: mockAlertService,
    );
    final asyncValue =
        AsyncValue<int>.error(Exception('Error'), StackTrace.current);

    when(() => mockAlertService.showAlert(
          title: any(named: 'title'),
          message: any(named: 'message'),
          iconStyle: any(named: 'iconStyle'),
        )).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            dialog.showErrorDialog(context, asyncValue);
            return Container();
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    verify(() => mockAlertService.showAlert(
          title: 'TestApp',
          message: 'Error',
          iconStyle: IconStyle.error,
        )).called(1);
  });

  testWidgets('showErrorDialog does not call alert if no error',
      (tester) async {
    final mockAlertService = MockPlatformAlertService();
    final dialog = ErrorDialog(
      networkErrorString: 'Network Error',
      appName: 'TestApp',
      alertService: mockAlertService,
    );
    final asyncValue = AsyncValue<int>.data(42); // Success state, no error

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            dialog.showErrorDialog(context, asyncValue);
            return Container();
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    verifyNever(() => mockAlertService.showAlert(
          title: any(named: 'title'),
          message: any(named: 'message'),
          iconStyle: any(named: 'iconStyle'),
        ));
  });

  test('getErrorMessage returns message from DioException List<dynamic>', () {
    final dioError = DioException(
      requestOptions: RequestOptions(path: ''),
      response: Response(
        requestOptions: RequestOptions(path: ''),
        data: [
          {'message': 'List error message'},
        ],
      ),
    );
    final asyncValue = AsyncValue<int>.error(dioError, StackTrace.current);
    final message = errorDialog.getErrorMessage(value: asyncValue);
    expect(message, 'List error message');
  });

  test('getErrorMessage returns networkErrorString if unknown error type', () {
    final error = Object();
    final asyncValue = AsyncValue<int>.error(error, StackTrace.current);
    final message = errorDialog.getErrorMessage(value: asyncValue);
    expect(message, networkErrorString);
  });

  testWidgets(
      'AsyncValueExtensions.showErrorDialog calls ErrorDialog.showErrorDialog',
      (tester) async {
    final mockAlertService = MockPlatformAlertService();
    final dialog = ErrorDialog(
      networkErrorString: 'Network Error',
      appName: 'TestApp',
      alertService: mockAlertService,
    );
    final asyncError =
        AsyncError<Object>(Exception('AsyncError!'), StackTrace.current);

    when(() => mockAlertService.showAlert(
          title: any(named: 'title'),
          message: any(named: 'message'),
          iconStyle: any(named: 'iconStyle'),
        )).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            asyncError.showErrorDialog(dialogShower: dialog, context: context);
            return Container();
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    verify(() => mockAlertService.showAlert(
          title: 'TestApp',
          message: 'AsyncError!',
          iconStyle: IconStyle.error,
        )).called(1);
  });
}
