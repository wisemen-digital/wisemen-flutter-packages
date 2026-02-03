import 'package:dio/dio.dart';
import '../../wise_sentry.dart';

/// A custom Dio Interceptor to catch DioExceptions, wrap them as HttpException,
/// and log them using our structured SentryLogger.
class WiseSentryDioInterceptor extends Interceptor {
  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (CancelToken.isCancel(err)) {
      // Do not report cancelled requests to Sentry
      return handler.next(err);
    }

    WiseSentry.logDioError(
      err,
      err.stackTrace,
    );

    // 4. Continue the chain
    handler.next(err);
  }
}
