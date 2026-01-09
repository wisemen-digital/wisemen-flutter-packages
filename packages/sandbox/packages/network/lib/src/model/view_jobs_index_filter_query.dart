//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/queue_name.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_jobs_index_filter_query.g.dart';

/// ViewJobsIndexFilterQuery
///
/// Properties:
/// * [queueNames]
/// * [archived]
@BuiltValue()
abstract class ViewJobsIndexFilterQuery
    implements
        Built<ViewJobsIndexFilterQuery, ViewJobsIndexFilterQueryBuilder> {
  @BuiltValueField(wireName: r'queueNames')
  BuiltList<QueueName>? get queueNames;

  @BuiltValueField(wireName: r'archived')
  bool? get archived;

  ViewJobsIndexFilterQuery._();

  factory ViewJobsIndexFilterQuery([
    void updates(ViewJobsIndexFilterQueryBuilder b),
  ]) = _$ViewJobsIndexFilterQuery;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewJobsIndexFilterQueryBuilder b) =>
      b..archived = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewJobsIndexFilterQuery> get serializer =>
      _$ViewJobsIndexFilterQuerySerializer();
}

class _$ViewJobsIndexFilterQuerySerializer
    implements PrimitiveSerializer<ViewJobsIndexFilterQuery> {
  @override
  final Iterable<Type> types = const [
    ViewJobsIndexFilterQuery,
    _$ViewJobsIndexFilterQuery,
  ];

  @override
  final String wireName = r'ViewJobsIndexFilterQuery';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewJobsIndexFilterQuery object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.queueNames != null) {
      yield r'queueNames';
      yield serializers.serialize(
        object.queueNames,
        specifiedType: const FullType(BuiltList, [FullType(QueueName)]),
      );
    }
    if (object.archived != null) {
      yield r'archived';
      yield serializers.serialize(
        object.archived,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewJobsIndexFilterQuery object, {
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
    required ViewJobsIndexFilterQueryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'queueNames':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(QueueName),
                    ]),
                  )
                  as BuiltList<QueueName>;
          result.queueNames.replace(valueDes);
          break;
        case r'archived':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool;
          result.archived = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ViewJobsIndexFilterQuery deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewJobsIndexFilterQueryBuilder();
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
