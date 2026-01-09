//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_not_found_error.g.dart';

/// FileNotFoundError
///
/// Properties:
/// * [detail] - a human-readable explanation specific to this occurrence of the problem
/// * [status]
/// * [code]
@BuiltValue()
abstract class FileNotFoundError
    implements Built<FileNotFoundError, FileNotFoundErrorBuilder> {
  /// a human-readable explanation specific to this occurrence of the problem
  @BuiltValueField(wireName: r'detail')
  String? get detail;

  @BuiltValueField(wireName: r'status')
  FileNotFoundErrorStatusEnum get status;
  // enum statusEnum {  404,  };

  @BuiltValueField(wireName: r'code')
  FileNotFoundErrorCodeEnum get code;
  // enum codeEnum {  file_not_found,  };

  FileNotFoundError._();

  factory FileNotFoundError([void updates(FileNotFoundErrorBuilder b)]) =
      _$FileNotFoundError;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FileNotFoundErrorBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FileNotFoundError> get serializer =>
      _$FileNotFoundErrorSerializer();
}

class _$FileNotFoundErrorSerializer
    implements PrimitiveSerializer<FileNotFoundError> {
  @override
  final Iterable<Type> types = const [FileNotFoundError, _$FileNotFoundError];

  @override
  final String wireName = r'FileNotFoundError';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FileNotFoundError object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.detail != null) {
      yield r'detail';
      yield serializers.serialize(
        object.detail,
        specifiedType: const FullType(String),
      );
    }
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(FileNotFoundErrorStatusEnum),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(FileNotFoundErrorCodeEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FileNotFoundError object, {
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
    required FileNotFoundErrorBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'detail':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.detail = valueDes;
          break;
        case r'status':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(FileNotFoundErrorStatusEnum),
                  )
                  as FileNotFoundErrorStatusEnum;
          result.status = valueDes;
          break;
        case r'code':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(FileNotFoundErrorCodeEnum),
                  )
                  as FileNotFoundErrorCodeEnum;
          result.code = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FileNotFoundError deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FileNotFoundErrorBuilder();
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

class FileNotFoundErrorStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'404')
  static const FileNotFoundErrorStatusEnum n404 =
      _$fileNotFoundErrorStatusEnum_n404;

  static Serializer<FileNotFoundErrorStatusEnum> get serializer =>
      _$fileNotFoundErrorStatusEnumSerializer;

  const FileNotFoundErrorStatusEnum._(String name) : super(name);

  static BuiltSet<FileNotFoundErrorStatusEnum> get values =>
      _$fileNotFoundErrorStatusEnumValues;
  static FileNotFoundErrorStatusEnum valueOf(String name) =>
      _$fileNotFoundErrorStatusEnumValueOf(name);
}

class FileNotFoundErrorCodeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'file_not_found')
  static const FileNotFoundErrorCodeEnum fileNotFound =
      _$fileNotFoundErrorCodeEnum_fileNotFound;

  static Serializer<FileNotFoundErrorCodeEnum> get serializer =>
      _$fileNotFoundErrorCodeEnumSerializer;

  const FileNotFoundErrorCodeEnum._(String name) : super(name);

  static BuiltSet<FileNotFoundErrorCodeEnum> get values =>
      _$fileNotFoundErrorCodeEnumValues;
  static FileNotFoundErrorCodeEnum valueOf(String name) =>
      _$fileNotFoundErrorCodeEnumValueOf(name);
}
