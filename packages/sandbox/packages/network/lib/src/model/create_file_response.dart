//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/mime_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_file_response.g.dart';

/// CreateFileResponse
///
/// Properties:
/// * [uuid]
/// * [name]
/// * [mimeType]
/// * [uploadUrl]
@BuiltValue()
abstract class CreateFileResponse
    implements Built<CreateFileResponse, CreateFileResponseBuilder> {
  @BuiltValueField(wireName: r'uuid')
  String get uuid;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'mimeType')
  MimeType? get mimeType;
  // enum mimeTypeEnum {  application/pdf,  application/msword,  application/vnd.openxmlformats-officedocument.wordprocessingml.document,  application/vnd.ms-powerpoint,  application/vnd.openxmlformats-officedocument.presentationml.presentation,  text/plain,  text/html,  text/csv,  image/jpeg,  image/png,  image/tiff,  image/bmp,  image/heic,  image/webp,  image/gif,  application/octet-stream,  };

  @BuiltValueField(wireName: r'uploadUrl')
  String get uploadUrl;

  CreateFileResponse._();

  factory CreateFileResponse([void updates(CreateFileResponseBuilder b)]) =
      _$CreateFileResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateFileResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateFileResponse> get serializer =>
      _$CreateFileResponseSerializer();
}

class _$CreateFileResponseSerializer
    implements PrimitiveSerializer<CreateFileResponse> {
  @override
  final Iterable<Type> types = const [CreateFileResponse, _$CreateFileResponse];

  @override
  final String wireName = r'CreateFileResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateFileResponse object, {
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
    yield r'uploadUrl';
    yield serializers.serialize(
      object.uploadUrl,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateFileResponse object, {
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
    required CreateFileResponseBuilder result,
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
        case r'uploadUrl':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.uploadUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateFileResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateFileResponseBuilder();
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
