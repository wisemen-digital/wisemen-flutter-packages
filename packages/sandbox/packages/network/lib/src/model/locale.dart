//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'locale.g.dart';

class Locale extends EnumClass {
  @BuiltValueEnumConst(wireName: r'en-US')
  static const Locale enUS = _$enUS;
  @BuiltValueEnumConst(wireName: r'nl-BE')
  static const Locale nlBE = _$nlBE;

  static Serializer<Locale> get serializer => _$localeSerializer;

  const Locale._(String name) : super(name);

  static BuiltSet<Locale> get values => _$values;
  static Locale valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class LocaleMixin = Object with _$LocaleMixin;
