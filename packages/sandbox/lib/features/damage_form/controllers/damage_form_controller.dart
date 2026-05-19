import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sandbox/features/shared/shared.dart';

import '../damage_form.dart';

part 'damage_form_controller.g.dart';

@Riverpod(keepAlive: true)
class DamageFormController extends _$DamageFormController {
  @override
  FutureOr<dynamic> build() async {
    listenSelf(
      (previous, next) {
        if (next.hasError && !next.isLoading) {
          ErrorUtils.showAsyncError(next);
        }
      },
    );
    return null;
  }

  Future<void> submitForm() async {
    state = const AsyncLoading();
    try {
      final form = ref.read(DamageFormProviders.model);
      ErrorUtils.showDialog(title: form.date.toString(), message: form.description);
      await ref.read(DamageFormFeature.damageFormRepository).submitForm(form);
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
