# Wise Sentry

An intelligent Sentry wrapper for Flutter applications that provides automatic error categorization, filtering, enrichment, and smart grouping.

## Why Wise Sentry?

Standard Sentry integration can overwhelm you with noise from non-actionable errors, duplicate issues with different IDs/UUIDs, and errors lacking context. Wise Sentry solves this by:

- **🎯 Smart Filtering**: Only logs actionable errors, filtering out network timeouts, server errors, and other noise
- **🏷️ Automatic Categorization**: Tags errors as `ui`, `dto`, `network`, `mapper`, etc. for easy triage
- **🔍 Rich Context**: Automatically extracts and includes API error details, JSON data, widget info, and more
- **🔗 Better Grouping**: Normalizes URLs and fingerprints to group similar errors together (e.g., `/users/123` and `/users/456` become one issue)
- **📊 Clean Display**: Converts complex exceptions to readable formats in Sentry dashboard

## Features

- ✅ **Automatic Error Enrichment**: DioException → HttpException with parsed API errors
- ✅ **Smart Categorization**: TypeError in UI vs DTO context automatically detected
- ✅ **URL Normalization**: Groups `/apps/uuid-123` and `/apps/uuid-456` as the same error
- ✅ **FlutterError Handling**: Extracts widget context and overflow details
- ✅ **Intelligent Filtering**: Skips network timeouts, 5xx errors, cancelled requests
- ✅ **Type-Safe Parsers**: WiseDTOParser, WiseMapperParser, WiseUIErrorParser for consistent error wrapping
- ✅ **Dio Integration**: Drop-in interceptor for automatic HTTP error logging

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  wise_sentry: ^0.0.1
```

## Requirements

### Dart SDK
- `>=3.6.0 <4.0.0`

### Flutter
- `>=3.19.5`

### Dependencies
- **sentry_flutter**: `>=9.0.0 <10.0.0`
- **dio**: `>=5.0.0 <6.0.0`

**Important**: If your project uses a different version of `sentry_flutter`, ensure compatibility. Wise Sentry is compatible with Sentry Flutter SDK version 9.x only to avoid breaking changes. If you encounter dependency conflicts, you may need to upgrade or downgrade your Sentry version to 9.x.

## Quick Start

### 1. Initialize Sentry

```dart
import 'package:flutter/material.dart';
import 'package:wise_sentry/wise_sentry.dart';

void main() async {
  await WiseSentry.init(
    dsn: 'YOUR_SENTRY_DSN',
    environment: 'production',
    sampleRate: 1.0,
    tracesSampleRate: 0.2,
    logInDebugMode: false, // Don't send to Sentry in debug mode
    appRunner: () => const MyApp(),
  );
}
```

### 2. Add Dio Interceptor

```dart
import 'package:dio/dio.dart';
import 'package:wise_sentry/wise_sentry.dart';

final dio = Dio()
  ..interceptors.add(WiseSentryDioInterceptor());
```

That's it! HTTP errors are now automatically logged with full API error details.

## Usage

### Manual Error Logging

```dart
try {
  // Your code
} catch (e, stackTrace) {
  WiseSentry.captureException(
    e,
    stackTrace,
    extras: {'custom_key': 'custom_value'},
  );
}
```

### Using Error Parsers

Wrap parsing operations to automatically enrich errors with context:

```dart
// DTO Parsing
final user = WiseDTOParser.parse(
  () => UserModel.fromJson(json),
  json: json,
  mapper: 'UserModel.fromJson',
);

// Mapper Operations
final userDetail = WiseMapperParser.parse(
  () => userList[index],
  json: userList,
  mapper: 'userList[index]',
);

// UI Operations
final widget = WiseUIErrorParser.parse(
  () => buildComplexWidget(),
  context: {'user_id': userId},
  location: 'DashboardScreen.build',
);
```

### User Tracking

```dart
// Set user context
WiseSentry.setUserData(
  uuid: user.id,
  data: {
    'email': user.email,
    'role': user.role,
  },
);

// Clear on logout
WiseSentry.clearUserData();
```

### Logging Specific Error Types

```dart
// Log Dio errors manually
WiseSentry.logDioError(dioException, stackTrace);

// Log UI errors
WiseSentry.logUIError(exception, stackTrace);
```

## Exception Types

Wise Sentry provides typed exceptions for better categorization:

- **`HttpException`**: HTTP/API errors with status codes, error codes, and API details
- **`DTOException`**: JSON parsing and deserialization errors with JSON context
- **`MapperException`**: Data transformation errors with source data
- **`UIException`**: UI layer errors (null checks, overflow, Flutter errors)
- **`WiseTypeException`**: Type casting errors
- **`WiseException`**: Base class for all Wise exceptions

## What Gets Filtered Out?

Wise Sentry automatically filters non-actionable errors:

- ❌ Network timeouts and connection errors
- ❌ Server 5xx errors (unless POST/PUT/PATCH/DELETE)
- ❌ Cancelled requests
- ❌ GET requests with 404/422/400 (unless with query params)
- ❌ OSError patterns (network unreachable, connection refused)

## What Gets Enhanced?

### DioException → HttpException
```dart
// Before: "DioException [bad response]: null"
// After: "HttpException: NotFoundException (404) - Cannot GET /api/users/123"

// Includes in extras:
// - api_trace_id
// - first_error_code
// - first_error_detail
// - normalized_endpoint: "/api/users/:id"
```

### TypeError Context Detection
```dart
// TypeError in UI code → UIException
// TypeError in mapper/fromJson → DTOException

// Automatically analyzes stack trace to determine context
```

### FlutterError Enrichment
```dart
// Extracts:
// - overflow_pixels: "15.2"
// - overflow_side: "right"
// - widget_type: "RenderFlex"
// - error_subtype: "lifecycle" (for setState after dispose)
```

## Sentry Dashboard Benefits

With Wise Sentry, your Sentry dashboard becomes much more useful:

1. **Filter by Category**: Use `error-category:ui` or `error-category:dto` tags
2. **Better Grouping**: Similar errors with different IDs grouped together
3. **Rich Context**: See API error codes, JSON payloads, widget details
4. **Clean Titles**: "HttpException: NotFoundException (404)" instead of "DioException [bad response]: null"
5. **Actionable Only**: No noise from transient network issues

## Advanced Configuration

```dart
await WiseSentry.init(
  dsn: dsn,
  environment: 'staging',
  sampleRate: 0.2, // Sample 20% of errors in production
  tracesSampleRate: 0.1, // Sample 10% of performance traces
  logInDebugMode: true, // Enable for testing
  appRunner: () => const MyApp(),
);
```

## Testing

Run tests:
```bash
flutter test
```

## Troubleshooting

### Version Conflicts

If you encounter dependency conflicts with `sentry_flutter`, it usually means your project is using an incompatible version.

**Check your current version:**
```bash
flutter pub deps | grep sentry_flutter
```

**Common issues:**

1. **Your project uses Sentry 8.x**
   ```yaml
   # Your pubspec.yaml has:
   sentry_flutter: ^8.0.0
   ```
   **Solution**: Upgrade to Sentry 9.x or later:
   ```yaml
   sentry_flutter: ^9.0.0
   ```

2. **Conflicting transitive dependencies**
   ```
   Because package_x depends on sentry_flutter ^8.0.0 and wise_sentry depends on sentry_flutter >=9.0.0, version solving failed.
   ```
   **Solution**: Use dependency overrides in your `pubspec.yaml`:
   ```yaml
   dependency_overrides:
     sentry_flutter: ^9.7.0
   ```

3. **Multiple packages using different Sentry versions**
   
   Run `flutter pub deps | grep sentry` to identify all packages using Sentry, then ensure they all support the same major version.

### Compatibility Matrix

| Wise Sentry | Sentry Flutter | Dio      | Dart SDK |
|-------------|----------------|----------|----------|
| 0.0.1       | 9.x            | 5.x      | >=3.6.0  |

### Migration from Direct Sentry Usage

If you're already using `sentry_flutter` directly:

1. **Keep your existing `sentry_flutter` dependency** - Wise Sentry will use it
2. **Replace your `SentryFlutter.init()`** with `WiseSentry.init()`
3. **Remove manual `beforeSend` callbacks** - Wise Sentry handles this
4. **Optional**: Migrate `Sentry.captureException()` calls to `WiseSentry.captureException()` for consistency

Example migration:
```dart
// Before
await SentryFlutter.init(
  (options) {
    options.dsn = 'YOUR_DSN';
    options.environment = 'production';
  },
  appRunner: () => runApp(MyApp()),
);

// After
await WiseSentry.init(
  dsn: 'YOUR_DSN',
  environment: 'production',
  appRunner: () => const MyApp(),
);
```

## Learn More

See [FEATURES.md](FEATURES.md) for detailed feature documentation.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
