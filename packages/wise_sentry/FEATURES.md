# Wise Sentry - Features Deep Dive

This document provides detailed information about the advanced features that make Wise Sentry an intelligent error monitoring solution for Flutter applications.

## 🎯 Smart Error Filtering

Wise Sentry intelligently filters out non-actionable errors to reduce noise in your Sentry dashboard.

### HTTP Error Filtering Rules

#### GET Requests
- ✅ **Always logged**: `401`, `403`, `404`
- ✅ **Logged with query params**: `400`, `422`, `404`
- ❌ **Never logged**: `500`-`599` (server errors)

#### POST/PUT/PATCH/DELETE Requests
- ✅ **Always logged**: `400`, `401`, `403`, `404`, `422`
- ❌ **Never logged**: `500`-`599` (server errors)

**Rationale**: Server 5xx errors are server-side issues. GET requests without params are usually automated/background and don't impact user experience. POST/PUT/PATCH/DELETE always affect users and should be logged.

### Network Error Filtering

Automatically filters these non-actionable network errors:
- Connection timeouts
- Connection refused
- Network unreachable
- No route to host
- Software caused connection abort
- Cancelled requests (CancelToken)

## 🔄 Automatic Error Enrichment

### DioException → HttpException

When a DioException occurs, Wise Sentry:

1. **Parses API Error Response**
   ```json
   {
     "errors": [
       {
         "status": "404",
         "code": "NotFoundException",
         "detail": "Cannot GET /api/users/123",
         "field": "userId"
       }
     ],
     "traceId": "abc-123"
   }
   ```

2. **Creates Clean Exception**
   ```dart
   HttpException: NotFoundException (404) - Cannot GET /api/users/123
   ```

3. **Adds Context to Sentry**
   ```dart
   extras: {
     'api_trace_id': 'abc-123',
     'first_error_code': 'NotFoundException',
     'first_error_detail': 'Cannot GET /api/users/123',
     'normalized_endpoint': '/api/users/:id',
     'error_count': 1,
     'api_errors': [...] // Full error array
   }
   ```

### TypeError Context Detection

Wise Sentry analyzes stack traces to determine if a TypeError occurred in DTO/mapper code or UI code:

```dart
// TypeError in fromJson → DTOException
TypeError at package:myapp/models/user_mapper.dart:42
  in UserMapper.fromJson()
→ Categorized as: dto
→ Type: DTOException

// TypeError in widget → UIException  
TypeError at package:myapp/screens/dashboard.dart:102
  in DashboardScreen.build()
→ Categorized as: ui
→ Type: UIException
```

**Detection Logic**:
- Checks file paths for `_mapper.dart`, `_dto.dart`, `/models/`
- Checks function names for `fromJson`, `toJson`, `deserialize`, `parse`

### FlutterError Enrichment

Extracts detailed information from Flutter framework errors:

```dart
// Overflow Error
"A RenderFlex overflowed by 15.2 pixels on the right."

Extracted extras:
{
  'overflow_pixels': '15.2',
  'overflow_side': 'right',
  'widget_type': 'RenderFlex',
  'error_type': 'overflow'
}
```

```dart
// Lifecycle Error
"setState() called after dispose()"

Extracted extras:
{
  'error_subtype': 'lifecycle',
  'error_type': 'lifecycle'
}
→ Still categorized as UIException (not business logic)
```

**UI Error Patterns Detected**:
- Overflow errors
- Constraint errors
- RenderBox errors
- RenderFlex errors
- Layout errors
- setState after dispose
- Unmounted BuildContext
- Viewport errors

## 🏷️ Error Categorization & Tagging

Every error gets two tags for easy filtering:

### 1. Error Category Tag: `error-category`
- `ui` - UI/widget errors, FlutterError, TypeError in UI code
- `dto` - JSON parsing, deserialization, TypeError in fromJson
- `mapper` - Data transformation, index access errors
- `network` - DioException, HTTP errors
- `flutter` - FlutterError (also gets UI category)
- `uncategorized` - Unknown errors

### 2. Wise Type Tag: `wise-type`
- `UIException`
- `DTOException`
- `MapperException`
- `HttpException`
- `WiseTypeException`
- `WiseException` (base class)

**Usage in Sentry**: Filter by `error-category:ui` or `wise-type:HttpException`

## 🔗 Smart Fingerprinting & Grouping

### URL Normalization

Prevents creating separate issues for similar errors with different IDs:

```dart
// Before: 3 different issues
GET /api/users/550e8400-e29b-41d4-a716-446655440000
GET /api/users/6ba7b810-9dad-11d1-80b4-00c04fd430c8
GET /api/apps/123

// After: Normalized and grouped
GET /api/users/:id (2 errors)
GET /api/apps/:id (1 error)
```

**Normalization Rules**:
1. UUID patterns → `:id`
2. Numeric IDs (`/123`) → `/:id`
3. Alphanumeric IDs (`/apps1122`) → `/apps:id`

### Custom Fingerprinting

Wise Sentry uses a custom fingerprint strategy:

```dart
[category, location, exceptionType, exceptionValue]
```

**Examples**:
```dart
// HTTP Error
["network", "/api/users/:id", "HttpException", "NotFoundException (404)"]

// Flutter Error with widget context
["ui", "DashboardScreen/RenderFlex", "UIException", "overflow by 15.2 pixels"]

// DTO Error
["dto", "user_mapper.dart", "DTOException", "Type 'String' is not a subtype"]
```

**Special handling**:
- FlutterError: Uses route name + widget type from error message
- HttpException: Uses normalized endpoint
- Skips Sentry internal frames (binding_wrapper.dart)

## 🛠️ Error Parser Utilities

Wise Sentry provides three parser utilities for consistent error wrapping:

### WiseDTOParser

For DTO/model parsing with automatic error enrichment:

```dart
try {
  final user = WiseDTOParser.parse(
    () => UserModel.fromJson(json),
    json: json,
    mapper: 'UserModel.fromJson',
  );
} catch (e) {
  // Automatically becomes DTOException with:
  // - Original error preserved
  // - JSON data (truncated to 500 chars)
  // - Mapper name
  // - Error type
  // - Offset (for FormatException)
}
```

### WiseMapperParser

For data transformation and access operations:

```dart
final user = WiseMapperParser.parse(
  () => users[index],
  json: users,
  mapper: 'users[index]',
);

final detail = WiseMapperParser.parse(
  () => user.profile.address.city,
  json: user,
  mapper: 'user.profile.address.city',
);
```

**Use cases**:
- List/map access
- Nested property access
- Data transformations

### WiseUIErrorParser

For UI operations with widget context:

```dart
final widget = WiseUIErrorParser.parse(
  () => buildComplexWidget(),
  context: {
    'user_id': userId,
    'screen': 'Dashboard',
  },
  location: 'DashboardScreen.buildUserCard',
);
```

**Captures**:
- Widget build errors
- Null pointer exceptions in UI
- Assertion failures
- Custom context data

## 📊 Sentry Dashboard Improvements

### Before Wise Sentry

```
Issue #1: DioException [bad response]: null
  Location: binding_wrapper.dart line 128

Issue #2: DioException [bad response]: null  
  Location: binding_wrapper.dart line 128

Issue #3: TypeError
  Location: binding_wrapper.dart line 128
```

### After Wise Sentry

```
Issue #1: HttpException: NotFoundException (404) - Cannot GET /api/users/:id
  Location: user_repository.dart line 45
  Category: network | Type: HttpException
  Normalized Endpoint: /api/users/:id
  API Error Code: NotFoundException
  (Groups 2 errors with different user IDs)

Issue #2: UIException: Type error: Null check operator used on a null value
  Location: dashboard_screen.dart line 102
  Category: ui | Type: UIException
  Expected Type: AppDetail
  (Properly categorized as UI, not DTO)

Issue #3: UIException: A RenderFlex overflowed by 15.2 pixels on the right
  Location: DashboardScreen/RenderFlex
  Category: ui | Type: UIException
  Overflow: 15.2 pixels on right side
  Widget: RenderFlex
```

## 🔍 Best Practices

### 1. Always Use Parsers for Critical Operations

```dart
// ✅ Good
final user = WiseDTOParser.parse(
  () => UserModel.fromJson(json),
  json: json,
  mapper: 'UserModel.fromJson',
);

// ❌ Bad - loses context
final user = UserModel.fromJson(json);
```

### 2. Add Meaningful Context

```dart
// ✅ Good - provides debugging context
final widget = WiseUIErrorParser.parse(
  () => buildUserCard(user),
  context: {
    'user_id': user.id,
    'user_role': user.role,
    'screen': 'Dashboard',
  },
  location: 'DashboardScreen.buildUserCard',
);

// ❌ Bad - minimal context
final widget = WiseUIErrorParser.parse(
  () => buildUserCard(user),
);
```

### 3. Use Dio Interceptor for All HTTP Clients

```dart
// ✅ Good - automatic HTTP error handling
final dio = Dio()..interceptors.add(WiseSentryDioInterceptor());

// ❌ Bad - manual error handling everywhere
dio.get(...).catchError((e) => WiseSentry.captureException(e, stack));
```

### 4. Set User Context Early

```dart
// On login
WiseSentry.setUserData(
  uuid: user.id,
  data: {
    'email': user.email,
    'role': user.role,
    'tenant': user.tenantId,
  },
);

// On logout
WiseSentry.clearUserData();
```

## 🧪 Testing & Debugging

### Enable Sentry in Debug Mode

```dart
await WiseSentry.init(
  dsn: dsn,
  logInDebugMode: true, // See errors in debug mode
  appRunner: () => const MyApp(),
);
```

### Manual Exception Testing

```dart
// Test HTTP error enrichment
WiseSentry.logDioError(
  DioException(
    requestOptions: RequestOptions(path: '/test'),
    type: DioExceptionType.badResponse,
    response: Response(
      statusCode: 404,
      data: {'errors': [...]},
    ),
  ),
  StackTrace.current,
);

// Test UI error
WiseSentry.logUIError(
  StateError('Widget disposed'),
  StackTrace.current,
);
```

## 📈 Performance Considerations

- **Minimal overhead**: Error processing only happens when errors occur
- **JSON truncation**: Large JSON payloads truncated to 500 characters
- **Sampling**: Configure `sampleRate` and `tracesSampleRate` for production
- **Async processing**: Error enrichment doesn't block the main thread

## 🔒 Privacy & Security

- **No PII by default**: User data only sent if explicitly set with `setUserData()`
- **JSON sanitization**: Automatic truncation prevents sending large payloads
- **Token filtering**: Sensitive headers can be filtered in Dio interceptor
- **Debug mode**: Disable production logging with `logInDebugMode: false`

## 🚀 Migration Guide

### From Standard Sentry

```dart
// Before
await SentryFlutter.init(
  (options) => options.dsn = dsn,
  appRunner: () => runApp(MyApp()),
);

// After
await WiseSentry.init(
  dsn: dsn,
  environment: 'production',
  appRunner: () => const MyApp(),
);
```

