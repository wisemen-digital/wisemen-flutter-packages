//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/locale.dart';
import 'package:openapi/src/model/font_size.dart';
import 'package:openapi/src/model/ui_theme.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_ui_preferences_response.g.dart';

/// ViewUiPreferencesResponse
///
/// Properties:
/// * [theme]
/// * [language]
/// * [fontSize]
/// * [showShortcuts]
/// * [reduceMotion]
/// * [highContrast]
@BuiltValue()
abstract class ViewUiPreferencesResponse
    implements
        Built<ViewUiPreferencesResponse, ViewUiPreferencesResponseBuilder> {
  @BuiltValueField(wireName: r'theme')
  UITheme get theme;
  // enum themeEnum {  light,  dark,  system,  };

  @BuiltValueField(wireName: r'language')
  Locale get language;
  // enum languageEnum {  en-US,  nl-BE,  };

  @BuiltValueField(wireName: r'fontSize')
  FontSize get fontSize;
  // enum fontSizeEnum {  smaller,  small,  default,  large,  larger,  };

  @BuiltValueField(wireName: r'showShortcuts')
  bool get showShortcuts;

  @BuiltValueField(wireName: r'reduceMotion')
  bool get reduceMotion;

  @BuiltValueField(wireName: r'highContrast')
  bool get highContrast;

  ViewUiPreferencesResponse._();

  factory ViewUiPreferencesResponse([
    void updates(ViewUiPreferencesResponseBuilder b),
  ]) = _$ViewUiPreferencesResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewUiPreferencesResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewUiPreferencesResponse> get serializer =>
      _$ViewUiPreferencesResponseSerializer();
}

class _$ViewUiPreferencesResponseSerializer
    implements PrimitiveSerializer<ViewUiPreferencesResponse> {
  @override
  final Iterable<Type> types = const [
    ViewUiPreferencesResponse,
    _$ViewUiPreferencesResponse,
  ];

  @override
  final String wireName = r'ViewUiPreferencesResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewUiPreferencesResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'theme';
    yield serializers.serialize(
      object.theme,
      specifiedType: const FullType(UITheme),
    );
    yield r'language';
    yield serializers.serialize(
      object.language,
      specifiedType: const FullType(Locale),
    );
    yield r'fontSize';
    yield serializers.serialize(
      object.fontSize,
      specifiedType: const FullType(FontSize),
    );
    yield r'showShortcuts';
    yield serializers.serialize(
      object.showShortcuts,
      specifiedType: const FullType(bool),
    );
    yield r'reduceMotion';
    yield serializers.serialize(
      object.reduceMotion,
      specifiedType: const FullType(bool),
    );
    yield r'highContrast';
    yield serializers.serialize(
      object.highContrast,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewUiPreferencesResponse object, {
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
    required ViewUiPreferencesResponseBuilder result,
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
  ViewUiPreferencesResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewUiPreferencesResponseBuilder();
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
