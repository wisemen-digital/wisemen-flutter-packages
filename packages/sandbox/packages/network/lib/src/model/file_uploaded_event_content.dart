//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_uploaded_event_content.g.dart';

/// FileUploadedEventContent
///
/// Properties:
/// * [fileUuid]
/// * [fileName]
/// * [blurHash]
@BuiltValue()
abstract class FileUploadedEventContent
    implements
        Built<FileUploadedEventContent, FileUploadedEventContentBuilder> {
  @BuiltValueField(wireName: r'fileUuid')
  String get fileUuid;

  @BuiltValueField(wireName: r'fileName')
  String get fileName;

  @BuiltValueField(wireName: r'blurHash')
  String? get blurHash;

  FileUploadedEventContent._();

  factory FileUploadedEventContent([
    void updates(FileUploadedEventContentBuilder b),
  ]) = _$FileUploadedEventContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FileUploadedEventContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FileUploadedEventContent> get serializer =>
      _$FileUploadedEventContentSerializer();
}

class _$FileUploadedEventContentSerializer
    implements PrimitiveSerializer<FileUploadedEventContent> {
  @override
  final Iterable<Type> types = const [
    FileUploadedEventContent,
    _$FileUploadedEventContent,
  ];

  @override
  final String wireName = r'FileUploadedEventContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FileUploadedEventContent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'fileUuid';
    yield serializers.serialize(
      object.fileUuid,
      specifiedType: const FullType(String),
    );
    yield r'fileName';
    yield serializers.serialize(
      object.fileName,
      specifiedType: const FullType(String),
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
    FileUploadedEventContent object, {
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
    required FileUploadedEventContentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'fileUuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.fileUuid = valueDes;
          break;
        case r'fileName':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.fileName = valueDes;
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
  FileUploadedEventContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FileUploadedEventContentBuilder();
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
