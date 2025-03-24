import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Platform service interface to abstract platform checks
abstract class PlatformService {
  /// Check if the platform is Android
  bool get isAndroid;

  /// Check if the platform is iOS
  bool get isIOS;

  /// Check if the platform is Web
  bool get isWeb;

  /// Check if the platform is macOS
  bool get isMacOS;

  /// Check if the platform is Linux
  bool get isLinux;

  /// Check if the platform is Fuchsia
  bool get isFuchsia;

  /// Check if the platform is Windows
  bool get isWindows;
}

/// Default implementation of PlatformService using the `dart:io` Platform
class DefaultPlatformService implements PlatformService {
  @override
  bool get isAndroid => Platform.isAndroid;

  @override
  bool get isIOS => Platform.isIOS;

  @override
  bool get isWeb => kIsWeb;

  @override
  bool get isMacOS => Platform.isMacOS;

  @override
  bool get isLinux => Platform.isLinux;

  @override
  bool get isFuchsia => Platform.isFuchsia;

  @override
  bool get isWindows => Platform.isWindows;
}

/// [PlatformWidget] that returns Cupertino widget or Material widget
abstract class PlatformWidget<I extends Widget, A extends Widget>
    extends StatelessWidget {
  /// Constructor [PlatformWidget]
  const PlatformWidget({
    required this.platformService,
    super.key,
  });

  /// Platform service
  final PlatformService platformService;

  @override
  Widget build(BuildContext context) {
    if (platformService.isWeb) {
      return createMaterialWidget(context);
    }
    if (platformService.isAndroid ||
        platformService.isFuchsia ||
        platformService.isWindows) {
      return createMaterialWidget(context);
    } else if (platformService.isIOS ||
        platformService.isMacOS ||
        platformService.isLinux) {
      return createCupertinoWidget(context);
    }
    // Platform not supported returns an empty widget
    return const SizedBox.shrink();
  }

  /// Create Cupertino Widget
  I createCupertinoWidget(BuildContext context);

  /// Create Material Widget
  A createMaterialWidget(BuildContext context);
}
