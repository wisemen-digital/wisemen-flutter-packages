/// Standard API error response model.
/// Represents the common error format returned by your backend API.
class ApiErrorResponse {
  /// Creates an API error response.
  const ApiErrorResponse({
    required this.errors,
    this.traceId,
  });

  /// List of error details.
  final List<ApiErrorDetail> errors;

  /// Trace ID for debugging (if provided by backend).
  final String? traceId;

  /// Creates an [ApiErrorResponse] from JSON.
  /// Returns null if the JSON doesn't match the expected format.
  static ApiErrorResponse? fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) return null;

    try {
      final errorsJson = json['errors'];
      if (errorsJson is! List) return null;

      final errors = errorsJson.map((e) => ApiErrorDetail.fromJson(e)).whereType<ApiErrorDetail>().toList();

      if (errors.isEmpty) return null;

      return ApiErrorResponse(
        errors: errors,
        traceId: json['traceId'] as String?,
      );
    } catch (_) {
      return null;
    }
  }

  /// Converts this error response to a map for Sentry extras.
  Map<String, dynamic> toSentryExtras() {
    return {
      'api_errors': errors.map((e) => e.toMap()).toList(),
      if (traceId != null) 'api_trace_id': traceId,
      'error_count': errors.length,
      if (errors.isNotEmpty) 'first_error_code': errors.first.code,
      if (errors.isNotEmpty) 'first_error_detail': errors.first.detail,
    };
  }

  /// Gets a human-readable summary of the first error.
  String getSummary() {
    if (errors.isEmpty) return 'Unknown API error';
    final first = errors.first;
    return '${first.code ?? first.status ?? 'Error'}: ${first.detail ?? 'No details'}';
  }

  @override
  String toString() {
    final summary = getSummary();
    if (traceId != null) {
      return '$summary (trace: $traceId)';
    }
    return summary;
  }
}

/// Represents a single error detail from the API response.
class ApiErrorDetail {
  /// Creates an API error detail.
  const ApiErrorDetail({
    this.status,
    this.code,
    this.detail,
    this.message,
    this.field,
    this.meta,
  });

  /// HTTP status code as string.
  final String? status;

  /// Error code (e.g., "NotFoundException").
  final String? code;

  /// Detailed error description.
  final String? detail;

  /// Error message (alternative to detail).
  final String? message;

  /// Field name if this is a validation error.
  final String? field;

  /// Additional metadata.
  final Map<String, dynamic>? meta;

  /// Creates an [ApiErrorDetail] from JSON.
  /// Returns null if the JSON is invalid.
  static ApiErrorDetail? fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) return null;

    try {
      return ApiErrorDetail(
        status: json['status']?.toString(),
        code: json['code'] as String?,
        detail: json['detail'] as String?,
        message: json['message'] as String?,
        field: json['field'] as String?,
        meta: json['meta'] as Map<String, dynamic>?,
      );
    } catch (_) {
      return null;
    }
  }

  /// Converts this error detail to a map.
  Map<String, dynamic> toMap() {
    return {
      if (status != null) 'status': status,
      if (code != null) 'code': code,
      if (detail != null) 'detail': detail,
      if (message != null) 'message': message,
      if (field != null) 'field': field,
      if (meta != null) 'meta': meta,
    };
  }

  @override
  String toString() {
    final parts = <String>[];
    if (code != null) parts.add(code!);
    if (status != null) parts.add('($status)');
    if (detail != null) {
      parts.add(detail!);
    } else if (message != null) {
      parts.add(message!);
    }
    if (field != null) parts.add('[field: $field]');
    return parts.join(' ');
  }
}
