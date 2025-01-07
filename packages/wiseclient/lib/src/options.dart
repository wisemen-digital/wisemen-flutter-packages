import 'dart:io';

import 'package:dio/dio.dart';

/// Overrides [BaseOptions] with Wisemen base options

class WiseOptions extends BaseOptions {
  /// Empty constructor for [WiseOptions] with all options
  WiseOptions({
    super.method,
    Duration? connectTimeout,
    super.receiveTimeout,
    super.sendTimeout,
    String baseUrl = '',
    Map<String, dynamic>? queryParameters,
    super.extra,
    super.headers,
    super.responseType,
    super.contentType,
    super.validateStatus,
    super.receiveDataWhenStatusError,
    super.followRedirects,
    super.maxRedirects,
    super.persistentConnection,
    super.requestEncoder,
    super.responseDecoder,
    super.listFormat,
    String? locale,
  })  : assert(
          connectTimeout == null || !connectTimeout.isNegative,
          'connectTimeout can not be null or empty.',
        ),
        assert(
          baseUrl.isEmpty || Uri.parse(baseUrl).host.isNotEmpty,
          'baseUrl or baseUrl host can not be empty',
        ) {
    this.queryParameters = queryParameters ??
        (locale == null
            ? {}
            : {
                HttpHeaders.acceptLanguageHeader: locale,
              });
    this.baseUrl = baseUrl;
    this.connectTimeout = connectTimeout;
  }

  /// Constructor for [WiseOptions] with base options
  WiseOptions.base({
    String url = '',
  })  : assert(
          url.isEmpty || Uri.parse(url).host.isNotEmpty,
          'baseUrl host can not be empty',
        ),
        super(
          baseUrl: url,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 120),
          headers: {
            HttpHeaders.acceptHeader: 'application/json',
          },
        );

  /// Constructor for [WiseOptions] with locale string and base options
  WiseOptions.baseWithLocale({
    required String locale,
    String url = '',
  })  : assert(
          url.isEmpty || Uri.parse(url).host.isNotEmpty,
          'baseUrl host can not be empty',
        ),
        assert(
          locale.isNotEmpty,
          'locale has to be a valid locale',
        ),
        super(
          baseUrl: url,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 120),
          headers: {
            HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.acceptLanguageHeader: locale,
          },
        );
}
