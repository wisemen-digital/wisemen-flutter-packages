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

class FakeOAuthToken extends Fake implements OAuthToken {}

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

extension VoidAnswer on When<Future<void>> {
  void thenAnswerWithVoid() => thenAnswer((_) async {});
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterSecureStorage.setMockInitialValues({});

  setUpAll(() {
    registerFallbackValue(FakeSecureStorage());
    registerFallbackValue(FakeOAuthToken());
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
        return Future.value(OAuthToken(accessToken: 'newToken'));
      },
    );
    final awesomeBase = WiseClient(
      wiseInterceptors: WiseInterceptor.values,
      options: wiseBaseOptions,
      refreshFunction: (token, client) {
        return Future.value(OAuthToken(accessToken: 'newToken'));
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
          OAuthToken(accessToken: 'token'),
        ),
      );
      final token = await storage.read();
      expect(token, isA<OAuthToken>());
    });

    test('Token tests', () async {
      final token = OAuthToken(
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
      final token = OAuthToken.fromSnakeCase(
        {
          'access_token': 'token',
          'token_type': 'bearer',
          'expires_in': 100,
          'refresh_token': 'refresh',
          'scope': 'scope',
          'issued_at': DateTime.now().toIso8601String(),
        },
      );
      expect(token, isA<OAuthToken>());
    });

    test('Token from snake case without date', () async {
      final token = OAuthToken.fromSnakeCase(
        {
          'access_token': 'token',
          'token_type': 'bearer',
          'expires_in': 100,
          'refresh_token': 'refresh',
          'scope': 'scope',
        },
      );
      expect(token, isA<OAuthToken>());
      expect(
        token.issuedAt?.difference(DateTime.now()),
        lessThan(const Duration(seconds: 1)),
      );
    });

    test('Token from camel case', () async {
      final token = OAuthToken.fromCamelCasing(
        {
          'accessToken': 'token',
          'tokenType': 'bearer',
          'expiresIn': 100,
          'refreshToken': 'refresh',
          'scope': 'scope',
          'issuedAt': DateTime.now().toIso8601String(),
        },
      );
      expect(token, isA<OAuthToken>());
    });

    test('Token from camel case without date', () async {
      final token = OAuthToken.fromCamelCasing(
        {
          'accessToken': 'token',
          'tokenType': 'bearer',
          'expiresIn': 100,
          'refreshToken': 'refresh',
          'scope': 'scope',
        },
      );
      expect(token, isA<OAuthToken>());
      expect(
        token.issuedAt?.difference(DateTime.now()),
        lessThan(const Duration(seconds: 1)),
      );
    });

    test('Token from string', () async {
      final date = DateTime(2017, 5, 12);
      final tokenString =
          '{"accessToken":"token","tokenType":"bearer","expiresIn":100,"refreshToken":"refresh","scope":"scope","issuedAt":"${date.toIso8601String()}"}';
      final token = tokenString.toOAuthToken;
      expect(token, isA<OAuthToken>());
      expect(token.accessToken, 'token');
      expect(token.tokenType, 'bearer');
      expect(token.expiresIn, 100);
      expect(token.refreshToken, 'refresh');
      expect(token.scope, 'scope');
      expect(token.issuedAt, date);
    });

    test('Can set the client token', () async {
      await awesome.setFreshToken(
        token: OAuthToken(accessToken: 'accessToken'),
      );
      final token = await awesome.fresh.token;
      expect(token, isA<OAuthToken>());

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
    test('LogoutException throws a', () {
      expect(() => throw LogoutException(), throwsA(isA<LogoutException>()));
    });

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
}
