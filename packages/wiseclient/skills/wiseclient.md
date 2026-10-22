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
    try {
      // `dio` is a separate client without your base url: use an absolute url
      final response = await dio.post<Map<String, dynamic>>(
        'https://api.example.com/auth/refresh',
        data: {'refresh_token': token?.refreshToken},
      );
      return response.data!.toOAuth2TokenFromSnakeCase();
    } on DioException catch (e) {
      // The refresh token is rejected: log the user out
      if (e.response?.statusCode case 400 || 401) throw RevokeTokenException();
      rethrow;
    }
  },
);
```

### `refreshFunction` rules

- Return an `OAuth2Token`. It is saved to secure storage and the failed request is retried
  with it.
- The `dio` argument is not `client`: it has none of the client's options, interceptors or
  adapter. Call the refresh endpoint with an absolute url.
- Throw `RevokeTokenException` when the refresh token is rejected. This clears the stored token
  and moves `authenticationStatus` to `unauthenticated`.
- Let any other failure surface as a `DioException`: the user stays logged in, the request fails
  with that exception, and the next 401 retries the refresh. Any other exception type makes the
  original request resolve successfully with its 401 response.
- Tokens are refreshed when a request returns 401, and before a request when the token expires
  within 30 seconds. The early refresh needs both `expiresIn` and `issuedAt`.

### `WiseInterceptor` options

| Value | Effect |
|---|---|
| `WiseInterceptor.fresh` | Adds token-refresh interceptor. Requires `refreshFunction`. |
| `WiseInterceptor.error` | Re-throws `DioException` for uniform error handling. |
| `WiseInterceptor.logging` | Logs requests/responses via `TalkerDioLogger`. |

> **Rule:** `WiseInterceptor.fresh` requires `refreshFunction` to be provided. All other interceptors
> must NOT provide `refreshFunction`.

Interceptors run in this order: `interceptorsToAdd`, then `fresh`, then the other wise interceptors
in the order given. An added interceptor sees a 401 in `onError` before `fresh` refreshes it, so it
must call `handler.next` for refresh to happen. Passing `interceptors:` replaces all of them.

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

Only on a client created with `WiseInterceptor.fresh`. On any other client `fresh`,
`setFreshToken`, `removeFreshToken` and `authenticationStatus` throw a `StateError`. Manage the
token through the client that sends authenticated requests.

```dart
// Set a token after login
await client.setFreshToken(
  token: loginResponse.toOAuth2TokenFromSnakeCase(),
);

// Clear the token on logout
await client.removeFreshToken();

// Listen to auth state changes
client.authenticationStatus.listen((status) {
  // AuthenticationStatus: initial | authenticated | unauthenticated
});
```

### Sharing a session between clients

Every client that sends the same user's token must share one `Fresh` instance. Create the session
once with `refreshFunction`, and pass its `fresh` to every other client instead of a
`refreshFunction`:

```dart
final apiClient = WiseClient(
  wiseInterceptors: [WiseInterceptor.fresh, WiseInterceptor.error],
  options: WiseOptions.base(url: apiUrl),
  refreshFunction: refreshToken,
);

final mediaClient = WiseClient(
  wiseInterceptors: [WiseInterceptor.fresh, WiseInterceptor.error],
  options: WiseOptions.base(url: mediaUrl),
  fresh: apiClient.fresh,
);
```

- **Never** create two clients that each have their own `refreshFunction` for the same login. Each
  keeps its own in-memory token and reads storage only on creation, so after one refreshes, the
  other refreshes with a rotated refresh token and logs the user out. Sharing token storage does
  not prevent this.
- `WiseInterceptor.fresh` takes exactly one of `refreshFunction` or `fresh`. Without
  `WiseInterceptor.fresh`, pass neither.
- Login, logout and `authenticationStatus` can go through any client that shares the instance.
- For custom token storage, create the instance with
  `getFreshInterceptor(refreshFunction: ..., tokenStorage: ...)` and pass it as `fresh`. There is
  no `tokenStorage` parameter on `WiseClient`.

### Token model

Tokens are `OAuth2Token` from `fresh`, exported by `wiseclient` (fields: `accessToken`,
`tokenType`, `expiresIn`, `refreshToken`, `scope`, `issuedAt`). There is no `OAuthToken`
since wiseclient 3.0.0.

```dart
// Parse from a snake_case JSON response (typical OAuth2 server response)
final token = responseJson.toOAuth2TokenFromSnakeCase();

// Parse from camelCase JSON
final token = responseJson.toOAuth2TokenFromCamelCase();

// issuedAt + expiresIn, null when either is missing
final DateTime? expiresAt = token.expiresAt;
```

Both parsers set `issuedAt` to now when the JSON has none, so the early refresh works. Prefer them
over the `OAuth2Token` constructor, which leaves `issuedAt` null.

Tokens are persisted in `FlutterSecureStorage` via `FreshSecureTokenStorage` under the key
`OAUTH_TOKEN_STORAGE`. If the stored token can't be read or parsed, it is deleted, the user is
logged out, and the error is reported to the current zone (a `TokenParseException`, or the storage
error) so `runZonedGuarded` and crash reporting see it. Requests continue without a token.

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

Throwing `RevokeTokenException` inside `refreshFunction` clears the stored token and propagates a
`DioException` whose `error` is the `RevokeTokenException`. Listen to `authenticationStatus` to
navigate to login rather than catching it per request.

---

## Platform notes

- On **native** (iOS/Android/desktop), `NativeWiseClient` extends `DioForNative`.
- On **web**, `WiseClient` uses the web implementation (`DioForBrowser`-equivalent).
- `client.isWebClient` returns `true` on web.
