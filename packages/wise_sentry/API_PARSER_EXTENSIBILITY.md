# API Error Parser Extensibility Design

## Current State

The package is currently hardcoded to parse JSON:API format:

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

## Proposed Solution: Parser Strategy Pattern

### 1. Abstract Parser Interface

```dart
/// Abstract interface for parsing API error responses.
abstract class ApiErrorParser {
  /// Parses a dynamic response body into an ApiErrorResponse.
  /// Returns null if the format doesn't match this parser.
  ApiErrorResponse? parse(dynamic responseData);
  
  /// Priority of this parser (higher = tried first).
  /// Useful when multiple parsers might match.
  int get priority => 0;
}
```

### 2. Built-in Parser Implementations

#### JSON:API Parser (Default)
```dart
class JsonApiErrorParser implements ApiErrorParser {
  const JsonApiErrorParser();
  
  @override
  int get priority => 100; // Default parser
  
  @override
  ApiErrorResponse? parse(dynamic responseData) {
    if (responseData is! Map<String, dynamic>) return null;
    
    try {
      final errorsJson = responseData['errors'];
      if (errorsJson is! List) return null;
      
      final errors = errorsJson
          .map((e) => ApiErrorDetail.fromJson(e))
          .whereType<ApiErrorDetail>()
          .toList();
      
      if (errors.isEmpty) return null;
      
      return ApiErrorResponse(
        errors: errors,
        traceId: responseData['traceId'] as String?,
      );
    } catch (_) {
      return null;
    }
  }
}
```

#### RFC 7807 Problem Details Parser
```dart
/// Parses RFC 7807 Problem Details format.
/// Example: {"type": "...", "title": "...", "status": 404, "detail": "..."}
class Rfc7807ErrorParser implements ApiErrorParser {
  const Rfc7807ErrorParser();
  
  @override
  int get priority => 90;
  
  @override
  ApiErrorResponse? parse(dynamic responseData) {
    if (responseData is! Map<String, dynamic>) return null;
    
    // RFC 7807 has: type, title, status, detail, instance
    if (!responseData.containsKey('type') || !responseData.containsKey('title')) {
      return null;
    }
    
    try {
      final error = ApiErrorDetail(
        status: responseData['status']?.toString(),
        code: responseData['type'] as String?,
        detail: responseData['detail'] as String?,
        message: responseData['title'] as String?,
        meta: {
          if (responseData.containsKey('instance'))
            'instance': responseData['instance'],
        },
      );
      
      return ApiErrorResponse(
        errors: [error],
        traceId: responseData['traceId'] as String?,
      );
    } catch (_) {
      return null;
    }
  }
}
```

#### Spring Boot Error Parser
```dart
/// Parses Spring Boot default error format.
/// Example: {"timestamp": "...", "status": 404, "error": "Not Found", "message": "...", "path": "..."}
class SpringBootErrorParser implements ApiErrorParser {
  const SpringBootErrorParser();
  
  @override
  int get priority => 80;
  
  @override
  ApiErrorResponse? parse(dynamic responseData) {
    if (responseData is! Map<String, dynamic>) return null;
    
    // Spring Boot format has: timestamp, status, error, message, path
    if (!responseData.containsKey('timestamp') || !responseData.containsKey('status')) {
      return null;
    }
    
    try {
      final error = ApiErrorDetail(
        status: responseData['status']?.toString(),
        code: responseData['error'] as String?,
        detail: responseData['message'] as String?,
        meta: {
          'timestamp': responseData['timestamp'],
          'path': responseData['path'],
        },
      );
      
      return ApiErrorResponse(
        errors: [error],
        traceId: null, // Spring Boot doesn't have trace ID by default
      );
    } catch (_) {
      return null;
    }
  }
}
```

#### Express.js Error Parser
```dart
/// Parses common Express.js error format.
/// Example: {"error": "Not Found", "message": "...", "statusCode": 404}
class ExpressErrorParser implements ApiErrorParser {
  const ExpressErrorParser();
  
  @override
  int get priority => 70;
  
  @override
  ApiErrorResponse? parse(dynamic responseData) {
    if (responseData is! Map<String, dynamic>) return null;
    
    // Common Express format
    if (!responseData.containsKey('message')) return null;
    
    try {
      final error = ApiErrorDetail(
        status: responseData['statusCode']?.toString(),
        code: responseData['error'] as String?,
        detail: responseData['message'] as String?,
      );
      
      return ApiErrorResponse(
        errors: [error],
        traceId: null,
      );
    } catch (_) {
      return null;
    }
  }
}
```

#### Laravel Validation Error Parser
```dart
/// Parses Laravel validation error format.
/// Example: {"message": "...", "errors": {"email": ["The email field is required."]}}
class LaravelValidationErrorParser implements ApiErrorParser {
  const LaravelValidationErrorParser();
  
  @override
  int get priority => 85;
  
  @override
  ApiErrorResponse? parse(dynamic responseData) {
    if (responseData is! Map<String, dynamic>) return null;
    
    final errorsMap = responseData['errors'];
    if (errorsMap is! Map<String, dynamic>) return null;
    
    try {
      final errors = <ApiErrorDetail>[];
      
      errorsMap.forEach((field, messages) {
        if (messages is List) {
          for (final message in messages) {
            errors.add(ApiErrorDetail(
              field: field,
              detail: message.toString(),
              message: responseData['message'] as String?,
            ));
          }
        }
      });
      
      if (errors.isEmpty) return null;
      
      return ApiErrorResponse(
        errors: errors,
        traceId: null,
      );
    } catch (_) {
      return null;
    }
  }
}
```

### 3. Parser Registry

```dart
/// Registry for API error parsers.
class ApiErrorParserRegistry {
  ApiErrorParserRegistry._();
  
  static final instance = ApiErrorParserRegistry._();
  
  final List<ApiErrorParser> _parsers = [
    const JsonApiErrorParser(),
    const Rfc7807ErrorParser(),
    const LaravelValidationErrorParser(),
    const SpringBootErrorParser(),
    const ExpressErrorParser(),
  ];
  
  /// Registers a custom parser.
  /// Parsers are tried in order of priority (highest first).
  void registerParser(ApiErrorParser parser) {
    _parsers.add(parser);
    _parsers.sort((a, b) => b.priority.compareTo(a.priority));
  }
  
  /// Removes all custom parsers and resets to defaults.
  void reset() {
    _parsers.clear();
    _parsers.addAll([
      const JsonApiErrorParser(),
      const Rfc7807ErrorParser(),
      const LaravelValidationErrorParser(),
      const SpringBootErrorParser(),
      const ExpressErrorParser(),
    ]);
  }
  
  /// Tries to parse the response data using registered parsers.
  /// Returns the first successful parse, or null if none match.
  ApiErrorResponse? parse(dynamic responseData) {
    for (final parser in _parsers) {
      final result = parser.parse(responseData);
      if (result != null) return result;
    }
    return null;
  }
}
```

### 4. Updated ApiErrorResponse

```dart
class ApiErrorResponse {
  const ApiErrorResponse({
    required this.errors,
    this.traceId,
  });

  final List<ApiErrorDetail> errors;
  final String? traceId;

  /// Creates an [ApiErrorResponse] from JSON using registered parsers.
  /// Returns null if no parser can handle the format.
  static ApiErrorResponse? fromJson(dynamic json) {
    return ApiErrorParserRegistry.instance.parse(json);
  }
  
  // ... rest of the class remains the same
}
```

### 5. Updated WiseSentry Initialization

```dart
class WiseSentry {
  static Future<void> init({
    required String? dsn,
    required Widget Function() appRunner,
    String? environment,
    double sampleRate = 1.0,
    double tracesSampleRate = 0.2,
    bool logInDebugMode = false,
    List<ApiErrorParser>? customErrorParsers, // NEW PARAMETER
  }) async {
    // Register custom parsers if provided
    if (customErrorParsers != null) {
      for (final parser in customErrorParsers) {
        ApiErrorParserRegistry.instance.registerParser(parser);
      }
    }
    
    // ... rest of init logic
  }
}
```

## Usage Examples

### Example 1: Using Default Parsers

```dart
// Works out of the box with JSON:API, RFC 7807, Spring Boot, Express, Laravel
await WiseSentry.init(
  dsn: 'YOUR_DSN',
  appRunner: () => const MyApp(),
);
```

### Example 2: Custom API Format

```dart
// Your API returns: {"success": false, "errorCode": "USER_NOT_FOUND", "errorMessage": "..."}
class MyCustomErrorParser implements ApiErrorParser {
  const MyCustomErrorParser();
  
  @override
  int get priority => 150; // Higher than defaults
  
  @override
  ApiErrorResponse? parse(dynamic responseData) {
    if (responseData is! Map<String, dynamic>) return null;
    if (responseData['success'] != false) return null;
    
    final error = ApiErrorDetail(
      code: responseData['errorCode'] as String?,
      detail: responseData['errorMessage'] as String?,
    );
    
    return ApiErrorResponse(
      errors: [error],
      traceId: responseData['requestId'] as String?,
    );
  }
}

// Register it
await WiseSentry.init(
  dsn: 'YOUR_DSN',
  appRunner: () => const MyApp(),
  customErrorParsers: [
    const MyCustomErrorParser(),
  ],
);
```

### Example 3: GraphQL Error Format

```dart
// GraphQL format: {"errors": [{"message": "...", "extensions": {...}}]}
class GraphQLErrorParser implements ApiErrorParser {
  const GraphQLErrorParser();
  
  @override
  int get priority => 95;
  
  @override
  ApiErrorResponse? parse(dynamic responseData) {
    if (responseData is! Map<String, dynamic>) return null;
    
    final errorsJson = responseData['errors'];
    if (errorsJson is! List) return null;
    
    final errors = errorsJson.map((e) {
      if (e is! Map<String, dynamic>) return null;
      
      return ApiErrorDetail(
        detail: e['message'] as String?,
        code: e['extensions']?['code'] as String?,
        meta: e['extensions'] as Map<String, dynamic>?,
      );
    }).whereType<ApiErrorDetail>().toList();
    
    if (errors.isEmpty) return null;
    
    return ApiErrorResponse(errors: errors);
  }
}

await WiseSentry.init(
  dsn: 'YOUR_DSN',
  appRunner: () => const MyApp(),
  customErrorParsers: [const GraphQLErrorParser()],
);
```

## Implementation Effort

### Estimated Work

1. **Create parser interface** - 30 minutes
   - Define `ApiErrorParser` abstract class
   - Create `ApiErrorParserRegistry`

2. **Refactor existing code** - 1 hour
   - Extract JSON:API logic into `JsonApiErrorParser`
   - Update `ApiErrorResponse.fromJson()` to use registry
   - Add `customErrorParsers` parameter to `WiseSentry.init()`

3. **Implement built-in parsers** - 2 hours
   - RFC 7807 parser
   - Spring Boot parser
   - Express.js parser
   - Laravel parser
   - GraphQL parser

4. **Testing** - 2 hours
   - Test each parser independently
   - Test parser priority system
   - Test custom parser registration
   - Test fallback behavior

5. **Documentation** - 1 hour
   - Update README with custom parser examples
   - Document built-in parser formats
   - Add migration guide

**Total Estimated Effort:** ~6-7 hours

### Benefits

✅ **Zero Breaking Changes**: Existing code works exactly the same (JSON:API is default)  
✅ **Easy to Use**: Just pass `customErrorParsers` to init  
✅ **Extensible**: Users can implement any format  
✅ **Multiple Formats**: App can handle multiple APIs with different formats  
✅ **Priority System**: Control which parser tries first  
✅ **Type Safe**: All parsers return `ApiErrorResponse`  
✅ **Testable**: Each parser is independent and easy to test  

### Migration Path

**For existing users:**
```dart
// No changes needed - JSON:API parser is default
await WiseSentry.init(dsn: '...', appRunner: () => MyApp());
```

**For custom format users:**
```dart
// Just add your parser
await WiseSentry.init(
  dsn: '...',
  appRunner: () => MyApp(),
  customErrorParsers: [MyCustomParser()],
);
```

## Conclusion

**Difficulty Level:** ⭐⭐ (Easy to Moderate)

The implementation is straightforward because:
1. All the infrastructure exists (ApiErrorResponse, ApiErrorDetail)
2. Just need to extract and abstract the parsing logic
3. Strategy pattern is well-understood and simple
4. No breaking changes required

**Recommendation:** Implement this extensibility. It would significantly increase the package's adoption potential and make it usable with any backend API format.
