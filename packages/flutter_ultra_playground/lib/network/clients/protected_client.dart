import 'package:flutter_ultra_playground/features/shared/shared.dart';
import 'package:flutter_ultra_playground/flavors.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wise_ultra_login/wise_ultra_login.dart';
import 'package:wiseclient/wiseclient.dart';

import 'fake_client.dart';

part 'protected_client.g.dart';

@Riverpod(keepAlive: true)
class ProtectedClient extends _$ProtectedClient {
  @override
  WiseClient build() {
    if (AppConstants.fakerMode) {
      return FakerWiseClient(wiseInterceptors: []);
    }
    return WiseClient(
      refreshFunction: (token, dio) async {
        return await ref.read(baseLoginRepositoryProvider).refresh(token);
      },
      options: WiseOptions.base(url: F.baseUrl),
      wiseInterceptors: [WiseInterceptor.fresh],
      useNativeAdapter: PlatformUtils.isIos,
    );
  }
}
