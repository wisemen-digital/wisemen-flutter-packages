This is a package based on Dio with a few extra QOL features. Custom made for Flutter Circle.

## Features

🌐 Extension on Dio client

🍋 Token refresh with FreshSecureTokenStorage for OAuth tokens 

📑 Formatted logging

❗️ Basic error handling widgets to be used together with runZonedGuarded

❌ Cancel requests

🛡️ Protected/Unprotected

📦 In separately importable package

## Getting started

This is a package based on Dio with a few extra QOL features. Custom made for Flutter Circle.

## Usage

Create a WiseClient and use it like you would any other Dio client.

```dart
final client = WiseClient(
  wiseInterceptors: [WiseInterceptor.logging, WiseInterceptor.error],
  options: WiseOptions.base(url: url),
);
```

### Token refresh

Add `WiseInterceptor.fresh` with a `refreshFunction` to attach the token to every request and
refresh it on a 401. The token is stored in secure storage.

```dart
final client = WiseClient(
  wiseInterceptors: [WiseInterceptor.fresh, WiseInterceptor.error],
  options: WiseOptions.base(url: url),
  refreshFunction: (token, dio) async {
    final response = await dio.post<Map<String, dynamic>>(
      '$url/auth/refresh',
      data: {'refresh_token': token?.refreshToken},
    );
    return response.data!.toOAuth2TokenFromSnakeCase();
  },
);

await client.setFreshToken(token: loginResponse.toOAuth2TokenFromSnakeCase());
```

### Sharing a session between clients

Create the session once, and pass its `fresh` to every other client that sends the same user's
token, for example clients for different backends behind the same login:

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

Don't give each client its own `refreshFunction`. Each would keep its own copy of the token in
memory, so a refresh by one client goes unnoticed by the others. When the server rotates refresh
tokens, the next client to refresh uses an invalidated refresh token and logs the user out. Sharing
the storage does not help, since a client only reads it once, on creation.

To store the token somewhere else, create the instance yourself and pass it the same way:

```dart
final fresh = getFreshInterceptor(
  refreshFunction: refreshToken,
  tokenStorage: MyTokenStorage(),
);
final client = WiseClient(
  wiseInterceptors: [WiseInterceptor.fresh],
  fresh: fresh,
);
```
