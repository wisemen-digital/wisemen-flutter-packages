# wiseclient – AI Skill

`wiseclient` is a Dio-based HTTP client used across all Wisemen Flutter projects. It wraps `Dio` with
token refresh (via `Fresh`), secure token storage, logging, and error-handling interceptors.

---

## Creating a client

```dart
import 'package:wiseclient/wiseclient.dart';

// Minimal client (no auth)
final client = WiseClient(
  wiseInterceptors: [WiseInterceptor.logging, WiseInterceptor.error],
  options: WiseOptions.base(url: 'https://api.example.com'),
);

// Client with OAuth2 token refresh
final client = WiseClient(
  wiseInterceptors: [
    WiseInterceptor.fresh,
    WiseInterceptor.logging,
    WiseInterceptor.error,
  ],
  options: WiseOptions.base(url: 'https://api.example.com'),
  refreshFunction: (token, dio) async {
    // Call your refresh endpoint and return a new OAuth2Token
    final response = await dio.post('/auth/refresh', data: {'refresh_token': token?.refreshToken});
    return OAuthToken.fromSnakeCase(response.data as Map<String, dynamic>);
  },
  refreshErrorHandler: (error, stackTrace) {
    // Called when refresh fails – typically log the user out here
  },
  refreshBuffer: const Duration(minutes: 10), // Refresh token this long before expiry
);
```

### `WiseInterceptor` options

| Value | Effect |
|---|---|
| `WiseInterceptor.fresh` | Adds token-refresh interceptor. Requires `refreshFunction`. |
| `WiseInterceptor.error` | Re-throws `DioException` for uniform error handling. |
| `WiseInterceptor.logging` | Logs requests/responses via `TalkerDioLogger`. |

> **Rule:** `WiseInterceptor.fresh` requires `refreshFunction` to be provided. All other interceptors
> must NOT provide `refreshFunction`.

---

## Making requests

Use the `w`-prefixed methods. They automatically attach the cancel token, call `_buildOptions`, and
unwrap `response.data`. They throw the original `DioException` or an `UnknownException`.

```dart
// GET
final data = await client.wGet('/users', queryParameters: {'page': 1});

// POST
final data = await client.wPost('/users', body: {'name': 'Alice'});

// PUT
final data = await client.wPut('/users/1', body: {'name': 'Bob'});

// Extra headers per request
final data = await client.wGet('/admin', extraHeaders: {'X-Role': 'admin'});
```

> For other HTTP methods (DELETE, PATCH, etc.) fall back to the underlying Dio API directly on
> `client`.

---

## WiseOptions

`WiseOptions` extends `BaseOptions` with validation and convenience constructors.

```dart
// Sensible defaults: 30s connect, 60s receive, 120s send, Accept: application/json
WiseOptions.base(url: 'https://api.example.com')

// Same defaults + Accept-Language header
WiseOptions.baseWithLocale(url: 'https://api.example.com', locale: 'nl')

// Full control
WiseOptions(
  baseUrl: 'https://api.example.com',
  connectTimeout: const Duration(seconds: 10),
  headers: {'X-App-Version': '1.0.0'},
)
```

---

## Token management

```dart
// Set a token after login
await client.setFreshToken(token: OAuthToken(accessToken: '...', refreshToken: '...'));

// Clear the token on logout
await client.removeFreshToken();

// Listen to auth state changes
client.authenticationStatus.listen((status) {
  // AuthenticationStatus: initial | authenticated | unauthenticated
});
```

### Token models

```dart
// Parse from a snake_case JSON response (typical OAuth2 server response)
final token = OAuthToken.fromSnakeCase(responseJson);

// Parse from camelCase JSON
final token = OAuthToken.fromCamelCasing(responseJson);

// Check expiry (uses JWT decoder)
final expiresAt = token.expiresAt; // DateTime
```

`OAuthToken` extends `OAuth2Token` (fields: `accessToken`, `tokenType`, `expiresIn`,
`refreshToken`, `scope`). Tokens are persisted in `FlutterSecureStorage` via
`FreshSecureTokenStorage` under the key `OAUTH_TOKEN`.

---

## Cancel tokens

```dart
// Cancel all in-flight wise requests and reset the token after 300 ms
await client.cancelAndReset();

// Or manually:
client.cancelWiseRequests();
client.resetWiseCancelToken();
```

---

## Adding permanent headers

```dart
client.addHeaders(headers: {'X-Tenant-Id': 'abc123'});
```

---

## Native HTTP adapter

Pass `useNativeAdapter: true` to use `NativeAdapter` (from `native_dio_adapter`) instead of the
default `IOHttpClientAdapter`. Useful when you need platform certificate pinning or HTTP/3.

```dart
final client = WiseClient(
  wiseInterceptors: [WiseInterceptor.logging],
  useNativeAdapter: true,
);
```

---

## Error handling

All `w`-prefixed methods propagate `DioException` as-is. Any other exception is wrapped in
`UnknownException`. When `WiseInterceptor.error` is included, `BaseErrorInterceptor` re-throws
`DioException` before it reaches your code, so you can catch it at the call site:

```dart
try {
  final data = await client.wGet('/users');
} on DioException catch (e) {
  // e.response?.statusCode, e.type, etc.
} on UnknownException catch (e) {
  // Non-Dio errors
}
```

Token-refresh failure triggers `refreshErrorHandler`. Throwing `RevokeTokenException` inside
`refreshFunction` clears the stored token and propagates a `DioException` with that error.

---

## Platform notes

- On **native** (iOS/Android/desktop), `NativeWiseClient` extends `DioForNative`.
- On **web**, `WiseClient` uses the web implementation (`DioForBrowser`-equivalent).
- `client.isWebClient` returns `true` on web.
