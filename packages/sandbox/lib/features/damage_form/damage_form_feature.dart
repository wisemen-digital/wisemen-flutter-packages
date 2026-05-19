import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'damage_form.dart';

class DamageFormFeature {
  static late Provider<DamageFormRepository> damageFormRepository;

  static void init({
    required Provider<DamageFormRepository> repository,
  }) {
    damageFormRepository = repository;
  }
}
