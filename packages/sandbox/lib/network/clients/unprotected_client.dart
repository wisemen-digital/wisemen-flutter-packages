import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:wiseclient/wiseclient.dart';

import '../../features/shared/shared.dart';
import '../../flavors.dart';

part 'unprotected_client.g.dart';

@Riverpod(keepAlive: true)
class UnprotectedClient extends _$UnprotectedClient {
  @override
  WiseClient build() {
    return WiseClient(
      options: WiseOptions.base(
        url: F.baseUrl,
      ),
      wiseInterceptors: [
        WiseInterceptor.error,
      ],
      useNativeAdapter: PlatformUtils.isIos,
    );
  }
}
