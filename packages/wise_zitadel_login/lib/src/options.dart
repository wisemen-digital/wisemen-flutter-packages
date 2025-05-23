import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wiseclient/wiseclient.dart';
import 'types/zitadel_login_type.dart';

/// [WiseZitadelOptions] containing params (usually flavored) used by the repository
class WiseZitadelOptions {
  /// [WiseZitadelOptions] constructor
  const WiseZitadelOptions({
    required this.baseUrl,
    required this.bundleId,
    required this.applicationId,
    required this.organizationId,
    required this.supportedTypes,
    required this.onLoginSuccess,
    required this.buttonOptions,
  });

  /// The base api URL for the application
  final String baseUrl;

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
  ) onLoginSuccess;

  /// Login button styling options
  final WiseZitadelButtonOptions buttonOptions;
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
