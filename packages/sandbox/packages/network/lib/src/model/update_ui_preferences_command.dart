//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/locale.dart';
import 'package:openapi/src/model/font_size.dart';
import 'package:openapi/src/model/ui_theme.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_ui_preferences_command.g.dart';

/// UpdateUiPreferencesCommand
///
/// Properties:
/// * [theme]
/// * [language]
/// * [fontSize]
/// * [showShortcuts]
/// * [reduceMotion]
/// * [highContrast]
@BuiltValue()
abstract class UpdateUiPreferencesCommand
    implements
        Built<UpdateUiPreferencesCommand, UpdateUiPreferencesCommandBuilder> {
  @BuiltValueField(wireName: r'theme')
  UITheme? get theme;
  // enum themeEnum {  light,  dark,  system,  };

  @BuiltValueField(wireName: r'language')
  Locale? get language;
  // enum languageEnum {  en-US,  nl-BE,  };

  @BuiltValueField(wireName: r'fontSize')
  FontSize? get fontSize;
  // enum fontSizeEnum {  smaller,  small,  default,  large,  larger,  };

  @BuiltValueField(wireName: r'showShortcuts')
  bool? get showShortcuts;

  @BuiltValueField(wireName: r'reduceMotion')
  bool? get reduceMotion;

  @BuiltValueField(wireName: r'highContrast')
  bool? get highContrast;

  UpdateUiPreferencesCommand._();

  factory UpdateUiPreferencesCommand([
    void updates(UpdateUiPreferencesCommandBuilder b),
  ]) = _$UpdateUiPreferencesCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateUiPreferencesCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateUiPreferencesCommand> get serializer =>
      _$UpdateUiPreferencesCommandSerializer();
}

class _$UpdateUiPreferencesCommandSerializer
    implements PrimitiveSerializer<UpdateUiPreferencesCommand> {
  @override
  final Iterable<Type> types = const [
    UpdateUiPreferencesCommand,
    _$UpdateUiPreferencesCommand,
  ];

  @override
  final String wireName = r'UpdateUiPreferencesCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateUiPreferencesCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.theme != null) {
      yield r'theme';
      yield serializers.serialize(
        object.theme,
        specifiedType: const FullType(UITheme),
      );
    }
    if (object.language != null) {
      yield r'language';
      yield serializers.serialize(
        object.language,
        specifiedType: const FullType(Locale),
      );
    }
    if (object.fontSize != null) {
      yield r'fontSize';
      yield serializers.serialize(
        object.fontSize,
        specifiedType: const FullType(FontSize),
      );
    }
    if (object.showShortcuts != null) {
      yield r'showShortcuts';
      yield serializers.serialize(
        object.showShortcuts,
        specifiedType: const FullType(bool),
      );
    }
    if (object.reduceMotion != null) {
      yield r'reduceMotion';
      yield serializers.serialize(
        object.reduceMotion,
        specifiedType: const FullType(bool),
      );
    }
    if (object.highContrast != null) {
      yield r'highContrast';
      yield serializers.serialize(
        object.highContrast,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateUiPreferencesCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(
      serializers,
      object,
      specifiedType: specifiedType,
    ).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateUiPreferencesCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'theme':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(UITheme),
                  )
                  as UITheme;
          result.theme = valueDes;
          break;
        case r'language':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(Locale),
                  )
                  as Locale;
          result.language = valueDes;
          break;
        case r'fontSize':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(FontSize),
                  )
                  as FontSize;
          result.fontSize = valueDes;
          break;
        case r'showShortcuts':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool;
          result.showShortcuts = valueDes;
          break;
        case r'reduceMotion':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool;
          result.reduceMotion = valueDes;
          break;
        case r'highContrast':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool;
          result.highContrast = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateUiPreferencesCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateUiPreferencesCommandBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
