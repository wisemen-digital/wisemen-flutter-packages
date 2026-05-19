import 'package:database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repository/repository.dart';
import 'package:sandbox/features/damage_form/damage_form.dart';
import 'package:sandbox/utils/utils.dart';

class DamageFormRepositoryImpl implements DamageFormRepository {
  const DamageFormRepositoryImpl(this.ref);
  final Ref ref;

  DamageFormDao get damageFormDao => ref.read(appRepositoryServiceProvider).database.damageFormDao;

  @override
  Future<void> submitForm(DamageForm form) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<DamageForm?> getSavedForm() {
    return damageFormDao.getDamageForm().then((form) => form?.toFeature());
  }

  @override
  Future<void> persistForm(DamageForm form) async {
    await damageFormDao.insertDamageForm(damageForm: form.toCompanion());
  }
}

final damageFormRepository = Provider<DamageFormRepositoryImpl>(
  (ref) => DamageFormRepositoryImpl(ref),
);
