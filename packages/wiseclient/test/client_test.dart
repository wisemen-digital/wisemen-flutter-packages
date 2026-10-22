import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:wiseclient/src/secure_token_storage/fresh_secure_token_storage.dart';
import 'package:wiseclient/src/secure_token_storage/map_from_token_extension.dart';
import 'package:wiseclient/src/secure_token_storage/token_from_string_extension.dart';
import 'package:wiseclient/wiseclient.dart';

class MockStorage extends Mock implements FreshSecureTokenStorage {}

class FakeSecureStorage extends Fake implements FlutterSecureStorage {}

class FakeClient extends Fake implements WiseClient {}

class MockClient extends Mock implements WiseClient {}

class MockDio extends Mock implements Dio {}

class MockFresh extends Mock implements Fresh<OAuth2Token> {}

class MockToken extends Mock implements OAuth2Token {}

class FakeOAuth2Token extends Fake implements OAuth2Token {}

class MockTokenStorage<T> extends Mock implements TokenStorage<T> {}

class MockRequestOptions extends Mock implements RequestOptions {}

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

class MockOptions extends Mock implements BaseOptions {}

class MockResponse<T> extends Mock implements Response<T> {}

class MockResponseInterceptorHandler extends Mock
    implements ResponseInterceptorHandler {}

class MockDioException extends Mock implements DioException {}

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

class MockHttpClient extends Mock implements Dio {}

class MockFormData extends Mock implements FormData {}

class FakeRequestOptions extends Fake implements RequestOptions {}

class FakeResponse<T> extends Fake implements Response<T> {}

class FakeDioException extends Fake implements DioException {}

class MockExtendedClient extends Fake implements WiseClient {}

/// Returns 200 for requests carrying `bearer new`, 401 for anything else.
class TokenCheckingAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final authorized = options.headers['authorization'] == 'bearer new';
    return ResponseBody.fromString(
      '{}',
      authorized ? 200 : 401,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class FakeInterceptor extends Fake implements Interceptor {}

Future<OAuth2Token> emptyRefreshToken(OAuth2Token? _, Dio __) async {
  return MockToken();
}

class FreshController<T> with FreshMixin<T> {
  FreshController(TokenStorage<T> tokenStorage) {
    this.tokenStorage = tokenStorage;
  }

  @override
  Future<T> performTokenRefresh(T? token) {
    return Future.value(token!);
  }
}

/// Runs [body], collecting errors reported to the zone instead of failing.
Future<(T, List<Object>)> captureReportedErrors<T>(
  Future<T> Function() body,
) async {
  final reported = <Object>[];
  final completer = Completer<T>();
  runZonedGuarded(
    () => unawaited(
      body().then(completer.complete, onError: completer.completeError),
    ),
    (error, _) => reported.add(error),
  );
  return (await completer.future, reported);
}

extension VoidAnswer on When<Future<void>> {
  void thenAnswerWithVoid() => thenAnswer((_) async {});
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterSecureStorage.setMockInitialValues({});

  setUpAll(() {
    registerFallbackValue(FakeSecureStorage());
    registerFallbackValue(FakeOAuth2Token());
  });

  group('A group of basic tests to test functionality', () {
    final wiseOptions = WiseOptions.baseWithLocale(
      url: 'https://jsonplaceholder.typicode.com/',
      locale: 'en',
    );
    final wiseBaseOptions = WiseOptions.base(
      url: 'https://jsonplaceholder.typicode.com/',
    );
    final awesome = WiseClient(
      wiseInterceptors: WiseInterceptor.values,
      options: wiseOptions,
      refreshFunction: (token, client) {
        return Future.value(const OAuth2Token(accessToken: 'newToken'));
      },
    );
    final awesomeBase = WiseClient(
      wiseInterceptors: WiseInterceptor.values,
      options: wiseBaseOptions,
      refreshFunction: (token, client) {
        return Future.value(const OAuth2Token(accessToken: 'newToken'));
      },
    );

    test('Client is native', () {
      expect(awesome.isWebClient, isFalse);
    });

    test('Client with base options is native', () {
      expect(awesomeBase.isWebClient, isFalse);
    });

    test(
      'WiseOptions sets correct locale query param when empty constructor is used',
      () {
        final options = WiseOptions(locale: 'en');
        expect(options.headers[HttpHeaders.acceptLanguageHeader], 'en');
      },
    );

    test(
      'Can replace client interceptors',
      () {
        final interceptor = FakeInterceptor();
        final client = WiseClient(
          interceptors: [interceptor],
          wiseInterceptors: [],
        );
        // Dio clients have imply content interceptor so length is 2
        expect(client.interceptors.length, 2);
        expect(client.interceptors.contains(interceptor), isTrue);
      },
    );

    test('isWebClient throws error when not implemented', () {
      expect(
        () => FakeClient().isWebClient,
        throwsA(isA<UnimplementedError>()),
      );
    });

    test('Expect url not to be empty', () async {
      expect(awesome.options.baseUrl, isNotEmpty);
    });

    test('Normal dio get works', () async {
      const path = 'todos/1';
      final something = await awesome.get<dynamic>(path);
      expect(something, isNotNull);
    });

    test('Normal dio post works', () async {
      const path = 'posts';
      const body = {
        'title': 'foo',
        'body': 'bar',
        'userId': 1,
      };
      final something = await awesome.post<dynamic>(
        path,
        data: body,
      );
      expect(something.data, isMap);
      expect((something.data as Map)['userId'], equals(1));
    });

    test('Normal dio put works', () async {
      const path = 'posts/1';
      const body = {
        'id': 1,
        'title': 'foo',
        'body': 'bar',
        'userId': 1,
      };
      final something = await awesome.put<dynamic>(
        path,
        data: body,
      );
      expect(something.data, isMap);
      expect((something.data as Map)['userId'], equals(1));
    });

    test('Wise get works', () async {
      const path = 'todos/1';
      final something = await awesome.wGet(path);
      expect(something, isMap);
    });

    test('Can add headers to requests', () async {
      const path = 'todos/1';
      const additionalHeaders = {'testHeader': 'testValue'};
      final something = await awesome.wGet(
        path,
        extraHeaders: additionalHeaders,
      );
      expect(something, isMap);
    });

    test('Does not remember headers', () async {
      const path = 'todos/1';
      const additionalHeaders1 = {'testHeader1': 'testValue1'};
      final firstResult = await awesome.wGet(
        path,
        extraHeaders: additionalHeaders1,
      );

      const additionalHeaders2 = {'testHeader2': 'testValue2'};
      final secondResult = await awesome.wGet(
        path,
        extraHeaders: additionalHeaders2,
      );
      expect(firstResult, isMap);
      expect(secondResult, isMap);
    });

    test('Wise post works', () async {
      const path = 'posts';
      const body = {
        'title': 'foo',
        'body': 'bar',
        'userId': 1,
      };
      final something = await awesome.wPost(
        path,
        body: body,
      );
      expect(something, isMap);
      expect((something as Map)['userId'], equals(1));
    });

    test('Wise get throws dio exception on non existing path', () async {
      const path = 'todos/1/notfound';
      expect(() => awesome.wGet(path), throwsA(isA<DioException>()));
    });

    test('Dio get throws dio exception on non existing path', () async {
      const path = 'todos/1/notfound';
      expect(() => awesome.get<dynamic>(path), throwsA(isA<DioException>()));
    });

    test('cancelWiseRequests method works correctly', () {
      awesome.cancelWiseRequests();
      expect(awesome.cancelToken.isCancelled, isTrue);
    });

    test(
      'resetWiseCancelToken method does not result in a cancelled token ',
      () {
        awesome.resetWiseCancelToken();
        expect(awesome.cancelToken.isCancelled, isFalse);
      },
    );

    test('removeFreshToken method works correctly', () async {
      final mockFresh = MockFresh();
      final client = WiseClient(
        wiseInterceptors: [],
        options: WiseOptions(),
      )..fresh = mockFresh;

      when(() => mockFresh.setToken(null)).thenAnswer((_) async {});
      when(mockFresh.revokeToken).thenAnswer((_) async {});

      await client.removeFreshToken();

      verify(() => mockFresh.setToken(null)).called(1);
      verify(mockFresh.revokeToken).called(1);
    });

    test('addHeaders method works correctly', () {
      final headers = {'Authorization': 'Bearer token'};
      awesome.addHeaders(headers: headers);

      expect(awesome.options.headers['Authorization'], 'Bearer token');
    });

    test('Cancelled token does not finish request', () async {
      const path = 'todos/1';
      dynamic response;
      try {
        Future.delayed(
          const Duration(milliseconds: 5),
          awesome.cancelAndReset,
        );
        response = await awesome.wGet(path);
      } catch (e) {
        response = e.toString();
      }
      expect(response, isA<String>());
    });

    test('Can cancel and reset successfully', () async {
      const path = 'todos/1';
      dynamic response;
      try {
        Future.delayed(
          const Duration(milliseconds: 5),
          awesome.cancelAndReset,
        );
        response = await awesome.wGet(path);
      } catch (e) {
        response = e.toString();
      }
      expect(response, isA<String>());
      await Future.delayed(
        const Duration(seconds: 2),
        () async {
          final secondRequest = await awesome.wGet(path);
          expect(secondRequest, isMap);
        },
      );
    });

    test('Can successfully read the refresh token from storage', () async {
      final storage = MockStorage();
      when(storage.read).thenAnswer(
        (_) => Future.value(
          const OAuth2Token(accessToken: 'token'),
        ),
      );
      final token = await storage.read();
      expect(token, isA<OAuth2Token>());
    });

    test('Token tests', () async {
      const token = OAuth2Token(
        accessToken: 'token',
        expiresIn: 100,
        refreshToken: 'refresh',
        scope: 'scope',
      );
      expect(token.accessToken, isA<String>());
      expect(token.expiresIn, isA<int>());
      expect(token.refreshToken, isA<String>());
      expect(token.scope, isA<String>());
      expect(token.tokenType, 'bearer');
      final tokenMap = token.toMap();
      expect(tokenMap, isMap);
    });

    test('Token from snake case', () async {
      final issuedAt = DateTime(2017, 5, 12);
      final token = <String, dynamic>{
        'access_token': 'token',
        'token_type': 'bearer',
        'expires_in': 100,
        'refresh_token': 'refresh',
        'scope': 'scope',
        'issued_at': issuedAt.toIso8601String(),
      }.toOAuth2TokenFromSnakeCase();
      expect(token.accessToken, 'token');
      expect(token.tokenType, 'bearer');
      expect(token.expiresIn, 100);
      expect(token.refreshToken, 'refresh');
      expect(token.scope, 'scope');
      expect(token.issuedAt, issuedAt);
    });

    test('Token from snake case without date', () async {
      final token = <String, dynamic>{
        'access_token': 'token',
        'token_type': 'bearer',
        'expires_in': 100,
        'refresh_token': 'refresh',
        'scope': 'scope',
      }.toOAuth2TokenFromSnakeCase();
      expect(
        token.issuedAt?.difference(DateTime.now()),
        lessThan(const Duration(seconds: 1)),
      );
    });

    test('Token from camel case', () async {
      final issuedAt = DateTime(2017, 5, 12);
      final token = <String, dynamic>{
        'accessToken': 'token',
        'tokenType': 'bearer',
        'expiresIn': 100,
        'refreshToken': 'refresh',
        'scope': 'scope',
        'issuedAt': issuedAt.toIso8601String(),
      }.toOAuth2TokenFromCamelCase();
      expect(token.accessToken, 'token');
      expect(token.tokenType, 'bearer');
      expect(token.expiresIn, 100);
      expect(token.refreshToken, 'refresh');
      expect(token.scope, 'scope');
      expect(token.issuedAt, issuedAt);
    });

    test('Token from camel case without date', () async {
      final token = <String, dynamic>{
        'accessToken': 'token',
        'tokenType': 'bearer',
        'expiresIn': 100,
        'refreshToken': 'refresh',
        'scope': 'scope',
      }.toOAuth2TokenFromCamelCase();
      expect(
        token.issuedAt?.difference(DateTime.now()),
        lessThan(const Duration(seconds: 1)),
      );
    });

    test('Token from string', () async {
      final date = DateTime(2017, 5, 12);
      final tokenString =
          '{"accessToken":"token","tokenType":"bearer","expiresIn":100,"refreshToken":"refresh","scope":"scope","issuedAt":"${date.toIso8601String()}"}';
      final token = tokenString.toOAuth2Token;
      expect(token.accessToken, 'token');
      expect(token.tokenType, 'bearer');
      expect(token.expiresIn, 100);
      expect(token.refreshToken, 'refresh');
      expect(token.scope, 'scope');
      expect(token.issuedAt, date);
    });

    test('Can set the client token', () async {
      await awesome.setFreshToken(
        token: const OAuth2Token(accessToken: 'accessToken'),
      );
      final token = await awesome.fresh.token;
      expect(token?.accessToken, 'accessToken');

      await awesome.fresh.clearToken();
      expect(await awesome.fresh.token, isNull);
    });

    test('authenticationStatus stream returns correct status', () {
      final mockFresh = MockFresh();
      final client = WiseClient(
        wiseInterceptors: [],
        options: WiseOptions(),
      )..fresh = mockFresh;

      final authStatusStream = Stream<AuthenticationStatus>.fromIterable(
        [AuthenticationStatus.authenticated],
      );

      when(
        () => mockFresh.authenticationStatus,
      ).thenAnswer((_) => authStatusStream);

      expect(
        client.authenticationStatus,
        emitsInOrder([AuthenticationStatus.authenticated]),
      );
    });
  });

  group('Exception throwing tests', () {
    test('UnknownException throws a', () {
      final exception = UnknownException('Test message');
      expect(exception.message, equals('Test message'));
      expect(() => throw exception, throwsA(isA<UnknownException>()));
    });
  });

  group('InMemoryStorage', () {
    late InMemoryTokenStorage<MockToken> inMemoryTokenStorage;
    final token = MockToken();

    setUp(() {
      inMemoryTokenStorage = InMemoryTokenStorage();
    });

    test('read returns null when there is no token', () async {
      expect(await inMemoryTokenStorage.read(), isNull);
    });

    test('can write and read token when there is a token', () async {
      await inMemoryTokenStorage.write(token);
      expect(await inMemoryTokenStorage.read(), token);
    });

    test('delete does nothing when there is no token', () async {
      expect(inMemoryTokenStorage.delete(), completes);
    });

    test('delete removes token when there is a token', () async {
      await inMemoryTokenStorage.write(token);
      expect(await inMemoryTokenStorage.read(), token);
      await inMemoryTokenStorage.delete();
      expect(await inMemoryTokenStorage.read(), isNull);
    });
  });

  group('FreshMixin', () {
    late TokenStorage<OAuth2Token> tokenStorage;

    setUp(() {
      tokenStorage = MockTokenStorage();
    });

    group('token', () {
      test(
        'returns token once it has successfully loaded from storage',
        () async {
          final mockToken = MockToken();
          when(() => tokenStorage.read()).thenAnswer((_) async => mockToken);
          final freshController = FreshController<OAuth2Token>(tokenStorage);
          final token = await freshController.token;
          expect(token, mockToken);
        },
      );

      test('waits for storage read to complete', () async {
        final mockToken = MockToken();
        when(() => tokenStorage.read()).thenAnswer((_) async {
          await Future<void>.delayed(Duration.zero);
          return mockToken;
        });
        final freshController = FreshController<OAuth2Token>(tokenStorage);
        final token = await freshController.token;
        expect(token, mockToken);
      });
    });

    group('revokeToken', () {
      test('add unauthenticated when call revokeToken', () async {
        final mockToken = MockToken();
        when(() => tokenStorage.read()).thenAnswer((_) async => mockToken);
        when(() => tokenStorage.delete()).thenAnswer((_) async {});

        final freshController = FreshController<OAuth2Token>(tokenStorage);

        await freshController.revokeToken();

        await expectLater(
          freshController.authenticationStatus,
          emitsInOrder(const <AuthenticationStatus>[
            AuthenticationStatus.unauthenticated,
          ]),
        );

        verify(() => tokenStorage.delete()).called(1);
        verify(() => tokenStorage.read()).called(1);
      });
    });

    group('initial authentication status', () {
      test('is unauthenticated when tokenStorage.read is null', () async {
        when(() => tokenStorage.read()).thenAnswer((_) async => null);
        final freshController = FreshController<OAuth2Token>(tokenStorage);
        await expectLater(
          freshController.authenticationStatus,
          emitsInOrder(const <AuthenticationStatus>[
            AuthenticationStatus.unauthenticated,
          ]),
        );
      });

      test('is authenticated when tokenStorage.read is not null', () async {
        when(() => tokenStorage.read()).thenAnswer((_) async => MockToken());
        final freshController = FreshController<OAuth2Token>(tokenStorage);
        await expectLater(
          freshController.authenticationStatus,
          emitsInOrder(const <AuthenticationStatus>[
            AuthenticationStatus.authenticated,
          ]),
        );
      });
    });

    group('configureToken', () {
      setUpAll(() {
        registerFallbackValue(FakeOAuth2Token());
      });

      group('setToken', () {
        test('invokes tokenStorage.write', () async {
          when(() => tokenStorage.read()).thenAnswer((_) async => MockToken());
          when(() => tokenStorage.write(any())).thenAnswer((_) async {});
          final token = MockToken();
          final freshController = FreshController<OAuth2Token>(tokenStorage);
          await freshController.setToken(token);
          verify(() => tokenStorage.write(token)).called(1);
        });

        test('adds unauthenticated status when call setToken(null)', () async {
          when(() => tokenStorage.read()).thenAnswer((_) async => MockToken());
          when(() => tokenStorage.write(any())).thenAnswer((_) async {});
          when(() => tokenStorage.delete()).thenAnswer((_) async {});
          final freshController = FreshController<OAuth2Token>(tokenStorage);
          await freshController.setToken(null);
          await expectLater(
            freshController.authenticationStatus,
            emitsInOrder(const <AuthenticationStatus>[
              AuthenticationStatus.unauthenticated,
            ]),
          );
        });
        test('adds authenticated status if token is not null', () async {
          when(() => tokenStorage.read()).thenAnswer((_) async => null);
          when(() => tokenStorage.write(any())).thenAnswer((_) async {});
          final freshController = FreshController<OAuth2Token>(tokenStorage);

          await freshController.setToken(MockToken());

          await expectLater(
            freshController.authenticationStatus,
            emitsInOrder(
              const <AuthenticationStatus>[AuthenticationStatus.authenticated],
            ),
          );
        });
      });

      group('clearToken', () {
        test('adds unauthenticated status when call clearToken()', () async {
          when(() => tokenStorage.read()).thenAnswer((_) async => MockToken());
          when(() => tokenStorage.write(any())).thenAnswer((_) async {});
          when(() => tokenStorage.delete()).thenAnswer((_) async {});
          final freshController = FreshController<OAuth2Token>(tokenStorage);
          await freshController.clearToken();
          await expectLater(
            freshController.authenticationStatus,
            emitsInOrder(const <AuthenticationStatus>[
              AuthenticationStatus.unauthenticated,
            ]),
          );
        });
      });
    });

    group('close', () {
      test('should close streams', () async {
        when(() => tokenStorage.read()).thenAnswer((_) async => null);
        when(() => tokenStorage.write(any())).thenAnswer((_) async {});
        final freshController = FreshController<OAuth2Token>(tokenStorage);

        final mockToken = MockToken();
        await freshController.setToken(mockToken);
        await freshController.close();

        await expectLater(
          freshController.authenticationStatus,
          emitsInOrder(
            <Matcher>[equals(AuthenticationStatus.authenticated), emitsDone],
          ),
        );
      });
    });
  });

  group('Token refresh', () {
    test(
      'persists a refreshed OAuth2Token and retries the request',
      () async {
        final storage = FreshSecureTokenStorage();
        await storage.write(
          const OAuth2Token(accessToken: 'old', refreshToken: 'refresh'),
        );
        final adapter = TokenCheckingAdapter();
        final dio = Dio()
          ..httpClientAdapter = adapter
          ..interceptors.add(
            Fresh.oAuth2(
              tokenStorage: storage,
              httpClient: Dio()..httpClientAdapter = adapter,
              refreshToken: (_, __) async =>
                  const OAuth2Token(accessToken: 'new'),
            ),
          );

        final response = await dio.get<dynamic>('https://example.com');

        expect(response.statusCode, 200);
        final stored = await storage.storage.read(
          key: storage.storageIdentifier,
        );
        expect(stored?.toOAuth2Token.accessToken, 'new');
      },
    );
  });

  group('Unreadable stored token', () {
    test('malformed values throw TokenParseException', () {
      const malformed = [
        'not json',
        '[]',
        '{}',
        '{"accessToken":1}',
        '{"accessToken":"token","expiresIn":"100"}',
        '{"accessToken":"token","issuedAt":"yesterday"}',
      ];
      for (final value in malformed) {
        expect(
          () => value.toOAuth2Token,
          throwsA(isA<TokenParseException>()),
          reason: value,
        );
      }
    });

    test('is deleted, reported and read as no token', () async {
      final storage = FreshSecureTokenStorage();
      await storage.storage.write(
        key: storage.storageIdentifier,
        value: 'not json',
      );

      final (token, reported) = await captureReportedErrors(
        () => FreshSecureTokenStorage().read(),
      );

      expect(token, isNull);
      expect(reported, [isA<TokenParseException>()]);
      expect(
        await storage.storage.read(key: storage.storageIdentifier),
        isNull,
      );
    });

    test('does not hang requests', () async {
      final storage = FreshSecureTokenStorage();
      await storage.storage.write(
        key: storage.storageIdentifier,
        value: 'not json',
      );
      final adapter = TokenCheckingAdapter();

      final (response, _) = await captureReportedErrors(() {
        final dio = Dio()
          ..httpClientAdapter = adapter
          ..options.validateStatus = ((_) => true)
          ..interceptors.add(
            Fresh.oAuth2(
              tokenStorage: FreshSecureTokenStorage(),
              httpClient: Dio()..httpClientAdapter = adapter,
              refreshToken: (_, __) async =>
                  const OAuth2Token(accessToken: 'new'),
            ),
          );
        return dio
            .get<dynamic>('https://example.com')
            .timeout(const Duration(seconds: 5));
      });

      expect(response.statusCode, 401);
    });
  });
}
