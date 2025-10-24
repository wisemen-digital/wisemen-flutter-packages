import 'package:dio/src/dio_exception.dart';

/// Base classs for all WiseSentry exceptions.
abstract class WiseException implements Exception {
  /// Base classs for all WiseSentry exceptions.
  WiseException(
    this.message, {
    this.originalError,
    this.stackTrace,
    this.extras,
  });

  /// A descriptive message about the error.
  final String message;

  /// The original error that was caught, if any.
  final dynamic originalError;

  /// The stack trace of the original error, if any.
  final StackTrace? stackTrace;

  /// Additional data to be sent with the error.
  final Map<String, dynamic>? extras;

  @override
  String toString() {
    return 'WiseException: $message';
  }

  /// Factory method to create a WiseException from a DioException
  static WiseException fromDioException(DioException e) {
    return HttpError(
      'Dio Request Failed (${e.response?.statusCode}): ${e.requestOptions.method} ${e.requestOptions.path}',
      statusCode: e.response?.statusCode,
      originalError: e,
      errorBody: e.response?.data,
      stackTrace: e.stackTrace,
    );
  }
}

/// HTTP/Network related errors (e.g., 404, 500, timeouts).
class HttpError extends WiseException {
  /// HTTP/Network related errors (e.g., 404, 500, timeouts).
  HttpError(
    super.message, {
    this.statusCode,
    this.errorBody,
    super.originalError,
    super.stackTrace,
  }) : super(
          extras: {
            'http_status': statusCode,
            'error_type': 'HttpError',
            if (errorBody != null) 'http_response_body': errorBody,
          },
        );

  /// The HTTP status code, if any.
  final int? statusCode;

  /// The response body or error details from the server, if any.
  final dynamic errorBody;
}

/// Errors during data transformation (e.g., JSON parsing failure, missing fields).
class MapperError extends WiseException {
  /// Errors during data transformation (e.g., JSON parsing failure, missing fields).
  MapperError(
    super.message, {
    super.originalError,
    super.stackTrace,
  }) : super(
          extras: {'error_type': 'MapperError'},
        );
}

/// Errors specific to core domain logic (e.g., invalid state, unauthorized actions).
class BusinessLogicError extends WiseException {
  /// Errors specific to core domain logic (e.g., invalid state, unauthorized actions).
  BusinessLogicError(
    super.message, {
    super.originalError,
    super.stackTrace,
  }) : super(
          extras: {'error_type': 'BusinessLogicError'},
        );
}

/// Errors originating from the Presentation/UI layer (e.g., unexpected user input).
class UIError extends WiseException {
  /// Errors originating from the Presentation/UI layer (e.g., unexpected user input).
  UIError(
    super.message, {
    super.originalError,
    super.stackTrace,
  }) : super(
          extras: {'error_type': 'UIError'},
        );
}
