//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/mime_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_file_command.g.dart';

/// CreateFileCommand
///
/// Properties:
/// * [name]
/// * [mimeType]
@BuiltValue()
abstract class CreateFileCommand
    implements Built<CreateFileCommand, CreateFileCommandBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'mimeType')
  MimeType get mimeType;
  // enum mimeTypeEnum {  application/pdf,  application/msword,  application/vnd.openxmlformats-officedocument.wordprocessingml.document,  application/vnd.ms-powerpoint,  application/vnd.openxmlformats-officedocument.presentationml.presentation,  text/plain,  text/html,  text/csv,  image/jpeg,  image/png,  image/tiff,  image/bmp,  image/heic,  image/webp,  image/gif,  application/octet-stream,  };

  CreateFileCommand._();

  factory CreateFileCommand([void updates(CreateFileCommandBuilder b)]) =
      _$CreateFileCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateFileCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateFileCommand> get serializer =>
      _$CreateFileCommandSerializer();
}

class _$CreateFileCommandSerializer
    implements PrimitiveSerializer<CreateFileCommand> {
  @override
  final Iterable<Type> types = const [CreateFileCommand, _$CreateFileCommand];

  @override
  final String wireName = r'CreateFileCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateFileCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateFileCommand object, {
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
    required CreateFileCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateFileCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateFileCommandBuilder();
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
