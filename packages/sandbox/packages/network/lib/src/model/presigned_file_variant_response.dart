//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'presigned_file_variant_response.g.dart';

/// PresignedFileVariantResponse
///
/// Properties:
/// * [label]
/// * [url]
@BuiltValue()
abstract class PresignedFileVariantResponse
    implements
        Built<
          PresignedFileVariantResponse,
          PresignedFileVariantResponseBuilder
        > {
  @BuiltValueField(wireName: r'label')
  String get label;

  @BuiltValueField(wireName: r'url')
  String get url;

  PresignedFileVariantResponse._();

  factory PresignedFileVariantResponse([
    void updates(PresignedFileVariantResponseBuilder b),
  ]) = _$PresignedFileVariantResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PresignedFileVariantResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PresignedFileVariantResponse> get serializer =>
      _$PresignedFileVariantResponseSerializer();
}

class _$PresignedFileVariantResponseSerializer
    implements PrimitiveSerializer<PresignedFileVariantResponse> {
  @override
  final Iterable<Type> types = const [
    PresignedFileVariantResponse,
    _$PresignedFileVariantResponse,
  ];

  @override
  final String wireName = r'PresignedFileVariantResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PresignedFileVariantResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'label';
    yield serializers.serialize(
      object.label,
      specifiedType: const FullType(String),
    );
    yield r'url';
    yield serializers.serialize(
      object.url,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PresignedFileVariantResponse object, {
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
    required PresignedFileVariantResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'label':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.label = valueDes;
          break;
        case r'url':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.url = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PresignedFileVariantResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PresignedFileVariantResponseBuilder();
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
