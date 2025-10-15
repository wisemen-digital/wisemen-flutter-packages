import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/experimental/mutation.dart';
import 'package:hooks_riverpod/misc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wise_zitadel_login/wise_zitadel_login.dart';

int loginCalls = 0;

class FakeRef extends Fake implements MutationTarget {
  static const type = ZitadelLoginType(
    idp: 'idp_id',
    buttonText: 'Login',
    iconSvgString: '',
  );

  T read<T>(ProviderListenable<T> provider) {
    // ignore: unrelated_type_equality_checks
    if (provider == wiseZitadelOptionsProvider) {
      return WiseZitadelOptions(
        applicationId: '',
        zitadelBaseUrl: '',
        bundleId: '',
        organizationId: '',
        supportedTypes: [type],
        onLoginSuccess: (router, ref, token) {
          if (token != null) {
            loginCalls++;
          }
        },
        buttonOptions: WiseZitadelButtonOptions(
          color: (_) => const Color(0xFFFF9000),
          buttonTextStyle: (_) => const TextStyle(),
        ),
      ) as T;
    }
    throw UnimplementedError();
  }

  T watch<T>(ProviderListenable<T> provider) {
    // ignore: unrelated_type_equality_checks
    if (provider == wiseZitadelOptionsProvider) {
      return WiseZitadelOptions(
        applicationId: '',
        zitadelBaseUrl: '',
        bundleId: '',
        organizationId: '',
        supportedTypes: [type],
        onLoginSuccess: (router, ref, token) {},
        buttonOptions: WiseZitadelButtonOptions(
          color: (_) => const Color(0xFFFF9000),
          buttonTextStyle: (_) => const TextStyle(),
        ),
      ) as T;
    }
    throw UnimplementedError();
  }
}
