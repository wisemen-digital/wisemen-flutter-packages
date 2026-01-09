//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_jobs_index_query_key.g.dart';

/// ViewJobsIndexQueryKey
///
/// Properties:
/// * [createdAt]
/// * [id]
@BuiltValue()
abstract class ViewJobsIndexQueryKey
    implements Built<ViewJobsIndexQueryKey, ViewJobsIndexQueryKeyBuilder> {
  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'id')
  String get id;

  ViewJobsIndexQueryKey._();

  factory ViewJobsIndexQueryKey([
    void updates(ViewJobsIndexQueryKeyBuilder b),
  ]) = _$ViewJobsIndexQueryKey;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewJobsIndexQueryKeyBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewJobsIndexQueryKey> get serializer =>
      _$ViewJobsIndexQueryKeySerializer();
}

class _$ViewJobsIndexQueryKeySerializer
    implements PrimitiveSerializer<ViewJobsIndexQueryKey> {
  @override
  final Iterable<Type> types = const [
    ViewJobsIndexQueryKey,
    _$ViewJobsIndexQueryKey,
  ];

  @override
  final String wireName = r'ViewJobsIndexQueryKey';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewJobsIndexQueryKey object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewJobsIndexQueryKey object, {
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
    required ViewJobsIndexQueryKeyBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'createdAt':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )
                  as DateTime;
          result.createdAt = valueDes;
          break;
        case r'id':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.id = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ViewJobsIndexQueryKey deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewJobsIndexQueryKeyBuilder();
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
