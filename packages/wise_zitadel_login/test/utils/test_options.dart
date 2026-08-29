import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_zitadel_login/wise_zitadel_login.dart';
import 'package:wiseclient/wiseclient.dart' show OAuthToken;

/// The login type used across the tests.
const testLoginType = ZitadelLoginType(
  idp: 'idp_id',
  buttonText: 'Login',
  iconSvgString: '',
);

/// Builds [WiseZitadelOptions] with values every test can rely on.
WiseZitadelOptions testOptions({
  String zitadelBaseUrl = 'https://zitadel.example.com',
  List<ZitadelLoginType> supportedTypes = const [testLoginType],
  void Function(StackRouter router, WidgetRef ref, OAuthToken? token)?
  onLoginSuccess,
}) {
  return WiseZitadelOptions(
    zitadelBaseUrl: zitadelBaseUrl,
    bundleId: 'com.example.app',
    applicationId: 'app_id',
    organizationId: 'org_id',
    supportedTypes: supportedTypes,
    onLoginSuccess: onLoginSuccess ?? (router, ref, token) {},
    buttonOptions: WiseZitadelButtonOptions(
      color: (_) => const Color(0xFFFF9000),
      buttonTextStyle: (_) => const TextStyle(),
    ),
  );
}
