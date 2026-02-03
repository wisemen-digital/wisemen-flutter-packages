import 'package:dio/dio.dart';

import 'api_error_response.dart';

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
    // Try to parse the standard API error response
    final apiError = ApiErrorResponse.fromJson(e.response?.data);

    // Use API error detail if available, otherwise build a descriptive message
    String message;
    if (apiError?.errors.firstOrNull?.detail != null) {
      message = apiError!.errors.first.detail!;
    } else if (e.response?.data != null && e.response!.data is String) {
      // If response body is a plain string, include it
      message = 'HTTP ${e.response?.statusCode}: ${e.response!.data}';
    } else {
      // Generic fallback
      message = 'HTTP ${e.response?.statusCode}: ${e.requestOptions.method} ${e.requestOptions.path}';
    }

    return HttpException(
      message,
      statusCode: e.response?.statusCode,
      originalError: e,
      errorBody: e.response?.data,
      apiError: apiError,
      stackTrace: e.stackTrace,
    );
  }
}

/// HTTP/Network related exceptions (e.g., 404, 500, timeouts).
class HttpException extends WiseException {
  /// HTTP/Network related exceptions (e.g., 404, 500, timeouts).
  HttpException(
    super.message, {
    this.statusCode,
    this.errorBody,
    this.apiError,
    super.originalError,
    super.stackTrace,
  }) : super(
          extras: {
            'http_status': statusCode,
            'error_type': 'HttpException',
            if (errorBody != null) 'http_response_body': errorBody,
            // Add parsed API error details if available
            if (apiError != null) ...apiError.toSentryExtras(),
          },
        );

  /// The HTTP status code, if any.
  final int? statusCode;

  /// The response body or error details from the server, if any.
  final dynamic errorBody;

  /// Parsed API error response (if the response matches the standard format).
  final ApiErrorResponse? apiError;

  @override
  String toString() {
    // Use API error code and detail if available for cleaner display
    if (apiError?.errors.firstOrNull != null) {
      final error = apiError!.errors.first;
      return 'HttpException: ${error.code} ($statusCode) - ${error.detail}';
    }
    return 'HttpException: $message';
  }
}

/// Exceptions during data transformation (e.g., JSON parsing failure, missing fields).
class MapperException extends WiseException {
  /// Exceptions during data transformation (e.g., JSON parsing failure, missing fields).
  MapperException(
    super.message, {
    super.originalError,
    super.stackTrace,
    Map<String, dynamic>? extras, // NEW: Accept extras parameter
  }) : super(
          extras: {
            'error_type': 'MapperException',
            ...(extras ?? {}), // NEW: Merge with provided extras
          },
        );
}

/// Exceptions related to DTO/Network data (e.g., invalid data from API, DTO parsing failure).
class DTOException extends WiseException {
  /// Exceptions related to DTO/Network data (e.g., invalid data from API, DTO parsing failure).
  DTOException(
    super.message, {
    super.originalError,
    super.stackTrace,
    Map<String, dynamic>? extras,
  }) : super(
          extras: {
            'error_type': 'DTOException',
            ...(extras ?? {}),
          },
        );
}

/// Exceptions originating from the Presentation/UI layer (e.g., unexpected user input).
class UIException extends WiseException {
  /// Exceptions originating from the Presentation/UI layer (e.g., unexpected user input).
  UIException(
    super.message, {
    super.originalError,
    super.stackTrace,
    Map<String, dynamic>? extras,
  }) : super(
          extras: {
            'error_type': 'UIException',
            ...(extras ?? {}),
          },
        );
}

/// Exceptions related to type mismatches, often during data mapping or deserialization.
class WiseTypeException extends WiseException {
  /// Exceptions related to type mismatches, often during data mapping or deserialization.
  WiseTypeException(
    super.message, {
    required this.expectedType,
    required this.actualValue,
    this.fieldName,
    super.originalError,
    super.stackTrace,
    Map<String, dynamic>? extras, // NEW: Accept extras parameter
  }) : super(
          extras: {
            'error_type': 'WiseTypeException',
            'expected_type': expectedType,
            'actual_value': actualValue.toString(), // Convert to string for Sentry
            if (fieldName != null) 'field_name': fieldName,
            ...(extras ?? {}), // NEW: Merge with provided extras
          },
        );

  /// The type that was expected.
  final String expectedType;

  /// The actual value that caused the type error.
  final dynamic actualValue;

  /// The name of the field that caused the type error, if applicable.
  final String? fieldName;

  @override
  String toString() {
    final fieldInfo = fieldName != null ? ' (Field: $fieldName)' : '';
    return 'WiseTypeException: $message$fieldInfo. Expected $expectedType, got $actualValue.';
  }
}
