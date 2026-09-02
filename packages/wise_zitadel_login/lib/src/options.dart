import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oidc/oidc.dart';
import 'package:wiseclient/wiseclient.dart';
import 'types/zitadel_login_type.dart';

/// [WiseZitadelOptions] containing params (usually flavored) used by the repository
class WiseZitadelOptions {
  /// [WiseZitadelOptions] constructor
  const WiseZitadelOptions({
    required this.zitadelBaseUrl,
    required this.bundleId,
    required this.applicationId,
    required this.organizationId,
    required this.supportedTypes,
    required this.onLoginSuccess,
    required this.buttonOptions,
    this.store,
  });

  /// The base api URL for the application
  final String zitadelBaseUrl;

  /// The app's bundle id
  final String bundleId;

  /// Zitadel application id
  final String applicationId;

  /// Zitadel organization id
  final String organizationId;

  /// Supported login types
  final List<ZitadelLoginType> supportedTypes;

  /// Callback function to be called on successful login
  final void Function(
    StackRouter router,
    WidgetRef ref,
    OAuthToken? token,
  )
  onLoginSuccess;

  /// Login button styling options
  final WiseZitadelButtonOptions buttonOptions;

  /// The store the login flow keeps its authorization state in
  ///
  /// `null` keeps the state in memory, which is all a native platform needs: it
  /// hands the redirect back to the running app, so the state only has to
  /// outlive an `await`.
  ///
  /// **Web apps have to pass a persistent one.** The login navigates the app's
  /// own tab to Zitadel and the browser comes back to a fresh page load, so an
  /// in-memory state is gone before the response arrives and the login cannot
  /// be finished. Add
  /// [oidc_web_core](https://pub.dev/packages/oidc_web_core) to your app and
  /// pass its `OidcWebStore`, which stores in the browser under the same keys
  /// the `redirect.html` in your `web/` folder writes:
  ///
  /// ```dart
  /// WiseZitadelOptions(
  ///   // ...
  ///   store: const OidcWebStore(),
  /// )
  /// ```
  final OidcStore? store;
}

/// [WiseZitadelButtonOptions] containing button styling options
class WiseZitadelButtonOptions {
  /// [WiseZitadelButtonOptions] constructor
  const WiseZitadelButtonOptions({
    required this.color,
    required this.buttonTextStyle,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.borderSide,
  });

  /// The background color of the button
  final Color Function(BuildContext) color;

  /// The text style of the button's text
  final TextStyle Function(BuildContext) buttonTextStyle;

  /// The border radius of the button
  final BorderRadius borderRadius;

  /// The optional border side of the button
  final BorderSide? borderSide;
}
