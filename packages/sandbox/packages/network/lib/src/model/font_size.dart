//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'font_size.g.dart';

class FontSize extends EnumClass {
  @BuiltValueEnumConst(wireName: r'smaller')
  static const FontSize smaller = _$smaller;
  @BuiltValueEnumConst(wireName: r'small')
  static const FontSize small = _$small;
  @BuiltValueEnumConst(wireName: r'default')
  static const FontSize default_ = _$default_;
  @BuiltValueEnumConst(wireName: r'large')
  static const FontSize large = _$large;
  @BuiltValueEnumConst(wireName: r'larger')
  static const FontSize larger = _$larger;

  static Serializer<FontSize> get serializer => _$fontSizeSerializer;

  const FontSize._(String name) : super(name);

  static BuiltSet<FontSize> get values => _$values;
  static FontSize valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class FontSizeMixin = Object with _$FontSizeMixin;
