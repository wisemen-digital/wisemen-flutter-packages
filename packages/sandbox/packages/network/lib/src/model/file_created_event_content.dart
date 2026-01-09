//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_created_event_content.g.dart';

/// FileCreatedEventContent
///
/// Properties:
/// * [fileUuid]
/// * [fileName]
@BuiltValue()
abstract class FileCreatedEventContent
    implements Built<FileCreatedEventContent, FileCreatedEventContentBuilder> {
  @BuiltValueField(wireName: r'fileUuid')
  String get fileUuid;

  @BuiltValueField(wireName: r'fileName')
  String get fileName;

  FileCreatedEventContent._();

  factory FileCreatedEventContent([
    void updates(FileCreatedEventContentBuilder b),
  ]) = _$FileCreatedEventContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FileCreatedEventContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FileCreatedEventContent> get serializer =>
      _$FileCreatedEventContentSerializer();
}

class _$FileCreatedEventContentSerializer
    implements PrimitiveSerializer<FileCreatedEventContent> {
  @override
  final Iterable<Type> types = const [
    FileCreatedEventContent,
    _$FileCreatedEventContent,
  ];

  @override
  final String wireName = r'FileCreatedEventContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FileCreatedEventContent object, {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    FileCreatedEventContent object, {
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
    required FileCreatedEventContentBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FileCreatedEventContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FileCreatedEventContentBuilder();
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
