//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:openapi/src/api_util.dart';
import 'package:openapi/src/model/view_domain_event_log_index_filter_query.dart';
import 'package:openapi/src/model/view_domain_event_log_index_pagination_query.dart';
import 'package:openapi/src/model/view_domain_event_log_index_response.dart';

class EventLogApi {
  final Dio _dio;

  final Serializers _serializers;

  const EventLogApi(this._dio, this._serializers);

  /// viewDomainEventLogIndexV1
  ///
  ///
  /// Parameters:
  /// * [filter]
  /// * [pagination]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ViewDomainEventLogIndexResponse] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ViewDomainEventLogIndexResponse>> viewDomainEventLogIndexV1({
    ViewDomainEventLogIndexFilterQuery? filter,
    ViewDomainEventLogIndexPaginationQuery? pagination,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/event-logs';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{'secure': <Map<String, String>>[], ...?extra},
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (filter != null)
        r'filter': encodeQueryParameter(
          _serializers,
          filter,
          const FullType(ViewDomainEventLogIndexFilterQuery),
        ),
      if (pagination != null)
        r'pagination': encodeQueryParameter(
          _serializers,
          pagination,
          const FullType(ViewDomainEventLogIndexPaginationQuery),
        ),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ViewDomainEventLogIndexResponse? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null
          ? null
          : _serializers.deserialize(
                  rawResponse,
                  specifiedType: const FullType(
                    ViewDomainEventLogIndexResponse,
                  ),
                )
                as ViewDomainEventLogIndexResponse;
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<ViewDomainEventLogIndexResponse>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }
}
