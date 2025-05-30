import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:wiseclient/src/wiseclient_base.dart';

import '../interceptors/interceptors.dart';

/// Creates a [WiseClient] for native
WiseClient createClient({
  required Iterable<WiseInterceptor> wiseInterceptors,
  Future<OAuth2Token> Function(OAuth2Token?, Dio)? refreshFunction,
  BaseOptions? options,
  bool useNativeAdapter = false,
  Iterable<Interceptor>? interceptorsToAdd,
  Iterable<Interceptor>? replacementInterceptors,
}) =>
    WebWiseClient(
      wiseInterceptors: wiseInterceptors,
      baseOptions: options,
      refreshFunction: refreshFunction,
      interceptorsToAdd: interceptorsToAdd,
      replacementInterceptors: replacementInterceptors,
    );

/// Implements [DioForBrowser] for native
base class WebWiseClient extends DioForBrowser with WiseClient {
  /// Creates a [WebWiseClient] instance
  WebWiseClient({
    required Iterable<WiseInterceptor> wiseInterceptors,
    Future<OAuth2Token> Function(OAuth2Token?, Dio)? refreshFunction,
    BaseOptions? baseOptions,
    Iterable<Interceptor>? interceptorsToAdd,
    Iterable<Interceptor>? replacementInterceptors,
  }) {
    options = baseOptions ?? BaseOptions();
    httpClientAdapter = (HttpClientAdapter() as BrowserHttpClientAdapter)
      ..withCredentials = true;
    if (replacementInterceptors != null) {
      interceptors.addAll(replacementInterceptors);
    } else {
      if (wiseInterceptors.contains(WiseInterceptor.fresh)) {
        fresh = getFreshInterceptor(refreshFunction: refreshFunction!);
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
  bool get isWebClient => true;
}
