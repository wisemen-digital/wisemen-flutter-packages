import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sandbox/features/job_interview/utils/names_list.dart';

part 'job_interview_providers.g.dart';

class JobInterviewProviders {
  static var items = jobInterviewItemsProvider;
}

List<String> _initialItems = List.generate(15, (_) => names[Random().nextInt(names.length)]);

@riverpod
class JobInterviewItems extends _$JobInterviewItems {
  @override
  List<String> build() {
    return List.from(_initialItems);
  }

  void addItem() {
    state = [...state, names[Random().nextInt(names.length)]];
  }

  void deleteItem(String item) {
    state = state.where((i) => i != item).toList();
  }

  void clearAll() {
    state = [];
  }

  void reset() {
    state = List.from(_initialItems);
  }
}
