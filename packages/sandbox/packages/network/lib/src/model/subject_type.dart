//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'subject_type.g.dart';

class SubjectType extends EnumClass {
  @BuiltValueEnumConst(wireName: r'contact')
  static const SubjectType contact = _$contact;
  @BuiltValueEnumConst(wireName: r'file')
  static const SubjectType file = _$file;
  @BuiltValueEnumConst(wireName: r'role')
  static const SubjectType role = _$role;
  @BuiltValueEnumConst(wireName: r'user')
  static const SubjectType user = _$user;

  static Serializer<SubjectType> get serializer => _$subjectTypeSerializer;

  const SubjectType._(String name) : super(name);

  static BuiltSet<SubjectType> get values => _$values;
  static SubjectType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class SubjectTypeMixin = Object with _$SubjectTypeMixin;
