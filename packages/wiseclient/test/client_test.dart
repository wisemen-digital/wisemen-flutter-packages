import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:wiseclient/src/error_screens/messages.dart';
import 'package:wiseclient/src/secure_token_storage/fresh_secure_token_storage.dart';
import 'package:wiseclient/src/secure_token_storage/map_from_token_extension.dart';
import 'package:wiseclient/src/secure_token_storage/token_from_string_extension.dart';
import 'package:wiseclient/wiseclient.dart';

class MockStorage extends Mock implements FreshSecureTokenStorage {}

class FakeSecureStorage extends Fake implements FlutterSecureStorage {}

class FakeOAuthToken extends Fake implements OAuthToken {}

class MockClient extends Mock implements WiseClient {}

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
    final awesome = WiseClient(
      wiseInterceptors: WiseInterceptor.values,
      options: wiseOptions,
      refreshFunction: (token, client) {
        return Future.value(OAuthToken(accessToken: 'newToken'));
      },
    );

    test('Client is native', () {
      expect(awesome.isWebClient, isFalse);
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
        },
      );
      expect(token, isA<OAuthToken>());
    });

    test('Token from camel case', () async {
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
    });

    test('Token from string', () async {
      const tokenString = '{"accessToken":"token","tokenType":"bearer","expiresIn":100,"refreshToken":"refresh","scope":"scope"}';
      final token = tokenString.toOAuthToken;
      expect(token, isA<OAuthToken>());
      expect(token.accessToken, 'token');
      expect(token.tokenType, 'bearer');
      expect(token.expiresIn, 100);
      expect(token.refreshToken, 'refresh');
      expect(token.scope, 'scope');
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
  });

  group('Error Messages Tests', () {
    test('getServerErrorTitle returns correct message', () {
      expect(getServerErrorTitle('nl'), 'Serverfout');
      expect(getServerErrorTitle('es'), 'Error del servidor');
      expect(getServerErrorTitle('de'), 'Serverfehler');
      expect(getServerErrorTitle('fr'), 'Erreur de serveur');
      expect(getServerErrorTitle('ar'), 'خطأ في الخادم');
      expect(getServerErrorTitle('ja'), 'サーバーエラー');
      expect(getServerErrorTitle('unknown'), 'Client error');
    });

    test('getClientErrorTitle returns correct message', () {
      expect(getClientErrorTitle('nl'), 'Clientfout');
      expect(getClientErrorTitle('es'), 'Error del cliente');
      expect(getClientErrorTitle('de'), 'Clientfehler');
      expect(getClientErrorTitle('fr'), 'Erreur client');
      expect(getClientErrorTitle('ar'), 'خطأ في العميل');
      expect(getClientErrorTitle('ja'), 'クライアントエラー');
      expect(getClientErrorTitle('unknown'), 'Client error');
    });

    test('getDetailedClientErrorMessage returns correct message', () {
      expect(getDetailedClientErrorMessage('en'), 'A client error occurred, please try again later');
      expect(getDetailedClientErrorMessage('nl'), 'Er is een fout opgetreden bij de client, probeer het later opnieuw');
      expect(getDetailedClientErrorMessage('es'), 'Se produjo un error del cliente, por favor inténtelo de nuevo más tarde');
      expect(getDetailedClientErrorMessage('de'), 'Es ist ein Clientfehler aufgetreten, bitte versuchen Sie es später erneut');
      expect(getDetailedClientErrorMessage('fr'), "Une erreur client s'est produite, veuillez réessayer plus tard");
      expect(getDetailedClientErrorMessage('ar'), 'حدث خطأ في العميل، يرجى المحاولة مرة أخرى لاحقًا');
      expect(getDetailedClientErrorMessage('ja'), 'クライアントエラーが発生しました。後でもう一度お試しください');
      expect(getDetailedClientErrorMessage('unknown'), 'A client error occurred, please try again later');
    });

    test('getDetailedServerErrorMesssage returns correct message', () {
      expect(getDetailedServerErrorMesssage('en'), 'A server error occurred, please try again later');
      expect(getDetailedServerErrorMesssage('nl'), 'Er is een serverfout opgetreden, probeer het later opnieuw');
      expect(getDetailedServerErrorMesssage('es'), 'Se produjo un error del servidor, por favor inténtelo de nuevo más tarde');
      expect(getDetailedServerErrorMesssage('de'), 'Es ist ein Serverfehler aufgetreten, bitte versuchen Sie es später erneut');
      expect(getDetailedServerErrorMesssage('fr'), "Une erreur de serveur s'est produite, veuillez réessayer plus tard");
      expect(getDetailedServerErrorMesssage('ar'), 'حدث خطأ في الخادم، يرجى المحاولة مرة أخرى لاحقًا');
      expect(getDetailedServerErrorMesssage('ja'), 'サーバーエラーが発生しました。後でもう一度お試しください');
      expect(getDetailedServerErrorMesssage('unknown'), 'A server error occurred, please try again later');
    });

    test('getViewFullMessage returns correct message', () {
      expect(getViewFullMessage('en'), 'View full message');
      expect(getViewFullMessage('nl'), 'Bekijk volledig bericht');
      expect(getViewFullMessage('es'), 'Ver mensaje completo');
      expect(getViewFullMessage('de'), 'Vollständige Nachricht anzeigen');
      expect(getViewFullMessage('fr'), 'Voir le message complet');
      expect(getViewFullMessage('ar'), 'عرض الرسالة بالكامل');
      expect(getViewFullMessage('ja'), '全文を表示');
      expect(getViewFullMessage('unknown'), 'View full message');
    });
  });
}
