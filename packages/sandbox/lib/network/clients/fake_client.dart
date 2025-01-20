import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fresh_dio/fresh_dio.dart';

import 'package:wiseclient/wiseclient.dart';

/// Implements [DioForNative] for native
class FakerWiseClient implements WiseClient {
  /// Creates a [FakerWiseClient] instance for mocking purposes
  FakerWiseClient({
    required Iterable<WiseInterceptor> wiseInterceptors,
    BaseOptions? baseOptions,
    Iterable<Interceptor>? interceptorsToAdd,
    Iterable<Interceptor>? replacementInterceptors,
  }) {
    options = baseOptions ?? BaseOptions();
    if (replacementInterceptors != null) {
      interceptors.addAll(
        replacementInterceptors,
      );
    } else {
      interceptors.addAll(
        [
          if (wiseInterceptors.contains(WiseInterceptor.fresh)) fresh,
          ...wiseInterceptors.map((e) => e.getInterceptor()).nonNulls,
          if (interceptorsToAdd != null) ...interceptorsToAdd,
        ],
      );
    }
  }

  @override
  bool get isWebClient => false;

  @override
  CancelToken cancelToken = CancelToken();

  @override
  Fresh<OAuth2Token> fresh = Fresh.oAuth2(
    tokenStorage: InMemoryTokenStorage(),
    refreshToken: (_, __) async => const OAuth2Token(accessToken: ''),
  );

  @override
  HttpClientAdapter httpClientAdapter = HttpClientAdapter();

  @override
  BaseOptions options = BaseOptions();

  @override
  Transformer transformer = BackgroundTransformer();

  @override
  void addHeaders({required Map<String, dynamic> headers}) {
    options.headers.addAll(headers);
  }

  @override
  Stream<AuthenticationStatus> get authenticationStatus => Stream.value(
        AuthenticationStatus.authenticated,
      );

  @override
  Future<void> cancelAndReset({Duration? cancelDuration}) async {}

  @override
  void cancelWiseRequests() {}

  @override
  void close({bool force = false}) {}

  @override
  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _emptySuccessResponse<T>(path);
  }

  @override
  Future<Response<T>> deleteUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _emptySuccessResponse<T>(
      uri.toString(),
    );
  }

  @override
  Future<Response<dynamic>> download(
    String urlPath,
    dynamic savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Object? data,
    Options? options,
  }) async {
    return _emptySuccessResponse<dynamic>(urlPath);
  }

  @override
  Future<Response<dynamic>> downloadUri(
    Uri uri,
    dynamic savePath, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Object? data,
    Options? options,
  }) async {
    return _emptySuccessResponse<dynamic>(uri.toString());
  }

  @override
  Future<Response<T>> fetch<T>(RequestOptions requestOptions) async {
    return Response(requestOptions: requestOptions);
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _dataResponse<T>(
      path: path,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response<T>> getUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _dataResponse<T>(
      path: uri.toString(),
      queryParameters: uri.queryParameters,
    );
  }

  @override
  Future<Response<T>> head<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dataResponse<T>(
      path: path,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response<T>> headUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dataResponse<T>(
      path: uri.toString(),
      queryParameters: uri.queryParameters,
    );
  }

  @override
  Interceptors get interceptors => Interceptors();

  @override
  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _dataResponse<T>(
      path: path,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response<T>> patchUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _dataResponse<T>(
      path: uri.toString(),
      queryParameters: uri.queryParameters,
    );
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _dataResponse<T>(
      path: path,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response<T>> postUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _dataResponse<T>(
      path: uri.toString(),
      queryParameters: uri.queryParameters,
    );
  }

  @override
  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _dataResponse<T>(
      path: path,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response<T>> putUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _dataResponse<T>(
      path: uri.toString(),
      queryParameters: uri.queryParameters,
    );
  }

  @override
  Future<void> removeFreshToken() async {
    await fresh.revokeToken();
  }

  @override
  Future<Response<T>> request<T>(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _dataResponse<T>(
      path: url,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response<T>> requestUri<T>(
    Uri uri, {
    Object? data,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _dataResponse<T>(
      path: uri.toString(),
      queryParameters: uri.queryParameters,
    );
  }

  @override
  void resetWiseCancelToken() {
    cancelToken = CancelToken();
  }

  @override
  Future<void> setFreshToken({required OAuth2Token token}) async {
    await fresh.setToken(token);
  }

  @override
  Future<dynamic> wGet(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? extraHeaders,
  }) async {
    return _dataResponse<dynamic>(
      path: path,
      queryParameters: queryParameters,
    ).data;
  }

  @override
  Future wPost(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? extraHeaders,
  }) async {
    return _dataResponse<dynamic>(
      path: path,
      queryParameters: queryParameters,
    ).data;
  }

  @override
  Future wPut(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? extraHeaders,
  }) async {
    return _dataResponse<dynamic>(
      path: path,
      queryParameters: queryParameters,
    ).data;
  }

  /// Returns a successful empty response
  Response<T> _emptySuccessResponse<T>(String path) {
    return Response(
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
    );
  }

  /// Returns a successful response with empty map of item/list of items
  Response<T> _dataResponse<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) {
    if (queryParameters?.isEmpty ?? true) {
      return Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 200,
        data: _singleData as T,
      );
    } else if (queryParameters?.containsKey('pagination') ?? false) {
      return Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 200,
        data: _paginatedData as T,
      );
    } else {
      return Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 200,
        data: _listData as T,
      );
    }
  }

  dynamic get _singleData => <String, dynamic>{};

  dynamic get _listData => List.generate(
        20,
        (i) => <String, dynamic>{},
      ).toList();

  dynamic get _paginatedData => <String, dynamic>{
        'data': List.generate(
          20,
          (i) => <String, dynamic>{},
        ).toList(),
        'links': <String, dynamic>{
          'next': null,
        },
      };
}
