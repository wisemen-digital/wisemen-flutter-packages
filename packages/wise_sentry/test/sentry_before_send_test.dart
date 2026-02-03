import 'package:flutter_test/flutter_test.dart';
import 'package:wise_sentry/wise_sentry.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:dio/dio.dart';
import 'dart:io';

void main() {
  test('wiseSentryBeforeSend returns event for transaction type', () {
    final event = SentryEvent(type: 'transaction');
    final result = wiseSentryBeforeSend(event);
    expect(result, equals(event));
  });

  test('wiseSentryBeforeSend enriches event with WiseException', () {
    final event = SentryEvent(throwable: FormatException('bad format'));
    final result = wiseSentryBeforeSend(event);
    expect(result?.throwable, isA<DTOException>());
  });

  test('wiseSentryBeforeSend converts DioException to HttpException', () {
    final dioError = DioException(
      requestOptions: RequestOptions(path: '/api/test', method: 'GET'),
      type: DioExceptionType.badResponse,
      response: Response(
        requestOptions: RequestOptions(path: '/api/test'),
        statusCode: 404,
        data: {
          'errors': [
            {
              'status': '404',
              'code': 'NotFoundException',
              'detail': 'Resource not found',
            },
          ],
          'traceId': 'test-trace-123',
        },
      ),
    );

    final event = SentryEvent(throwable: dioError);
    final result = wiseSentryBeforeSend(event);

    expect(result?.throwable, isA<HttpException>());

    final httpException = result?.throwable as HttpException;
    expect(httpException.statusCode, 404);
    expect(httpException.apiError, isNotNull);
    expect(httpException.apiError?.traceId, 'test-trace-123');
    expect(httpException.apiError?.errors.first.code, 'NotFoundException');

    // Verify extras are added to the event's extra field
    expect(result?.extra?['api_trace_id'], 'test-trace-123');
    expect(result?.extra?['first_error_code'], 'NotFoundException');
    expect(result?.extra?['first_error_detail'], 'Resource not found');
      expect(result?.tags?['error-category'], 'dto');
    });
  });

  group('wiseSentryBeforeSend error conversion', () {
    test('converts FormatException to DTOException', () {
      final event = SentryEvent(throwable: FormatException('bad format'));
      final result = wiseSentryBeforeSend(event);
      expect(result?.throwable, isA<DTOException>());
    });
    test('converts TypeError to DTOException', () {
      final event = SentryEvent(throwable: TypeError());
      final result = wiseSentryBeforeSend(event);
      expect(result?.throwable, isA<DTOException>());
    });
  });

  group('wiseSentryBeforeSend filtering', () {
    test('filters DioException with status 500', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/'),
        type: DioExceptionType.badResponse,
        response: Response(requestOptions: RequestOptions(path: '/'), statusCode: 500),
      );
      final event = SentryEvent(throwable: dioError);
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('does not filter DioException with GET 400 and user params', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/', method: 'GET', queryParameters: {'q': 'x'}),
        type: DioExceptionType.badResponse,
        response: Response(requestOptions: RequestOptions(path: '/'), statusCode: 400),
      );
      final event = SentryEvent(throwable: dioError);
      final result = wiseSentryBeforeSend(event);
      expect(result, isNotNull);
    });

    test('filters SocketException', () {
      final event = SentryEvent(throwable: SocketException('fail'));
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters DioException with POST 500', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/', method: 'POST'),
        type: DioExceptionType.badResponse,
        response: Response(requestOptions: RequestOptions(path: '/'), statusCode: 500),
      );
      final event = SentryEvent(throwable: dioError);
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters DioException with PUT 503', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/', method: 'PUT'),
        type: DioExceptionType.badResponse,
        response: Response(requestOptions: RequestOptions(path: '/'), statusCode: 503),
      );
      final event = SentryEvent(throwable: dioError);
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters DioException with PATCH 502', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/', method: 'PATCH'),
        type: DioExceptionType.badResponse,
        response: Response(requestOptions: RequestOptions(path: '/'), statusCode: 502),
      );
      final event = SentryEvent(throwable: dioError);
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters DioException with DELETE 500', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/', method: 'DELETE'),
        type: DioExceptionType.badResponse,
        response: Response(requestOptions: RequestOptions(path: '/'), statusCode: 500),
      );
      final event = SentryEvent(throwable: dioError);
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters DioException with connectionTimeout', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/', method: 'POST'),
        type: DioExceptionType.connectionTimeout,
      );
      final event = SentryEvent(throwable: dioError);
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters DioException with sendTimeout', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/', method: 'POST'),
        type: DioExceptionType.sendTimeout,
      );
      final event = SentryEvent(throwable: dioError);
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters DioException with receiveTimeout', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/', method: 'POST'),
        type: DioExceptionType.receiveTimeout,
      );
      final event = SentryEvent(throwable: dioError);
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters DioException with connectionError', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/', method: 'POST'),
        type: DioExceptionType.connectionError,
      );
      final event = SentryEvent(throwable: dioError);
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters DioException with cancel', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/', method: 'POST'),
        type: DioExceptionType.cancel,
      );
      final event = SentryEvent(throwable: dioError);
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters DioException with badCertificate', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/', method: 'POST'),
        type: DioExceptionType.badCertificate,
      );
      final event = SentryEvent(throwable: dioError);
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters DioException with unknown type', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/', method: 'POST'),
        type: DioExceptionType.unknown,
      );
      final event = SentryEvent(throwable: dioError);
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters GET 400 without user params', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/', method: 'GET'),
        type: DioExceptionType.badResponse,
        response: Response(requestOptions: RequestOptions(path: '/'), statusCode: 400),
      );
      final event = SentryEvent(throwable: dioError);
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters GET 422 without user params', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/', method: 'GET'),
        type: DioExceptionType.badResponse,
        response: Response(requestOptions: RequestOptions(path: '/'), statusCode: 422),
      );
      final event = SentryEvent(throwable: dioError);
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('does not filter GET 422 with user params', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/', method: 'GET', queryParameters: {'search': 'test'}),
        type: DioExceptionType.badResponse,
        response: Response(requestOptions: RequestOptions(path: '/'), statusCode: 422),
      );
      final event = SentryEvent(throwable: dioError);
      final result = wiseSentryBeforeSend(event);
      expect(result, isNotNull);
    });

    test('filters HandshakeException', () {
      final event = SentryEvent(throwable: HandshakeException('handshake failed'));
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters HttpException', () {
      final event = SentryEvent(throwable: HttpException('http error'));
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters OSError with connection refused', () {
      final event = SentryEvent(throwable: OSError('Connection refused', 111));
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters OSError with connection reset', () {
      final event = SentryEvent(throwable: OSError('Connection reset by peer', 104));
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters OSError with connection closed', () {
      final event = SentryEvent(throwable: OSError('Connection closed', 32));
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters OSError with connection aborted', () {
      final event = SentryEvent(throwable: OSError('Software caused connection abort', 103));
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters OSError with network unreachable', () {
      final event = SentryEvent(throwable: OSError('Network is unreachable', 101));
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('filters OSError with no route to host', () {
      final event = SentryEvent(throwable: OSError('No route to host', 113));
      final result = wiseSentryBeforeSend(event);
      expect(result, isNull);
    });

    test('does not filter OSError with other messages', () {
      final event = SentryEvent(throwable: OSError('File not found', 2));
      final result = wiseSentryBeforeSend(event);
      expect(result, isNotNull);
    });
  });

  group('TypeError categorization', () {
    test('converts TypeError in UI context to UIException', () {
      final typeError = TypeError();
      final event = SentryEvent(
        throwable: typeError,
        exceptions: [
          SentryException(
            type: 'TypeError',
            value: 'Null check operator used on a null value',
            stackTrace: SentryStackTrace(
              frames: [
                SentryStackFrame(
                  absPath: 'package:steamwise/features/apps/widgets/app_stats_display.dart',
                  fileName: 'app_stats_display.dart',
                  function: 'AppStatsDisplay.build.<fn>',
                  lineNo: 102,
                  inApp: true,
                ),
              ],
            ),
          ),
        ],
      );

      final result = wiseSentryBeforeSend(event);
      
      expect(result?.throwable, isA<UIException>());
      final uiException = result?.throwable as UIException;
      expect(uiException.message, contains('Type error'));
      expect(result?.tags?['error-category'], 'ui');
      expect(result?.tags?['wise-type'], 'UIException');
    });

    test('converts TypeError in DTO context to DTOException', () {
      final typeError = TypeError();
      final event = SentryEvent(
        throwable: typeError,
        exceptions: [
          SentryException(
            type: 'TypeError',
            value: 'Null check operator used on a null value',
            stackTrace: SentryStackTrace(
              frames: [
                SentryStackFrame(
                  absPath: 'package:steamwise/data/models/user_mapper.dart',
                  fileName: 'user_mapper.dart',
                  function: 'UserMapper.fromJson',
                  lineNo: 42,
                  inApp: true,
                ),
              ],
            ),
          ),
        ],
      );

      final result = wiseSentryBeforeSend(event);
      
      expect(result?.throwable, isA<DTOException>());
      final dtoException = result?.throwable as DTOException;
      expect(dtoException.message, contains('Type error during DTO deserialization'));
      expect(result?.tags?['error-category'], 'dto');
      expect(result?.tags?['wise-type'], 'DTOException');
    });

    test('categorizes TypeError with no clear context based on stack trace', () {
      final typeError = TypeError();
      final event = SentryEvent(
        throwable: typeError,
        exceptions: [
          SentryException(
            type: 'TypeError',
            value: 'Null check operator used on a null value',
            stackTrace: SentryStackTrace(
              frames: [
                SentryStackFrame(
                  absPath: 'dart:ui/hooks.dart',
                  fileName: 'hooks.dart',
                  function: '_drawFrame',
                  lineNo: 328,
                  inApp: false,
                ),
              ],
            ),
          ),
        ],
        threads: [
          SentryThread(
            stacktrace: SentryStackTrace(
              frames: [
                SentryStackFrame(
                  absPath: 'package:steamwise/features/dashboard/dashboard_page.dart',
                  fileName: 'dashboard_page.dart',
                  function: 'DashboardPage.build',
                  lineNo: 50,
                  inApp: true,
                ),
              ],
            ),
          ),
        ],
      );

      final result = wiseSentryBeforeSend(event);
      
      // Should fall back to stack trace analysis and detect UI category
      expect(result?.throwable, isA<UIException>());
      expect(result?.tags?['error-category'], 'ui');
    });
  });
}
