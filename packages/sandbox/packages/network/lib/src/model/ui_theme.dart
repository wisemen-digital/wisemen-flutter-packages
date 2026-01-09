//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ui_theme.g.dart';

class UITheme extends EnumClass {
  @BuiltValueEnumConst(wireName: r'light')
  static const UITheme light = _$light;
  @BuiltValueEnumConst(wireName: r'dark')
  static const UITheme dark = _$dark;
  @BuiltValueEnumConst(wireName: r'system')
  static const UITheme system = _$system;

  static Serializer<UITheme> get serializer => _$uIThemeSerializer;

  const UITheme._(String name) : super(name);

  static BuiltSet<UITheme> get values => _$values;
  static UITheme valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class UIThemeMixin = Object with _$UIThemeMixin;
