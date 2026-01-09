//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/mime_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_response.g.dart';

/// FileResponse
///
/// Properties:
/// * [uuid]
/// * [name]
/// * [mimeType]
/// * [blurHash]
@BuiltValue()
abstract class FileResponse
    implements Built<FileResponse, FileResponseBuilder> {
  @BuiltValueField(wireName: r'uuid')
  String get uuid;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'mimeType')
  MimeType get mimeType;
  // enum mimeTypeEnum {  application/pdf,  application/msword,  application/vnd.openxmlformats-officedocument.wordprocessingml.document,  application/vnd.ms-powerpoint,  application/vnd.openxmlformats-officedocument.presentationml.presentation,  text/plain,  text/html,  text/csv,  image/jpeg,  image/png,  image/tiff,  image/bmp,  image/heic,  image/webp,  image/gif,  application/octet-stream,  };

  @BuiltValueField(wireName: r'blurHash')
  String? get blurHash;

  FileResponse._();

  factory FileResponse([void updates(FileResponseBuilder b)]) = _$FileResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FileResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FileResponse> get serializer => _$FileResponseSerializer();
}

class _$FileResponseSerializer implements PrimitiveSerializer<FileResponse> {
  @override
  final Iterable<Type> types = const [FileResponse, _$FileResponse];

  @override
  final String wireName = r'FileResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FileResponse object, {
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
    yield serializers.serialize(
      object.mimeType,
      specifiedType: const FullType(MimeType),
    );
    yield r'blurHash';
    yield object.blurHash == null
        ? null
        : serializers.serialize(
            object.blurHash,
            specifiedType: const FullType.nullable(String),
          );
  }

  @override
  Object serialize(
    Serializers serializers,
    FileResponse object, {
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
    required FileResponseBuilder result,
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
                    specifiedType: const FullType(MimeType),
                  )
                  as MimeType;
          result.mimeType = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FileResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FileResponseBuilder();
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
