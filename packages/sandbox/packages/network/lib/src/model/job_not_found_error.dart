//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'job_not_found_error.g.dart';

/// JobNotFoundError
///
/// Properties:
/// * [detail] - a human-readable explanation specific to this occurrence of the problem
/// * [status]
/// * [code]
@BuiltValue()
abstract class JobNotFoundError
    implements Built<JobNotFoundError, JobNotFoundErrorBuilder> {
  /// a human-readable explanation specific to this occurrence of the problem
  @BuiltValueField(wireName: r'detail')
  String? get detail;

  @BuiltValueField(wireName: r'status')
  JobNotFoundErrorStatusEnum get status;
  // enum statusEnum {  404,  };

  @BuiltValueField(wireName: r'code')
  JobNotFoundErrorCodeEnum get code;
  // enum codeEnum {  job_not_found,  };

  JobNotFoundError._();

  factory JobNotFoundError([void updates(JobNotFoundErrorBuilder b)]) =
      _$JobNotFoundError;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(JobNotFoundErrorBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<JobNotFoundError> get serializer =>
      _$JobNotFoundErrorSerializer();
}

class _$JobNotFoundErrorSerializer
    implements PrimitiveSerializer<JobNotFoundError> {
  @override
  final Iterable<Type> types = const [JobNotFoundError, _$JobNotFoundError];

  @override
  final String wireName = r'JobNotFoundError';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    JobNotFoundError object, {
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
      specifiedType: const FullType(JobNotFoundErrorStatusEnum),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(JobNotFoundErrorCodeEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    JobNotFoundError object, {
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
    required JobNotFoundErrorBuilder result,
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
                    specifiedType: const FullType(JobNotFoundErrorStatusEnum),
                  )
                  as JobNotFoundErrorStatusEnum;
          result.status = valueDes;
          break;
        case r'code':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(JobNotFoundErrorCodeEnum),
                  )
                  as JobNotFoundErrorCodeEnum;
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
  JobNotFoundError deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = JobNotFoundErrorBuilder();
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

class JobNotFoundErrorStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'404')
  static const JobNotFoundErrorStatusEnum n404 =
      _$jobNotFoundErrorStatusEnum_n404;

  static Serializer<JobNotFoundErrorStatusEnum> get serializer =>
      _$jobNotFoundErrorStatusEnumSerializer;

  const JobNotFoundErrorStatusEnum._(String name) : super(name);

  static BuiltSet<JobNotFoundErrorStatusEnum> get values =>
      _$jobNotFoundErrorStatusEnumValues;
  static JobNotFoundErrorStatusEnum valueOf(String name) =>
      _$jobNotFoundErrorStatusEnumValueOf(name);
}

class JobNotFoundErrorCodeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'job_not_found')
  static const JobNotFoundErrorCodeEnum jobNotFound =
      _$jobNotFoundErrorCodeEnum_jobNotFound;

  static Serializer<JobNotFoundErrorCodeEnum> get serializer =>
      _$jobNotFoundErrorCodeEnumSerializer;

  const JobNotFoundErrorCodeEnum._(String name) : super(name);

  static BuiltSet<JobNotFoundErrorCodeEnum> get values =>
      _$jobNotFoundErrorCodeEnumValues;
  static JobNotFoundErrorCodeEnum valueOf(String name) =>
      _$jobNotFoundErrorCodeEnumValueOf(name);
}
