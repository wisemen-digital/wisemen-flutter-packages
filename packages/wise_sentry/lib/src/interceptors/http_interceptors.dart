import 'package:dio/dio.dart';
import '../../wise_sentry.dart';

/// A custom Dio Interceptor to catch DioExceptions, wrap them as HttpError,
/// and log them using our structured SentryLogger.
class WiseSentryDioInterceptor extends Interceptor {
  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    // 1. Check for errors that should be explicitly ignored (e.g., cancelled requests)
    if (CancelToken.isCancel(err)) {
      // Do not report cancelled requests to Sentry
      return handler.next(err);
    }

    // 3. Log the custom HttpError to Sentry
    // We use the stackTrace from the DioException if available, otherwise current.
    WiseSentry.logHttpError(
      err,
      err.stackTrace,
    );

    // 4. Continue the chain
    handler.next(err);
  }
}
