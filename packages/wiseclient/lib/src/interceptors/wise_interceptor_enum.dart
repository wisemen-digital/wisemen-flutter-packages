import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

import '../fresh/fresh.dart';
import 'interceptors.dart';

/// [WiseInterceptor] enum to list the available interceptor options
enum WiseInterceptor {
  /// [fresh] interceptor to refresh authentication tokens
  fresh,

  /// [error] interceptor to handle dio exceptions
  error,

  /// [logging] interceptor to log requests
  logging;

  /// Function to get the correct interceptor, doesn't return [Fresh] since the client needs the object
  Interceptor? getInterceptor() {
    switch (this) {
      case WiseInterceptor.fresh:
        return null;
      case WiseInterceptor.error:
        return BaseErrorInterceptor();
      case WiseInterceptor.logging:
        return TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
          ),
        );
    }
  }
}
