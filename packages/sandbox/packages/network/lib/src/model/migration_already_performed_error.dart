//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/migration_already_performed_error_meta.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'migration_already_performed_error.g.dart';

/// MigrationAlreadyPerformedError
///
/// Properties:
/// * [detail] - a human-readable explanation specific to this occurrence of the problem
/// * [status]
/// * [code]
/// * [meta] - a meta object containing non-standard meta-information about the error
@BuiltValue()
abstract class MigrationAlreadyPerformedError
    implements
        Built<
          MigrationAlreadyPerformedError,
          MigrationAlreadyPerformedErrorBuilder
        > {
  /// a human-readable explanation specific to this occurrence of the problem
  @BuiltValueField(wireName: r'detail')
  String? get detail;

  @BuiltValueField(wireName: r'status')
  MigrationAlreadyPerformedErrorStatusEnum get status;
  // enum statusEnum {  400,  };

  @BuiltValueField(wireName: r'code')
  MigrationAlreadyPerformedErrorCodeEnum get code;
  // enum codeEnum {  migration_already_performed,  };

  /// a meta object containing non-standard meta-information about the error
  @BuiltValueField(wireName: r'meta')
  MigrationAlreadyPerformedErrorMeta get meta;

  MigrationAlreadyPerformedError._();

  factory MigrationAlreadyPerformedError([
    void updates(MigrationAlreadyPerformedErrorBuilder b),
  ]) = _$MigrationAlreadyPerformedError;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MigrationAlreadyPerformedErrorBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MigrationAlreadyPerformedError> get serializer =>
      _$MigrationAlreadyPerformedErrorSerializer();
}

class _$MigrationAlreadyPerformedErrorSerializer
    implements PrimitiveSerializer<MigrationAlreadyPerformedError> {
  @override
  final Iterable<Type> types = const [
    MigrationAlreadyPerformedError,
    _$MigrationAlreadyPerformedError,
  ];

  @override
  final String wireName = r'MigrationAlreadyPerformedError';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MigrationAlreadyPerformedError object, {
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
      specifiedType: const FullType(MigrationAlreadyPerformedErrorStatusEnum),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(MigrationAlreadyPerformedErrorCodeEnum),
    );
    yield r'meta';
    yield serializers.serialize(
      object.meta,
      specifiedType: const FullType(MigrationAlreadyPerformedErrorMeta),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MigrationAlreadyPerformedError object, {
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
    required MigrationAlreadyPerformedErrorBuilder result,
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
                    specifiedType: const FullType(
                      MigrationAlreadyPerformedErrorStatusEnum,
                    ),
                  )
                  as MigrationAlreadyPerformedErrorStatusEnum;
          result.status = valueDes;
          break;
        case r'code':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(
                      MigrationAlreadyPerformedErrorCodeEnum,
                    ),
                  )
                  as MigrationAlreadyPerformedErrorCodeEnum;
          result.code = valueDes;
          break;
        case r'meta':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(
                      MigrationAlreadyPerformedErrorMeta,
                    ),
                  )
                  as MigrationAlreadyPerformedErrorMeta;
          result.meta.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MigrationAlreadyPerformedError deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MigrationAlreadyPerformedErrorBuilder();
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

class MigrationAlreadyPerformedErrorStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'400')
  static const MigrationAlreadyPerformedErrorStatusEnum n400 =
      _$migrationAlreadyPerformedErrorStatusEnum_n400;

  static Serializer<MigrationAlreadyPerformedErrorStatusEnum> get serializer =>
      _$migrationAlreadyPerformedErrorStatusEnumSerializer;

  const MigrationAlreadyPerformedErrorStatusEnum._(String name) : super(name);

  static BuiltSet<MigrationAlreadyPerformedErrorStatusEnum> get values =>
      _$migrationAlreadyPerformedErrorStatusEnumValues;
  static MigrationAlreadyPerformedErrorStatusEnum valueOf(String name) =>
      _$migrationAlreadyPerformedErrorStatusEnumValueOf(name);
}

class MigrationAlreadyPerformedErrorCodeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'migration_already_performed')
  static const MigrationAlreadyPerformedErrorCodeEnum
  migrationAlreadyPerformed =
      _$migrationAlreadyPerformedErrorCodeEnum_migrationAlreadyPerformed;

  static Serializer<MigrationAlreadyPerformedErrorCodeEnum> get serializer =>
      _$migrationAlreadyPerformedErrorCodeEnumSerializer;

  const MigrationAlreadyPerformedErrorCodeEnum._(String name) : super(name);

  static BuiltSet<MigrationAlreadyPerformedErrorCodeEnum> get values =>
      _$migrationAlreadyPerformedErrorCodeEnumValues;
  static MigrationAlreadyPerformedErrorCodeEnum valueOf(String name) =>
      _$migrationAlreadyPerformedErrorCodeEnumValueOf(name);
}
