import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';

import 'client/wiseclient_native.dart'
    if (dart.library.js_interop) 'client/wiseclient_web.dart';
import 'exceptions/exceptions.dart';
import 'interceptors/interceptors.dart';
import 'options.dart';

/// A networking client that extends [Dio]
abstract mixin class WiseClient implements Dio {
  /// Creates [WiseClient] instance
  ///
  /// [WiseInterceptor.fresh] needs either a [refreshFunction], to create a new
  /// [Fresh] instance, or an existing [fresh] instance. Pass another client's
  /// [WiseClient.fresh] to let both clients share one session: clients with
  /// their own [Fresh] each keep a separate copy of the token and log each
  /// other out when the refresh token rotates.
  factory WiseClient({
    required Iterable<WiseInterceptor> wiseInterceptors,
    Future<OAuth2Token> Function(OAuth2Token?, Dio)? refreshFunction,
    WiseOptions? options,
    bool useNativeAdapter = false,
    Iterable<Interceptor>? interceptorsToAdd,
    Iterable<Interceptor>? interceptors,
    Fresh<OAuth2Token>? fresh,
  }) {
    assert(
      wiseInterceptors.contains(WiseInterceptor.fresh)
          ? (refreshFunction == null) != (fresh == null)
          : refreshFunction == null && fresh == null,
      'WiseInterceptor.fresh requires either a refreshFunction or a fresh '
      'instance, and neither is used without it',
    );
    return createClient(
      wiseInterceptors: wiseInterceptors,
      options: options,
      refreshFunction: refreshFunction,
      useNativeAdapter: useNativeAdapter,
      interceptorsToAdd: interceptorsToAdd,
      replacementInterceptors: interceptors,
      fresh: fresh,
    );
  }

  /// Checks if client is an instance on web or native
  bool get isWebClient => throw UnimplementedError();

  Fresh<OAuth2Token>? _fresh;

  /// [Fresh] to handle authentication
  ///
  /// Throws a [StateError] when the client was created without
  /// [WiseInterceptor.fresh], so the token methods can't silently change the
  /// session of another client sharing the same token storage.
  Fresh<OAuth2Token> get fresh =>
      _fresh ??
      (throw StateError(
        'WiseClient was created without WiseInterceptor.fresh, '
        'so it has no token to manage',
      ));

  set fresh(Fresh<OAuth2Token> fresh) => _fresh = fresh;

  /// [CancelToken] for wise requests
  CancelToken cancelToken = CancelToken();

  /// [Stream] of [AuthenticationStatus], see [fresh] for clients without it
  Stream<AuthenticationStatus> get authenticationStatus {
    return fresh.authenticationStatus;
  }

  /// [wGet] method replaces get with build in features
  Future<dynamic> wGet(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? extraHeaders,
  }) async {
    return _wrapRequest(
      () => get<dynamic>(
        path,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        data: body,
        options: _buildOptions(extraHeaders),
      ),
    );
  }

  /// [wPost] method replaces get with build in features
  Future<dynamic> wPost(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? extraHeaders,
  }) async {
    return _wrapRequest(
      () => post<dynamic>(
        path,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        data: body,
        options: _buildOptions(extraHeaders),
      ),
    );
  }

  /// [wPut] method replaces put with build in features
  Future<dynamic> wPut(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? extraHeaders,
  }) async {
    return _wrapRequest(
      () => put<dynamic>(
        path,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        data: body,
        options: _buildOptions(extraHeaders),
      ),
    );
  }

  Future<dynamic> _wrapRequest(
    Future<Response<dynamic>> Function() action,
  ) async {
    try {
      final response = await action();
      return response.data;
    } on DioException {
      rethrow;
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  Options? _buildOptions(Map<String, dynamic>? headers) {
    return headers != null ? Options(headers: headers) : null;
  }

  /// [cancelAndReset] method cancels current requests and resets the cancel token
  Future<void> cancelAndReset({Duration? cancelDuration}) async {
    cancelToken.cancel();
    await Future.delayed(
      cancelDuration ?? const Duration(milliseconds: 300),
      () {
        cancelToken = CancelToken();
      },
    );
  }

  /// [cancelWiseRequests] method cancels current requests
  void cancelWiseRequests() {
    cancelToken.cancel();
  }

  /// [resetWiseCancelToken] method resets the cancel token
  void resetWiseCancelToken() {
    cancelToken = CancelToken();
  }

  /// [removeFreshToken] method that removes bearer authentication token
  Future<void> removeFreshToken() async {
    await Future.wait([
      fresh.setToken(null),
      fresh.revokeToken(),
    ]);
  }

  /// [setFreshToken] method that sets bearer authentication token
  Future<void> setFreshToken({required OAuth2Token token}) async {
    await fresh.setToken(token);
  }

  /// [addHeaders] method that adds permanent headers to the client
  void addHeaders({required Map<String, dynamic> headers}) {
    options.headers.addAll(headers);
  }
}
