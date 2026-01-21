
# Wise Sentry

A Wisemen wrapper for Sentry logging.

This package provides a simple interface for Sentry logging, with a focus on ease of use and integration with other Wisemen packages.

## Features

- Initialize Sentry with a simple configuration.
- Log errors and exceptions to Sentry.
- Automatically log HTTP errors from Dio.
- Add user data to Sentry events.
- Custom exception types for more specific error reporting.

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  wise_sentry: ^0.0.1
```

## Usage

### Initialization

To initialize Sentry, call the `initializeSentry` function in your `main.dart` file.

```dart
import 'package:flutter/material.dart';
import 'package:wise_sentry/wise_sentry.dart';

void main() {
  initializeSentry(
    dsn: 'YOUR_SENTRY_DSN',
    appRunner: () => runApp(MyApp()),
  );
}
```

### Logging errors

To log an error to Sentry, use the `WiseSentry.logError` function.

```dart
try {
  // Your code here
} catch (e, stackTrace) {
  WiseSentry.logError(e, stackTrace);
}
```

### Logging Dio HTTP errors

To automatically log HTTP errors from Dio, add the `WiseSentryDioInterceptor` to your Dio instance.

```dart
import 'package:dio/dio.dart';
import 'package:wise_sentry/wise_sentry.dart';

final dio = Dio();

void main() {
  dio.interceptors.add(WiseSentryDioInterceptor());
  // ...
}
```

### Adding user data

To add user data to Sentry events, use the `WiseSentry.setUserData` function.

```dart
WiseSentry.setUserData(
  uuid: 'USER_UUID',
  data: {
    'email': 'user@example.com',
  },
);
```

To clear user data, use the `WiseSentry.clearUserData` function.

```dart
WiseSentry.clearUserData();
```

## Custom Exceptions

This package provides a set of custom exception types for more specific error reporting.

- `HttpError`: For HTTP/Network related errors.
- `MapperError`: For errors during data transformation.
- `BusinessLogicError`: For errors specific to core domain logic.
- `UIError`: For errors originating from the Presentation/UI layer.

You can use these exceptions to provide more context to your Sentry events.

## Dio Interceptor

The `WiseSentryDioInterceptor` automatically catches DioExceptions, wraps them as `HttpError`, and logs them to Sentry. This provides a simple way to log all HTTP errors from your application.
