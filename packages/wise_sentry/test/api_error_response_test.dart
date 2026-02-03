import 'package:flutter_test/flutter_test.dart';
import 'package:wise_sentry/wise_sentry.dart';

void main() {
  group('ApiErrorResponse', () {
    test('parses standard error response', () {
      final json = {
        'errors': [
          {
            'status': '404',
            'code': 'NotFoundException',
            'detail': 'Cannot GET /api/v1/apps/123?timespan=this_month',
          },
        ],
        'traceId': '6cd9154472293f496540d2f70965bc3c',
      };

      final apiError = ApiErrorResponse.fromJson(json);

      expect(apiError, isNotNull);
      expect(apiError!.errors.length, 1);
      expect(apiError.traceId, '6cd9154472293f496540d2f70965bc3c');
      expect(apiError.errors.first.status, '404');
      expect(apiError.errors.first.code, 'NotFoundException');
      expect(apiError.errors.first.detail, contains('Cannot GET'));
    });

    test('handles multiple errors', () {
      final json = {
        'errors': [
          {
            'status': '400',
            'code': 'ValidationError',
            'detail': 'Invalid timespan',
            'field': 'timespan',
          },
          {
            'status': '400',
            'code': 'ValidationError',
            'detail': 'Invalid user ID',
            'field': 'userId',
          },
        ],
      };

      final apiError = ApiErrorResponse.fromJson(json);

      expect(apiError, isNotNull);
      expect(apiError!.errors.length, 2);
      expect(apiError.errors[0].field, 'timespan');
      expect(apiError.errors[1].field, 'userId');
    });

    test('returns null for invalid format', () {
      expect(ApiErrorResponse.fromJson(null), isNull);
      expect(ApiErrorResponse.fromJson('string'), isNull);
      expect(ApiErrorResponse.fromJson({}), isNull);
      expect(ApiErrorResponse.fromJson({'errors': 'not a list'}), isNull);
      expect(ApiErrorResponse.fromJson({'errors': []}), isNull);
    });

    test('getSummary returns formatted error message', () {
      final json = {
        'errors': [
          {
            'status': '404',
            'code': 'NotFoundException',
            'detail': 'Resource not found',
          },
        ],
      };

      final apiError = ApiErrorResponse.fromJson(json)!;
      expect(apiError.getSummary(), 'NotFoundException: Resource not found');
    });

    test('toSentryExtras includes all relevant data', () {
      final json = {
        'errors': [
          {
            'status': '406',
            'code': 'NotAcceptableException',
            'detail': 'Invalid accept header',
          },
        ],
        'traceId': 'abc123',
      };

      final apiError = ApiErrorResponse.fromJson(json)!;
      final extras = apiError.toSentryExtras();

      expect(extras['api_trace_id'], 'abc123');
      expect(extras['error_count'], 1);
      expect(extras['first_error_code'], 'NotAcceptableException');
      expect(extras['first_error_detail'], 'Invalid accept header');
      expect(extras['api_errors'], isA<List>());
    });

    test('toString includes trace ID when available', () {
      final json = {
        'errors': [
          {
            'code': 'TestError',
            'detail': 'Test message',
          },
        ],
        'traceId': 'trace-123',
      };

      final apiError = ApiErrorResponse.fromJson(json)!;
      expect(apiError.toString(), contains('trace-123'));
    });
  });

  group('HttpException with ApiError', () {
    test('includes parsed API error in extras', () {
      final errorData = {
        'errors': [
          {
            'status': '404',
            'code': 'NotFoundException',
            'detail': 'Resource not found',
          },
        ],
        'traceId': 'test-trace-id',
      };

      final apiError = ApiErrorResponse.fromJson(errorData);
      final httpException = HttpException(
        'Request failed',
        statusCode: 404,
        errorBody: errorData,
        apiError: apiError,
      );

      expect(httpException.apiError, isNotNull);
      expect(httpException.extras?['api_trace_id'], 'test-trace-id');
      expect(httpException.extras?['first_error_code'], 'NotFoundException');
      expect(httpException.extras?['api_errors'], isNotNull);
    });

    test('works without API error when format is different', () {
      final errorData = {
        'message': 'Some other error format',
      };

      final httpException = HttpException(
        'Request failed',
        statusCode: 500,
        errorBody: errorData,
        apiError: null,
      );

      expect(httpException.apiError, isNull);
      expect(httpException.extras?['api_trace_id'], isNull);
      expect(httpException.extras?['http_response_body'], errorData);
    });
  });

  group('Real-world scenarios', () {
    test('parses 404 error from your API', () {
      final json = {
        'errors': [
          {
            'status': '404',
            'code': 'NotFoundException',
            'detail': 'Cannot GET /api/v1/apps1122/5ed86931-a6ea-434c-95e4-3a6076c9a3f0?timespan=this_month',
          },
        ],
        'traceId': '6cd9154472293f496540d2f70965bc3c',
      };

      final apiError = ApiErrorResponse.fromJson(json)!;

      print('\n=== Parsed API Error ===');
      print('Summary: ${apiError.getSummary()}');
      print('Trace ID: ${apiError.traceId}');
      print('Full toString: $apiError');
      print('\nSentry Extras:');
      apiError.toSentryExtras().forEach((key, value) {
        print('  $key: $value');
      });
      print('========================\n');

      expect(apiError.traceId, '6cd9154472293f496540d2f70965bc3c');
      expect(apiError.errors.first.code, 'NotFoundException');
    });

    test('parses 406 error from your API', () {
      final json = {
        'errors': [
          {
            'status': '406',
            'code': 'NotAcceptableException',
            'detail': 'Cannot GET /api/v1/apps1122/5ed86931-a6ea-434c-95e4-3a6076c9a3f0?timespan=invalid',
          },
        ],
        'traceId': 'e4aa1f30b7010d2bd9b51d14ad333587',
      };

      final apiError = ApiErrorResponse.fromJson(json)!;

      print('\n=== 406 Error ===');
      print(apiError);
      print('=================\n');

      expect(apiError.errors.first.status, '406');
      expect(apiError.errors.first.code, 'NotAcceptableException');
    });
  });
}
