import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:wiseclient/src/wiseclient_base.dart';

import '../interceptors/interceptors.dart';

/// Creates a [WiseClient] for web
WiseClient createClient({
  required Iterable<WiseInterceptor> wiseInterceptors,
  Future<OAuth2Token> Function(OAuth2Token?, Dio)? refreshFunction,
  BaseOptions? options,
  bool useNativeAdapter = false,
  Iterable<Interceptor>? interceptorsToAdd,
  Iterable<Interceptor>? replacementInterceptors,
  Fresh<OAuth2Token>? fresh,
}) => WebWiseClient(
  wiseInterceptors: wiseInterceptors,
  baseOptions: options,
  refreshFunction: refreshFunction,
  interceptorsToAdd: interceptorsToAdd,
  replacementInterceptors: replacementInterceptors,
  fresh: fresh,
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
    Fresh<OAuth2Token>? fresh,
  }) {
    options = baseOptions ?? BaseOptions();
    httpClientAdapter = (HttpClientAdapter() as BrowserHttpClientAdapter)
      ..withCredentials = true;
    if (replacementInterceptors != null) {
      interceptors.addAll(replacementInterceptors);
    } else {
      if (wiseInterceptors.contains(WiseInterceptor.fresh)) {
        this.fresh =
            fresh ?? getFreshInterceptor(refreshFunction: refreshFunction!);
      }
      interceptors.addAll(
        [
          if (interceptorsToAdd != null) ...interceptorsToAdd,
          if (wiseInterceptors.contains(WiseInterceptor.fresh)) this.fresh,
          ...wiseInterceptors.map((e) => e.getInterceptor()).nonNulls,
        ],
      );
    }
  }

  @override
  bool get isWebClient => true;
}
