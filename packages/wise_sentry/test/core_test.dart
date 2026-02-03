import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_sentry/wise_sentry.dart';
import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() {
  group('WiseSentry.captureException', () {
    test('captures regular exceptions', () {
      // This is hard to test without mocking Sentry, but we can at least verify it doesn't crash
      expect(
        () => WiseSentry.captureException(
          Exception('Test exception'),
          StackTrace.current,
        ),
        returnsNormally,
      );
    });

    test('captures exceptions with extras', () {
      expect(
        () => WiseSentry.captureException(
          Exception('Test exception'),
          StackTrace.current,
          extras: {'key': 'value', 'userId': 123},
        ),
        returnsNormally,
      );
    });

    test('merges WiseException extras with provided extras', () {
      final exception = DTOException(
        'DTO error',
        extras: {'dtoField': 'value', 'mapper': 'TestMapper'},
      );

      expect(
        () => WiseSentry.captureException(
          exception,
          StackTrace.current,
          extras: {'additional': 'data'},
        ),
        returnsNormally,
      );
    });

    test('handles WiseException with null extras', () {
      final exception = DTOException('DTO error');

      expect(
        () => WiseSentry.captureException(
          exception,
          StackTrace.current,
          extras: {'additional': 'data'},
        ),
        returnsNormally,
      );
    });

    test('handles null extras parameter', () {
      expect(
        () => WiseSentry.captureException(
          Exception('Test'),
          StackTrace.current,
        ),
        returnsNormally,
      );
    });
  });

  group('WiseSentry.setUserData', () {
    test('sets user data with id only', () {
      expect(
        () => WiseSentry.setUserData(uuid: 'user-123'),
        returnsNormally,
      );
    });

    test('sets user data with id and additional data', () {
      expect(
        () => WiseSentry.setUserData(
          uuid: 'user-456',
          data: {'email': 'test@example.com', 'name': 'Test User'},
        ),
        returnsNormally,
      );
    });
  });

  group('WiseSentry.clearUserData', () {
    test('clears user data', () {
      expect(
        () => WiseSentry.clearUserData(),
        returnsNormally,
      );
    });
  });

  group('WiseSentry.logDioError', () {
    test('logs DioException', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 404,
        ),
      );

      expect(
        () => WiseSentry.logDioError(dioError, StackTrace.current),
        returnsNormally,
      );
    });
  });

  group('WiseSentry.captureDioException', () {
    test('captures DioException', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );

      expect(
        () => WiseSentry.captureDioException(dioError, StackTrace.current),
        returnsNormally,
      );
    });
  });

  group('WiseSentry.logUIError', () {
    test('logs UI exceptions', () {
      expect(
        () => WiseSentry.logUIError(
          Exception('Widget build failed'),
          StackTrace.current,
        ),
        returnsNormally,
      );
    });

    test('logs UI errors', () {
      expect(
        () => WiseSentry.logUIError(
          StateError('Invalid state'),
          StackTrace.current,
        ),
        returnsNormally,
      );
    });

    test('logs string errors', () {
      expect(
        () => WiseSentry.logUIError(
          'String error message',
          StackTrace.current,
        ),
        returnsNormally,
      );
    });
  });

  group('WiseSentry exception type handling', () {
    test('handles different WiseException types', () {
      final exceptions = [
        DTOException('DTO error', extras: {'field': 'test'}),
        MapperException('Mapper error', extras: {'mapper': 'TestMapper'}),
        HttpException('HTTP error', statusCode: 500),
        UIException('UI error', extras: {'widget': 'TestWidget'}),
      ];

      for (final exception in exceptions) {
        expect(
          () => WiseSentry.captureException(exception, StackTrace.current),
          returnsNormally,
          reason: 'Should handle ${exception.runtimeType}',
        );
      }
    });
  });
}
