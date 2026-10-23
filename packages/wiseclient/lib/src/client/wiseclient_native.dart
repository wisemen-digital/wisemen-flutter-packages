import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';
import 'package:wiseclient/wiseclient.dart';

/// Creates a [WiseClient] for native
WiseClient createClient({
  required Iterable<WiseInterceptor> wiseInterceptors,
  Future<OAuth2Token> Function(OAuth2Token?, Dio)? refreshFunction,
  BaseOptions? options,
  bool useNativeAdapter = false,
  Iterable<Interceptor>? interceptorsToAdd,
  Iterable<Interceptor>? replacementInterceptors,
  Fresh<OAuth2Token>? fresh,
}) => NativeWiseClient(
  wiseInterceptors: wiseInterceptors,
  baseOptions: options,
  refreshFunction: refreshFunction,
  useNativeAdapter: useNativeAdapter,
  interceptorsToAdd: interceptorsToAdd,
  replacementInterceptors: replacementInterceptors,
  fresh: fresh,
);

/// Implements [DioForNative] for native
base class NativeWiseClient extends DioForNative with WiseClient {
  /// Creates a [NativeWiseClient] instance
  NativeWiseClient({
    required Iterable<WiseInterceptor> wiseInterceptors,
    required bool useNativeAdapter,
    Future<OAuth2Token> Function(OAuth2Token?, Dio)? refreshFunction,
    BaseOptions? baseOptions,
    Iterable<Interceptor>? interceptorsToAdd,
    Iterable<Interceptor>? replacementInterceptors,
    Fresh<OAuth2Token>? fresh,
  }) {
    options = baseOptions ?? BaseOptions();
    HttpClientAdapter createAdapter() =>
        useNativeAdapter ? NativeAdapter() : IOHttpClientAdapter();
    httpClientAdapter = createAdapter();
    if (replacementInterceptors != null) {
      interceptors.addAll(
        replacementInterceptors,
      );
    } else {
      if (wiseInterceptors.contains(WiseInterceptor.fresh)) {
        this.fresh =
            fresh ??
            getFreshInterceptor(
              refreshFunction: refreshFunction!,
              httpClient: Dio(options.copyWith())
                ..httpClientAdapter = createAdapter(),
            );
      }
      interceptors.addAll(
        [
          if (wiseInterceptors.contains(WiseInterceptor.fresh)) this.fresh,
          if (interceptorsToAdd != null) ...interceptorsToAdd,
          ...wiseInterceptors.map((e) => e.getInterceptor()).nonNulls,
        ],
      );
    }
  }

  @override
  bool get isWebClient => false;
}
