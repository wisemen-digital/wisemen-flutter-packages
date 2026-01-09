//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'global_search_collection_name.g.dart';

class GlobalSearchCollectionName extends EnumClass {
  @BuiltValueEnumConst(wireName: r'user')
  static const GlobalSearchCollectionName user = _$user;
  @BuiltValueEnumConst(wireName: r'contact')
  static const GlobalSearchCollectionName contact = _$contact;

  static Serializer<GlobalSearchCollectionName> get serializer =>
      _$globalSearchCollectionNameSerializer;

  const GlobalSearchCollectionName._(String name) : super(name);

  static BuiltSet<GlobalSearchCollectionName> get values => _$values;
  static GlobalSearchCollectionName valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class GlobalSearchCollectionNameMixin = Object
    with _$GlobalSearchCollectionNameMixin;
