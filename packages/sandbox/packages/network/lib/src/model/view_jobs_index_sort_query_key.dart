//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_jobs_index_sort_query_key.g.dart';

class ViewJobsIndexSortQueryKey extends EnumClass {
  @BuiltValueEnumConst(wireName: r'createdAt')
  static const ViewJobsIndexSortQueryKey createdAt = _$createdAt;

  static Serializer<ViewJobsIndexSortQueryKey> get serializer =>
      _$viewJobsIndexSortQueryKeySerializer;

  const ViewJobsIndexSortQueryKey._(String name) : super(name);

  static BuiltSet<ViewJobsIndexSortQueryKey> get values => _$values;
  static ViewJobsIndexSortQueryKey valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ViewJobsIndexSortQueryKeyMixin = Object
    with _$ViewJobsIndexSortQueryKeyMixin;
