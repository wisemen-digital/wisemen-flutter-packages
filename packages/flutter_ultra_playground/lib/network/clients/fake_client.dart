import 'package:dio/dio.dart';
import 'package:dio/io.dart';

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
      interceptors.addAll(replacementInterceptors);
    } else {
      interceptors.addAll([
        if (wiseInterceptors.contains(WiseInterceptor.fresh)) fresh,
        ...wiseInterceptors.map((e) => e.getInterceptor()).nonNulls,
        if (interceptorsToAdd != null) ...interceptorsToAdd,
      ]);
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
    refreshErrorHandler: (Object p1, StackTrace p2) {},
    refreshBuffer: const Duration(seconds: 10),
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
  Stream<AuthenticationStatus> get authenticationStatus => Stream.value(AuthenticationStatus.authenticated);

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
  Future<Response<T>> deleteUri<T>(Uri uri, {Object? data, Options? options, CancelToken? cancelToken}) async {
    return _emptySuccessResponse<T>(uri.toString());
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
    return _dataResponse<T>(path: path, queryParameters: queryParameters);
  }

  @override
  Future<Response<T>> getUri<T>(Uri uri, {Object? data, Options? options, CancelToken? cancelToken, ProgressCallback? onReceiveProgress}) async {
    return _dataResponse<T>(path: uri.toString(), queryParameters: uri.queryParameters);
  }

  @override
  Future<Response<T>> head<T>(String path, {Object? data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) async {
    return _dataResponse<T>(path: path, queryParameters: queryParameters);
  }

  @override
  Future<Response<T>> headUri<T>(Uri uri, {Object? data, Options? options, CancelToken? cancelToken}) async {
    return _dataResponse<T>(path: uri.toString(), queryParameters: uri.queryParameters);
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
    return _dataResponse<T>(path: path, queryParameters: queryParameters);
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
    return _dataResponse<T>(path: uri.toString(), queryParameters: uri.queryParameters);
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
    return _dataResponse<T>(path: path, queryParameters: queryParameters);
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
    return _dataResponse<T>(path: uri.toString(), queryParameters: uri.queryParameters);
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
    return _dataResponse<T>(path: path, queryParameters: queryParameters);
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
    return _dataResponse<T>(path: uri.toString(), queryParameters: uri.queryParameters);
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
    return _dataResponse<T>(path: url, queryParameters: queryParameters);
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
    return _dataResponse<T>(path: uri.toString(), queryParameters: uri.queryParameters);
  }

  @override
  Dio clone({BaseOptions? options, Interceptors? interceptors, HttpClientAdapter? httpClientAdapter, Transformer? transformer}) {
    return this;
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
  Future<dynamic> wGet(String path, {Map<String, dynamic>? queryParameters, Object? body, Map<String, dynamic>? extraHeaders}) async {
    return _dataResponse<dynamic>(path: path, queryParameters: queryParameters).data;
  }

  @override
  Future wPost(String path, {Map<String, dynamic>? queryParameters, Object? body, Map<String, dynamic>? extraHeaders}) async {
    return _dataResponse<dynamic>(path: path, queryParameters: queryParameters).data;
  }

  @override
  Future wPut(String path, {Map<String, dynamic>? queryParameters, Object? body, Map<String, dynamic>? extraHeaders}) async {
    return _dataResponse<dynamic>(path: path, queryParameters: queryParameters).data;
  }

  /// Returns a successful empty response
  Response<T> _emptySuccessResponse<T>(String path) {
    return Response(requestOptions: RequestOptions(path: path), statusCode: 200);
  }

  /// Returns a successful response with empty map of item/list of items
  Response<T> _dataResponse<T>({required String path, Map<String, dynamic>? queryParameters}) {
    if (path.contains('auth/realms/secutec/protocol/openid-connect/token')) {
      return Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 200,
        data: <String, dynamic>{'access_token': 'fake_access', 'refresh_token': 'fake_refresh', 'expires_in': 3600, 'token_type': 'Bearer'} as T,
      );
    } else if (queryParameters?.isEmpty ?? true) {
      return Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 200,
        data: _singleData(id: path.split('/').last) as T,
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

  dynamic _singleData({String? id}) => <String, dynamic>{'id': id ?? '1'};

  dynamic get _listData => List.generate(20, (i) => <String, dynamic>{'id': (i + 1).toString()}).toList();

  dynamic get _paginatedData => <String, dynamic>{
    'data': List.generate(20, (i) => <String, dynamic>{'id': (i + 1).toString()}).toList(),
    'links': <String, dynamic>{'next': null},
  };

  @override
  Future<Response> download(
    String urlPath,
    savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    FileAccessMode fileAccessMode = FileAccessMode.write,
    String lengthHeader = Headers.contentLengthHeader,
    Object? data,
    Options? options,
  }) async {
    return _emptySuccessResponse<dynamic>(urlPath);
  }

  @override
  Future<Response> downloadUri(
    Uri uri,
    savePath, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    FileAccessMode fileAccessMode = FileAccessMode.write,
    String lengthHeader = Headers.contentLengthHeader,
    Object? data,
    Options? options,
  }) async {
    return _emptySuccessResponse<dynamic>(uri.toString());
  }
}
