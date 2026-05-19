import '../models/models.dart';

abstract interface class DamageFormRepository {
  Future<void> submitForm(DamageForm form);
  Future<void> persistForm(DamageForm form);
  Future<DamageForm?> getSavedForm();
}
