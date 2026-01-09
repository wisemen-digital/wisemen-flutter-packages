//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_preset.g.dart';

class NotificationPreset extends EnumClass {
  @BuiltValueEnumConst(wireName: r'all')
  static const NotificationPreset all = _$all;
  @BuiltValueEnumConst(wireName: r'default')
  static const NotificationPreset default_ = _$default_;
  @BuiltValueEnumConst(wireName: r'custom')
  static const NotificationPreset custom = _$custom;
  @BuiltValueEnumConst(wireName: r'none')
  static const NotificationPreset none = _$none;

  static Serializer<NotificationPreset> get serializer =>
      _$notificationPresetSerializer;

  const NotificationPreset._(String name) : super(name);

  static BuiltSet<NotificationPreset> get values => _$values;
  static NotificationPreset valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class NotificationPresetMixin = Object with _$NotificationPresetMixin;
