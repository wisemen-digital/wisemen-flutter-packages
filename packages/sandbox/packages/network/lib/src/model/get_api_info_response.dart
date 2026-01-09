//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_api_info_response.g.dart';

/// GetApiInfoResponse
///
/// Properties:
/// * [environment]
/// * [commit] - Commit SHA of the current build
/// * [version] - Version of the current build
/// * [timestamp] - Timestamp of the current build
@BuiltValue()
abstract class GetApiInfoResponse
    implements Built<GetApiInfoResponse, GetApiInfoResponseBuilder> {
  @BuiltValueField(wireName: r'environment')
  String get environment;

  /// Commit SHA of the current build
  @BuiltValueField(wireName: r'commit')
  String get commit;

  /// Version of the current build
  @BuiltValueField(wireName: r'version')
  String get version;

  /// Timestamp of the current build
  @BuiltValueField(wireName: r'timestamp')
  DateTime get timestamp;

  GetApiInfoResponse._();

  factory GetApiInfoResponse([void updates(GetApiInfoResponseBuilder b)]) =
      _$GetApiInfoResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetApiInfoResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetApiInfoResponse> get serializer =>
      _$GetApiInfoResponseSerializer();
}

class _$GetApiInfoResponseSerializer
    implements PrimitiveSerializer<GetApiInfoResponse> {
  @override
  final Iterable<Type> types = const [GetApiInfoResponse, _$GetApiInfoResponse];

  @override
  final String wireName = r'GetApiInfoResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetApiInfoResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(String),
    );
    yield r'commit';
    yield serializers.serialize(
      object.commit,
      specifiedType: const FullType(String),
    );
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(String),
    );
    yield r'timestamp';
    yield serializers.serialize(
      object.timestamp,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetApiInfoResponse object, {
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
    required GetApiInfoResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'environment':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.environment = valueDes;
          break;
        case r'commit':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.commit = valueDes;
          break;
        case r'version':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.version = valueDes;
          break;
        case r'timestamp':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )
                  as DateTime;
          result.timestamp = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetApiInfoResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetApiInfoResponseBuilder();
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
