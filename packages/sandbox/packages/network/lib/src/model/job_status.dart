//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'job_status.g.dart';

class JobStatus extends EnumClass {
  @BuiltValueEnumConst(wireName: r'created')
  static const JobStatus created = _$created;
  @BuiltValueEnumConst(wireName: r'active')
  static const JobStatus active = _$active;
  @BuiltValueEnumConst(wireName: r'completed')
  static const JobStatus completed = _$completed;
  @BuiltValueEnumConst(wireName: r'retry')
  static const JobStatus retry = _$retry;
  @BuiltValueEnumConst(wireName: r'failed')
  static const JobStatus failed = _$failed;
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const JobStatus cancelled = _$cancelled;

  static Serializer<JobStatus> get serializer => _$jobStatusSerializer;

  const JobStatus._(String name) : super(name);

  static BuiltSet<JobStatus> get values => _$values;
  static JobStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class JobStatusMixin = Object with _$JobStatusMixin;
