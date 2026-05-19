import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../damage_form.dart';

part 'damage_form_providers.g.dart';

class DamageFormProviders {
  static var model = damageFormProviderProvider;
}

@Riverpod(keepAlive: true)
class DamageFormProvider extends _$DamageFormProvider {
  @override
  DamageForm build() {
    return DamageForm.init();
  }

  void changeValue(DamageForm form) {
    state = form;
  }
}
