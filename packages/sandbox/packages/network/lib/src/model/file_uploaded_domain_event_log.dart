//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/subject_type.dart';
import 'package:openapi/src/model/file_uploaded_event_content.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_uploaded_domain_event_log.g.dart';

/// FileUploadedDomainEventLog
///
/// Properties:
/// * [uuid]
/// * [createdAt]
/// * [version]
/// * [source_]
/// * [userUuid]
/// * [message]
/// * [subjectType]
/// * [subjectId]
/// * [type]
/// * [content]
@BuiltValue()
abstract class FileUploadedDomainEventLog
    implements
        Built<FileUploadedDomainEventLog, FileUploadedDomainEventLogBuilder> {
  @BuiltValueField(wireName: r'uuid')
  String get uuid;

  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'version')
  int get version;

  @BuiltValueField(wireName: r'source')
  String get source_;

  @BuiltValueField(wireName: r'userUuid')
  String? get userUuid;

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'subjectType')
  SubjectType? get subjectType;
  // enum subjectTypeEnum {  contact,  file,  role,  user,  };

  @BuiltValueField(wireName: r'subjectId')
  String? get subjectId;

  @BuiltValueField(wireName: r'type')
  FileUploadedDomainEventLogTypeEnum get type;
  // enum typeEnum {  file.uploaded,  };

  @BuiltValueField(wireName: r'content')
  FileUploadedEventContent get content;

  FileUploadedDomainEventLog._();

  factory FileUploadedDomainEventLog([
    void updates(FileUploadedDomainEventLogBuilder b),
  ]) = _$FileUploadedDomainEventLog;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FileUploadedDomainEventLogBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FileUploadedDomainEventLog> get serializer =>
      _$FileUploadedDomainEventLogSerializer();
}

class _$FileUploadedDomainEventLogSerializer
    implements PrimitiveSerializer<FileUploadedDomainEventLog> {
  @override
  final Iterable<Type> types = const [
    FileUploadedDomainEventLog,
    _$FileUploadedDomainEventLog,
  ];

  @override
  final String wireName = r'FileUploadedDomainEventLog';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FileUploadedDomainEventLog object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'uuid';
    yield serializers.serialize(
      object.uuid,
      specifiedType: const FullType(String),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(int),
    );
    yield r'source';
    yield serializers.serialize(
      object.source_,
      specifiedType: const FullType(String),
    );
    yield r'userUuid';
    yield object.userUuid == null
        ? null
        : serializers.serialize(
            object.userUuid,
            specifiedType: const FullType.nullable(String),
          );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'subjectType';
    yield object.subjectType == null
        ? null
        : serializers.serialize(
            object.subjectType,
            specifiedType: const FullType.nullable(SubjectType),
          );
    yield r'subjectId';
    yield object.subjectId == null
        ? null
        : serializers.serialize(
            object.subjectId,
            specifiedType: const FullType.nullable(String),
          );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(FileUploadedDomainEventLogTypeEnum),
    );
    yield r'content';
    yield serializers.serialize(
      object.content,
      specifiedType: const FullType(FileUploadedEventContent),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FileUploadedDomainEventLog object, {
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
    required FileUploadedDomainEventLogBuilder result,
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
        case r'createdAt':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )
                  as DateTime;
          result.createdAt = valueDes;
          break;
        case r'version':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int;
          result.version = valueDes;
          break;
        case r'source':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.source_ = valueDes;
          break;
        case r'userUuid':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.userUuid = valueDes;
          break;
        case r'message':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.message = valueDes;
          break;
        case r'subjectType':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(SubjectType),
                  )
                  as SubjectType?;
          if (valueDes == null) continue;
          result.subjectType = valueDes;
          break;
        case r'subjectId':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.subjectId = valueDes;
          break;
        case r'type':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(
                      FileUploadedDomainEventLogTypeEnum,
                    ),
                  )
                  as FileUploadedDomainEventLogTypeEnum;
          result.type = valueDes;
          break;
        case r'content':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(FileUploadedEventContent),
                  )
                  as FileUploadedEventContent;
          result.content.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FileUploadedDomainEventLog deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FileUploadedDomainEventLogBuilder();
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

class FileUploadedDomainEventLogTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'file.uploaded')
  static const FileUploadedDomainEventLogTypeEnum filePeriodUploaded =
      _$fileUploadedDomainEventLogTypeEnum_filePeriodUploaded;

  static Serializer<FileUploadedDomainEventLogTypeEnum> get serializer =>
      _$fileUploadedDomainEventLogTypeEnumSerializer;

  const FileUploadedDomainEventLogTypeEnum._(String name) : super(name);

  static BuiltSet<FileUploadedDomainEventLogTypeEnum> get values =>
      _$fileUploadedDomainEventLogTypeEnumValues;
  static FileUploadedDomainEventLogTypeEnum valueOf(String name) =>
      _$fileUploadedDomainEventLogTypeEnumValueOf(name);
}
