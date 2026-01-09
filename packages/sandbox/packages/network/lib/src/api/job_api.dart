//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/api_util.dart';
import 'package:openapi/src/model/view_job_detail_response.dart';
import 'package:openapi/src/model/view_jobs_index_filter_query.dart';
import 'package:openapi/src/model/view_jobs_index_pagination_query.dart';
import 'package:openapi/src/model/view_jobs_index_response.dart';
import 'package:openapi/src/model/view_jobs_index_sort_query.dart';

class JobApi {
  final Dio _dio;

  final Serializers _serializers;

  const JobApi(this._dio, this._serializers);

  /// viewJobDetailV1
  ///
  ///
  /// Parameters:
  /// * [jobId]
  /// * [isArchived]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ViewJobDetailResponse] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ViewJobDetailResponse>> viewJobDetailV1({
    required String jobId,
    required bool isArchived,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/jobs/{jobId}'.replaceAll(
      '{'
      r'jobId'
      '}',
      encodeQueryParameter(
        _serializers,
        jobId,
        const FullType(String),
      ).toString(),
    );
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{'secure': <Map<String, String>>[], ...?extra},
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      r'isArchived': encodeQueryParameter(
        _serializers,
        isArchived,
        const FullType(bool),
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

    ViewJobDetailResponse? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null
          ? null
          : _serializers.deserialize(
                  rawResponse,
                  specifiedType: const FullType(ViewJobDetailResponse),
                )
                as ViewJobDetailResponse;
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<ViewJobDetailResponse>(
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

  /// viewJobsIndexV1
  ///
  ///
  /// Parameters:
  /// * [sort]
  /// * [filter]
  /// * [pagination]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ViewJobsIndexResponse] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ViewJobsIndexResponse>> viewJobsIndexV1({
    BuiltList<ViewJobsIndexSortQuery>? sort,
    ViewJobsIndexFilterQuery? filter,
    ViewJobsIndexPaginationQuery? pagination,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/jobs';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{'secure': <Map<String, String>>[], ...?extra},
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (sort != null)
        r'sort': encodeCollectionQueryParameter<ViewJobsIndexSortQuery>(
          _serializers,
          sort,
          const FullType(BuiltList, [FullType(ViewJobsIndexSortQuery)]),
          format: ListFormat.multi,
        ),
      if (filter != null)
        r'filter': encodeQueryParameter(
          _serializers,
          filter,
          const FullType(ViewJobsIndexFilterQuery),
        ),
      if (pagination != null)
        r'pagination': encodeQueryParameter(
          _serializers,
          pagination,
          const FullType(ViewJobsIndexPaginationQuery),
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

    ViewJobsIndexResponse? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null
          ? null
          : _serializers.deserialize(
                  rawResponse,
                  specifiedType: const FullType(ViewJobsIndexResponse),
                )
                as ViewJobsIndexResponse;
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<ViewJobsIndexResponse>(
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
