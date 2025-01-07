import 'package:dio/dio.dart';

/// Class [BaseErrorInterceptor] to catch and handle errors returned by dio
class BaseErrorInterceptor extends Interceptor {
  /// Constructor for [BaseErrorInterceptor]
  BaseErrorInterceptor();

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    throw err;
  }
}
