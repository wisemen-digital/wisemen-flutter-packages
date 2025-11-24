import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_providers.g.dart';

/// Provider that tracks whether an optional update dialog has been shown in the current session.
/// This prevents showing the same optional update multiple times.
@Riverpod(keepAlive: true)
class HasShownUpdate extends _$HasShownUpdate {
  @override
  bool build() {
    return false;
  }

  /// Updates the state to indicate whether the update dialog has been shown.
  // ignore: use_setters_to_change_properties, avoid_positional_boolean_parameters
  void changeValue(bool value) {
    state = value;
  }
}
