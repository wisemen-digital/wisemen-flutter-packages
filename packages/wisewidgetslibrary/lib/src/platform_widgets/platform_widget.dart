import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Platform widget with Material and Cupertino
abstract class PlatformWidget<I extends Widget, A extends Widget>
    extends StatelessWidget {
  /// Constructor [PlatformWidget]
  const PlatformWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return createMaterialWidget(context);
    }
    if (Platform.isAndroid || Platform.isFuchsia || Platform.isWindows) {
      return createMaterialWidget(context);
    } else if (Platform.isIOS || Platform.isMacOS || Platform.isLinux) {
      return createCupertinoWidget(context);
    }

    // Platform not supported returns an empty widget
    return const SizedBox.shrink();
  }

  /// Create Cupertino widget
  I createCupertinoWidget(BuildContext context);

  /// Create Material widget
  A createMaterialWidget(BuildContext context);
}
