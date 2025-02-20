import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// [PlatformWidget] that returns Cupertino widget or Material widget
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

  /// Create Cupertino Widget
  I createCupertinoWidget(BuildContext context);

  /// Create Material Widget
  A createMaterialWidget(BuildContext context);
}
