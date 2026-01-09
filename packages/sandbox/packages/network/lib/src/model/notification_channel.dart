//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_channel.g.dart';

class NotificationChannel extends EnumClass {
  @BuiltValueEnumConst(wireName: r'email')
  static const NotificationChannel email = _$email;
  @BuiltValueEnumConst(wireName: r'sms')
  static const NotificationChannel sms = _$sms;
  @BuiltValueEnumConst(wireName: r'app')
  static const NotificationChannel app = _$app;
  @BuiltValueEnumConst(wireName: r'push')
  static const NotificationChannel push = _$push;

  static Serializer<NotificationChannel> get serializer =>
      _$notificationChannelSerializer;

  const NotificationChannel._(String name) : super(name);

  static BuiltSet<NotificationChannel> get values => _$values;
  static NotificationChannel valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class NotificationChannelMixin = Object
    with _$NotificationChannelMixin;
