//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'confirm_file_upload_command.g.dart';

/// ConfirmFileUploadCommand
///
/// Properties:
/// * [blurHash]
@BuiltValue()
abstract class ConfirmFileUploadCommand
    implements
        Built<ConfirmFileUploadCommand, ConfirmFileUploadCommandBuilder> {
  @BuiltValueField(wireName: r'blurHash')
  String? get blurHash;

  ConfirmFileUploadCommand._();

  factory ConfirmFileUploadCommand([
    void updates(ConfirmFileUploadCommandBuilder b),
  ]) = _$ConfirmFileUploadCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConfirmFileUploadCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ConfirmFileUploadCommand> get serializer =>
      _$ConfirmFileUploadCommandSerializer();
}

class _$ConfirmFileUploadCommandSerializer
    implements PrimitiveSerializer<ConfirmFileUploadCommand> {
  @override
  final Iterable<Type> types = const [
    ConfirmFileUploadCommand,
    _$ConfirmFileUploadCommand,
  ];

  @override
  final String wireName = r'ConfirmFileUploadCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ConfirmFileUploadCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    ConfirmFileUploadCommand object, {
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
    required ConfirmFileUploadCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  ConfirmFileUploadCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConfirmFileUploadCommandBuilder();
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
