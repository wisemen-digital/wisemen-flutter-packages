import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_providers.g.dart';

@Riverpod(keepAlive: true)
class HasShownUpdate extends _$HasShownUpdate {
  @override
  bool build() {
    return false;
  }

  void changeValue(bool value) {
    state = value;
  }
}
