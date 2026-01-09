//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/job_status.dart';
import 'package:openapi/src/model/queue_name.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_job_detail_response.g.dart';

/// ViewJobDetailResponse
///
/// Properties:
/// * [id]
/// * [queueName]
/// * [priority]
/// * [name]
/// * [data]
/// * [status]
/// * [retryLimit]
/// * [retryCount]
/// * [retryDelay]
/// * [retryBackoff]
/// * [startAfter]
/// * [startedAt]
/// * [singletonKey]
/// * [singletonOn]
/// * [expireIn]
/// * [createdAt]
/// * [completedAt]
/// * [keepUntil]
/// * [output]
/// * [deadLetter]
/// * [policy]
@BuiltValue()
abstract class ViewJobDetailResponse
    implements Built<ViewJobDetailResponse, ViewJobDetailResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'queueName')
  QueueName get queueName;
  // enum queueNameEnum {  system,  };

  @BuiltValueField(wireName: r'priority')
  num get priority;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'data')
  JsonObject get data;

  @BuiltValueField(wireName: r'status')
  JobStatus get status;
  // enum statusEnum {  created,  active,  completed,  retry,  failed,  cancelled,  };

  @BuiltValueField(wireName: r'retryLimit')
  num get retryLimit;

  @BuiltValueField(wireName: r'retryCount')
  num get retryCount;

  @BuiltValueField(wireName: r'retryDelay')
  num get retryDelay;

  @BuiltValueField(wireName: r'retryBackoff')
  bool get retryBackoff;

  @BuiltValueField(wireName: r'startAfter')
  DateTime get startAfter;

  @BuiltValueField(wireName: r'startedAt')
  DateTime? get startedAt;

  @BuiltValueField(wireName: r'singletonKey')
  String? get singletonKey;

  @BuiltValueField(wireName: r'singletonOn')
  DateTime? get singletonOn;

  @BuiltValueField(wireName: r'expireIn')
  JsonObject get expireIn;

  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'completedAt')
  DateTime? get completedAt;

  @BuiltValueField(wireName: r'keepUntil')
  DateTime get keepUntil;

  @BuiltValueField(wireName: r'output')
  JsonObject? get output;

  @BuiltValueField(wireName: r'deadLetter')
  String? get deadLetter;

  @BuiltValueField(wireName: r'policy')
  String? get policy;

  ViewJobDetailResponse._();

  factory ViewJobDetailResponse([
    void updates(ViewJobDetailResponseBuilder b),
  ]) = _$ViewJobDetailResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewJobDetailResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewJobDetailResponse> get serializer =>
      _$ViewJobDetailResponseSerializer();
}

class _$ViewJobDetailResponseSerializer
    implements PrimitiveSerializer<ViewJobDetailResponse> {
  @override
  final Iterable<Type> types = const [
    ViewJobDetailResponse,
    _$ViewJobDetailResponse,
  ];

  @override
  final String wireName = r'ViewJobDetailResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewJobDetailResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'queueName';
    yield serializers.serialize(
      object.queueName,
      specifiedType: const FullType(QueueName),
    );
    yield r'priority';
    yield serializers.serialize(
      object.priority,
      specifiedType: const FullType(num),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(JsonObject),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(JobStatus),
    );
    yield r'retryLimit';
    yield serializers.serialize(
      object.retryLimit,
      specifiedType: const FullType(num),
    );
    yield r'retryCount';
    yield serializers.serialize(
      object.retryCount,
      specifiedType: const FullType(num),
    );
    yield r'retryDelay';
    yield serializers.serialize(
      object.retryDelay,
      specifiedType: const FullType(num),
    );
    yield r'retryBackoff';
    yield serializers.serialize(
      object.retryBackoff,
      specifiedType: const FullType(bool),
    );
    yield r'startAfter';
    yield serializers.serialize(
      object.startAfter,
      specifiedType: const FullType(DateTime),
    );
    yield r'startedAt';
    yield object.startedAt == null
        ? null
        : serializers.serialize(
            object.startedAt,
            specifiedType: const FullType.nullable(DateTime),
          );
    yield r'singletonKey';
    yield object.singletonKey == null
        ? null
        : serializers.serialize(
            object.singletonKey,
            specifiedType: const FullType.nullable(String),
          );
    yield r'singletonOn';
    yield object.singletonOn == null
        ? null
        : serializers.serialize(
            object.singletonOn,
            specifiedType: const FullType.nullable(DateTime),
          );
    yield r'expireIn';
    yield serializers.serialize(
      object.expireIn,
      specifiedType: const FullType(JsonObject),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'completedAt';
    yield object.completedAt == null
        ? null
        : serializers.serialize(
            object.completedAt,
            specifiedType: const FullType.nullable(DateTime),
          );
    yield r'keepUntil';
    yield serializers.serialize(
      object.keepUntil,
      specifiedType: const FullType(DateTime),
    );
    yield r'output';
    yield object.output == null
        ? null
        : serializers.serialize(
            object.output,
            specifiedType: const FullType.nullable(JsonObject),
          );
    yield r'deadLetter';
    yield object.deadLetter == null
        ? null
        : serializers.serialize(
            object.deadLetter,
            specifiedType: const FullType.nullable(String),
          );
    yield r'policy';
    yield object.policy == null
        ? null
        : serializers.serialize(
            object.policy,
            specifiedType: const FullType.nullable(String),
          );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewJobDetailResponse object, {
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
    required ViewJobDetailResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.id = valueDes;
          break;
        case r'queueName':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(QueueName),
                  )
                  as QueueName;
          result.queueName = valueDes;
          break;
        case r'priority':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(num))
                  as num;
          result.priority = valueDes;
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
        case r'data':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(JsonObject),
                  )
                  as JsonObject;
          result.data = valueDes;
          break;
        case r'status':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(JobStatus),
                  )
                  as JobStatus;
          result.status = valueDes;
          break;
        case r'retryLimit':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(num))
                  as num;
          result.retryLimit = valueDes;
          break;
        case r'retryCount':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(num))
                  as num;
          result.retryCount = valueDes;
          break;
        case r'retryDelay':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(num))
                  as num;
          result.retryDelay = valueDes;
          break;
        case r'retryBackoff':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool;
          result.retryBackoff = valueDes;
          break;
        case r'startAfter':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )
                  as DateTime;
          result.startAfter = valueDes;
          break;
        case r'startedAt':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(DateTime),
                  )
                  as DateTime?;
          if (valueDes == null) continue;
          result.startedAt = valueDes;
          break;
        case r'singletonKey':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.singletonKey = valueDes;
          break;
        case r'singletonOn':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(DateTime),
                  )
                  as DateTime?;
          if (valueDes == null) continue;
          result.singletonOn = valueDes;
          break;
        case r'expireIn':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(JsonObject),
                  )
                  as JsonObject;
          result.expireIn = valueDes;
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
        case r'completedAt':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(DateTime),
                  )
                  as DateTime?;
          if (valueDes == null) continue;
          result.completedAt = valueDes;
          break;
        case r'keepUntil':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )
                  as DateTime;
          result.keepUntil = valueDes;
          break;
        case r'output':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(JsonObject),
                  )
                  as JsonObject?;
          if (valueDes == null) continue;
          result.output = valueDes;
          break;
        case r'deadLetter':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.deadLetter = valueDes;
          break;
        case r'policy':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(String),
                  )
                  as String?;
          if (valueDes == null) continue;
          result.policy = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ViewJobDetailResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewJobDetailResponseBuilder();
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
