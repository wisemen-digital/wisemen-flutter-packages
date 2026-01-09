//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/mime_type.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/presigned_file_variant_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'presigned_file_response.g.dart';

/// PresignedFileResponse
///
/// Properties:
/// * [uuid]
/// * [name]
/// * [mimeType]
/// * [url]
/// * [blurHash]
/// * [variants]
@BuiltValue()
abstract class PresignedFileResponse
    implements Built<PresignedFileResponse, PresignedFileResponseBuilder> {
  @BuiltValueField(wireName: r'uuid')
  String get uuid;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'mimeType')
  MimeType? get mimeType;
  // enum mimeTypeEnum {  application/pdf,  application/msword,  application/vnd.openxmlformats-officedocument.wordprocessingml.document,  application/vnd.ms-powerpoint,  application/vnd.openxmlformats-officedocument.presentationml.presentation,  text/plain,  text/html,  text/csv,  image/jpeg,  image/png,  image/tiff,  image/bmp,  image/heic,  image/webp,  image/gif,  application/octet-stream,  };

  @BuiltValueField(wireName: r'url')
  String get url;

  @BuiltValueField(wireName: r'blurHash')
  String? get blurHash;

  @BuiltValueField(wireName: r'variants')
  BuiltList<PresignedFileVariantResponse> get variants;

  PresignedFileResponse._();

  factory PresignedFileResponse([
    void updates(PresignedFileResponseBuilder b),
  ]) = _$PresignedFileResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PresignedFileResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PresignedFileResponse> get serializer =>
      _$PresignedFileResponseSerializer();
}

class _$PresignedFileResponseSerializer
    implements PrimitiveSerializer<PresignedFileResponse> {
  @override
  final Iterable<Type> types = const [
    PresignedFileResponse,
    _$PresignedFileResponse,
  ];

  @override
  final String wireName = r'PresignedFileResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PresignedFileResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'uuid';
    yield serializers.serialize(
      object.uuid,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'mimeType';
    yield object.mimeType == null
        ? null
        : serializers.serialize(
            object.mimeType,
            specifiedType: const FullType.nullable(MimeType),
          );
    yield r'url';
    yield serializers.serialize(
      object.url,
      specifiedType: const FullType(String),
    );
    yield r'blurHash';
    yield object.blurHash == null
        ? null
        : serializers.serialize(
            object.blurHash,
            specifiedType: const FullType.nullable(String),
          );
    yield r'variants';
    yield serializers.serialize(
      object.variants,
      specifiedType: const FullType(BuiltList, [
        FullType(PresignedFileVariantResponse),
      ]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PresignedFileResponse object, {
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
    required PresignedFileResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'uuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.uuid = valueDes;
          break;
        case r'name':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.name = valueDes;
          break;
        case r'mimeType':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(MimeType),
                  )
                  as MimeType?;
          if (valueDes == null) continue;
          result.mimeType = valueDes;
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
        case r'blurHash':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.blurHash = valueDes;
          break;
        case r'variants':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(PresignedFileVariantResponse),
                    ]),
                  )
                  as BuiltList<PresignedFileVariantResponse>;
          result.variants.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PresignedFileResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PresignedFileResponseBuilder();
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
