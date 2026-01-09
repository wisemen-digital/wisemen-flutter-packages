//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'typesense_collection_name.g.dart';

class TypesenseCollectionName extends EnumClass {
  @BuiltValueEnumConst(wireName: r'user')
  static const TypesenseCollectionName user = _$user;
  @BuiltValueEnumConst(wireName: r'contact')
  static const TypesenseCollectionName contact = _$contact;

  static Serializer<TypesenseCollectionName> get serializer =>
      _$typesenseCollectionNameSerializer;

  const TypesenseCollectionName._(String name) : super(name);

  static BuiltSet<TypesenseCollectionName> get values => _$values;
  static TypesenseCollectionName valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TypesenseCollectionNameMixin = Object
    with _$TypesenseCollectionNameMixin;
