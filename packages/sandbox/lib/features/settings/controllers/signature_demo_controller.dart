import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../../shared/shared.dart';

part 'signature_demo_controller.g.dart';

/// Submits the demo signature; the state holds the previewed result.
@riverpod
class SignatureDemoController extends _$SignatureDemoController {
  @override
  FutureOr<SigningResult?> build() {
    listenSelf((previous, next) => ErrorUtils.showAsyncError(next));
    return null;
  }

  /// Validates and captures [signing]; null after field validation errors.
  Future<void> submit(SigningController signing) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(signing.submit);
  }

  /// Hides the preview once the input changes.
  void discard() {
    state = const AsyncData(null);
  }
}
