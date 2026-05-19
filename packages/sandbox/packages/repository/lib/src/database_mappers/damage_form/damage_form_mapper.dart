import 'package:database/database.dart';
import 'package:sandbox/features/damage_form/models/models.dart';

extension DamageFormMapper on DamageFormObject {
  DamageForm toFeature() {
    return DamageForm(
      date: date,
      description: description,
      price: price,
    );
  }
}

extension DamageFormCompanionMapper on DamageForm {
  DamageFormTableCompanion toCompanion() {
    return DamageFormTableCompanion(
      id: const Value(damageFormId),
      date: Value(date),
      description: Value(description),
      price: Value(price),
    );
  }
}
