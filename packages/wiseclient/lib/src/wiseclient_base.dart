import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'client/wiseclient_native.dart'
    if (dart.library.html) 'client/wiseclient_web.dart';
import 'exceptions/exceptions.dart';
import 'interceptors/interceptors.dart';
import 'options.dart';
import 'secure_token_storage/fresh_secure_token_storage.dart';

/// A networking client that extends [Dio]
abstract mixin class WiseClient implements Dio {
  /// Creates [WiseClient] instance
  factory WiseClient({
    required Iterable<WiseInterceptor> wiseInterceptors,
    Future<OAuth2Token> Function(OAuth2Token?, Dio)? refreshFunction,
    WiseOptions? options,
    bool useNativeAdapter = false,
    Iterable<Interceptor>? interceptorsToAdd,
    Iterable<Interceptor>? interceptors,
  }) {
    assert(
      wiseInterceptors.contains(WiseInterceptor.fresh)
          ? refreshFunction != null
          : refreshFunction == null,
      'RefreshFunction is required when using fresh interceptor',
    );
    return createClient(
      wiseInterceptors: wiseInterceptors,
      options: options,
      refreshFunction: refreshFunction,
      useNativeAdapter: useNativeAdapter,
      interceptorsToAdd: interceptorsToAdd,
      replacementInterceptors: interceptors,
    );
  }

  /// Checks if client is an instance on web or native
  bool get isWebClient => throw UnimplementedError();

  /// [Fresh] to handle authentication
  Fresh<OAuth2Token> fresh = Fresh.oAuth2(
    tokenStorage: FreshSecureTokenStorage(),
    refreshToken: (_, __) async => const OAuth2Token(accessToken: ''),
  );

  /// [CancelToken] for wise requests
  CancelToken cancelToken = CancelToken();

  /// [Stream] of [AuthenticationStatus], only works if [Fresh] client is in use
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
    try {
      final response = await get<dynamic>(
        path,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        data: body,
        options: extraHeaders != null
            ? Options(
                headers: extraHeaders,
              )
            : null,
      );
      return response.data;
    } on DioException {
      rethrow;
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  /// [wPost] method replaces get with build in features
  Future<dynamic> wPost(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? extraHeaders,
  }) async {
    try {
      final response = await post<dynamic>(
        path,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        data: body,
        options: extraHeaders != null
            ? Options(
                headers: extraHeaders,
              )
            : null,
      );
      return response.data;
    } on DioException {
      rethrow;
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  /// [wPut] method replaces put with build in features
  Future<dynamic> wPut(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? extraHeaders,
  }) async {
    try {
      final response = await put<dynamic>(
        path,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        data: body,
        options: extraHeaders != null
            ? Options(
                headers: extraHeaders,
              )
            : null,
      );
      return response.data;
    } on DioException {
      rethrow;
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  /// [cancelAndReset] method cancels current requests and resets the canceltoken
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
