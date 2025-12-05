import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ultra_playground/flavors.dart';
import 'package:wise_ultra_update/wise_ultra_update.dart';
import 'package:wisecore/wisecore.dart';

import '../app_router_service.dart';

class UpdateNavigationManagerImpl implements UpdateNavigationManager {
  final Ref ref;

  StackRouter? get currentRouter => ref.read(appRouterServiceProvider).navigatorKey.currentContext?.router;

  UpdateNavigationManagerImpl({required this.ref});

  @override
  void installLater() {
    currentRouter?.maybePop();
  }

  @override
  void installUpdate() {
    WiseLauncher.launchUrl(url: F.storeUrl, onCannotLaunchUrl: () {});
  }
}

final updateNavigationManagerProvider = Provider<UpdateNavigationManager>((ref) => UpdateNavigationManagerImpl(ref: ref));
