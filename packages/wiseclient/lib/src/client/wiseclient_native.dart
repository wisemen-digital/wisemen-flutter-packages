import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';
import 'package:wiseclient/wiseclient.dart';

/// Creates a [WiseClient] for native
WiseClient createClient({
  required Iterable<WiseInterceptor> wiseInterceptors,
  required Duration refreshBuffer,
  Future<OAuth2Token> Function(OAuth2Token?, Dio)? refreshFunction,
  BaseOptions? options,
  bool useNativeAdapter = false,
  Iterable<Interceptor>? interceptorsToAdd,
  Iterable<Interceptor>? replacementInterceptors,
  void Function(Object, StackTrace)? refreshErrorHandler,
}) =>
    NativeWiseClient(
      wiseInterceptors: wiseInterceptors,
      refreshBuffer: refreshBuffer,
      baseOptions: options,
      refreshFunction: refreshFunction,
      useNativeAdapter: useNativeAdapter,
      interceptorsToAdd: interceptorsToAdd,
      replacementInterceptors: replacementInterceptors,
      refreshErrorHandler: refreshErrorHandler ?? (_, __) => {},
    );

/// Implements [DioForNative] for native
base class NativeWiseClient extends DioForNative with WiseClient {
  /// Creates a [NativeWiseClient] instance
  NativeWiseClient({
    required Iterable<WiseInterceptor> wiseInterceptors,
    required bool useNativeAdapter,
    required void Function(Object, StackTrace) refreshErrorHandler,
    Future<OAuth2Token> Function(OAuth2Token?, Dio)? refreshFunction,
    BaseOptions? baseOptions,
    Iterable<Interceptor>? interceptorsToAdd,
    Iterable<Interceptor>? replacementInterceptors,
    Duration refreshBuffer = const Duration(minutes: 10),
  }) {
    options = baseOptions ?? BaseOptions();
    httpClientAdapter =
        useNativeAdapter ? NativeAdapter() : IOHttpClientAdapter();
    if (replacementInterceptors != null) {
      interceptors.addAll(
        replacementInterceptors,
      );
    } else {
      if (wiseInterceptors.contains(WiseInterceptor.fresh)) {
        fresh = getFreshInterceptor(
          refreshFunction: refreshFunction!,
          refreshErrorHandler: refreshErrorHandler,
          refreshBuffer: refreshBuffer,
        );
      }
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
}
