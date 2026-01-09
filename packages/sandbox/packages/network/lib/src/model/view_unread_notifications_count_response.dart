//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'view_unread_notifications_count_response.g.dart';

/// ViewUnreadNotificationsCountResponse
///
/// Properties:
/// * [amount]
/// * [exceedsLimit]
@BuiltValue()
abstract class ViewUnreadNotificationsCountResponse
    implements
        Built<
          ViewUnreadNotificationsCountResponse,
          ViewUnreadNotificationsCountResponseBuilder
        > {
  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'exceedsLimit')
  bool get exceedsLimit;

  ViewUnreadNotificationsCountResponse._();

  factory ViewUnreadNotificationsCountResponse([
    void updates(ViewUnreadNotificationsCountResponseBuilder b),
  ]) = _$ViewUnreadNotificationsCountResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViewUnreadNotificationsCountResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViewUnreadNotificationsCountResponse> get serializer =>
      _$ViewUnreadNotificationsCountResponseSerializer();
}

class _$ViewUnreadNotificationsCountResponseSerializer
    implements PrimitiveSerializer<ViewUnreadNotificationsCountResponse> {
  @override
  final Iterable<Type> types = const [
    ViewUnreadNotificationsCountResponse,
    _$ViewUnreadNotificationsCountResponse,
  ];

  @override
  final String wireName = r'ViewUnreadNotificationsCountResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViewUnreadNotificationsCountResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(num),
    );
    yield r'exceedsLimit';
    yield serializers.serialize(
      object.exceedsLimit,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ViewUnreadNotificationsCountResponse object, {
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
    required ViewUnreadNotificationsCountResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'amount':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(num))
                  as num;
          result.amount = valueDes;
          break;
        case r'exceedsLimit':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool;
          result.exceedsLimit = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ViewUnreadNotificationsCountResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViewUnreadNotificationsCountResponseBuilder();
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
