import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Platform widget with Material and Cupertino
abstract class PlatformWidget<I extends Widget, A extends Widget> extends StatelessWidget {
  /// Constructor [PlatformWidget]
  const PlatformWidget({
    super.key,
    IsWebService? isWebService,
  }) : _isWebService = isWebService ?? const _IsWebServiceImpl();

  final IsWebService _isWebService;

  @override
  Widget build(BuildContext context) {
    if (_isWebService.getIsWeb()) {
      return createMaterialWidget(context);
    }
    final platform = Theme.of(context).platform;
    switch (platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.windows:
        return createMaterialWidget(context);
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
        return createCupertinoWidget(context);
    }
  }

  /// Create Cupertino widget
  I createCupertinoWidget(BuildContext context);

  /// Create Material widget
  A createMaterialWidget(BuildContext context);
}

/// Platform service interface to abstract platform checks (for tests)
// ignore: one_member_abstracts
abstract interface class IsWebService {
  /// Check if the platform is Web
  bool getIsWeb();
}

class _IsWebServiceImpl implements IsWebService {
  const _IsWebServiceImpl();
  @override
  bool getIsWeb() => kIsWeb;
}
