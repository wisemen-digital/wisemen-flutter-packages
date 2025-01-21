import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_router.dart';

part 'app_router_service.g.dart';

@Riverpod(keepAlive: true)
Raw<AppRouter> appRouterService(Ref ref) {
  return AppRouter()..ref = ref;
}
