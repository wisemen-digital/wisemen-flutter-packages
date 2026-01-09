//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/currency.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'monetary_dto.g.dart';

/// MonetaryDto
///
/// Properties:
/// * [amount]
/// * [currency] - a ISO 4217 currency code
/// * [precision]
@BuiltValue()
abstract class MonetaryDto implements Built<MonetaryDto, MonetaryDtoBuilder> {
  @BuiltValueField(wireName: r'amount')
  int get amount;

  /// a ISO 4217 currency code
  @BuiltValueField(wireName: r'currency')
  Currency get currency;
  // enum currencyEnum {  AFN,  EUR,  ALL,  DZD,  USD,  AOA,  XCD,  ARS,  AMD,  AWG,  AUD,  AZN,  BSD,  BHD,  BDT,  BBD,  BYN,  BZD,  XOF,  BMD,  INR,  BTN,  BOB,  BOV,  BAM,  BWP,  NOK,  BRL,  BND,  BGN,  BIF,  CVE,  KHR,  XAF,  CAD,  KYD,  CLP,  CLF,  CNY,  COP,  COU,  KMF,  CDF,  NZD,  CRC,  CUP,  ANG,  CZK,  DKK,  DJF,  DOP,  EGP,  SVC,  ERN,  SZL,  ETB,  FKP,  FJD,  XPF,  GMD,  GEL,  GHS,  GIP,  GTQ,  GBP,  GNF,  GYD,  HTG,  HNL,  HKD,  HUF,  ISK,  IDR,  XDR,  IRR,  IQD,  ILS,  JMD,  JPY,  JOD,  KZT,  KES,  KPW,  KRW,  KWD,  KGS,  LAK,  LBP,  LSL,  ZAR,  LRD,  LYD,  CHF,  MOP,  MKD,  MGA,  MWK,  MYR,  MVR,  MRU,  MUR,  XUA,  MXN,  MXV,  MDL,  MNT,  MAD,  MZN,  MMK,  NAD,  NPR,  NIO,  NGN,  OMR,  PKR,  PAB,  PGK,  PYG,  PEN,  PHP,  PLN,  QAR,  RON,  RUB,  RWF,  SHP,  WST,  STN,  SAR,  RSD,  SCR,  SLE,  SGD,  XSU,  SBD,  SOS,  SSP,  LKR,  SDG,  SRD,  SEK,  CHE,  CHW,  SYP,  TWD,  TJS,  TZS,  THB,  TOP,  TTD,  TND,  TRY,  TMT,  UGX,  UAH,  AED,  USN,  UYU,  UYI,  UYW,  UZS,  VUV,  VES,  VED,  VND,  YER,  ZMW,  ZWG,  XBA,  XBB,  XBC,  XBD,  XTS,  XXX,  XAU,  XPD,  XPT,  XAG,  };

  @BuiltValueField(wireName: r'precision')
  int get precision;

  MonetaryDto._();

  factory MonetaryDto([void updates(MonetaryDtoBuilder b)]) = _$MonetaryDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MonetaryDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MonetaryDto> get serializer => _$MonetaryDtoSerializer();
}

class _$MonetaryDtoSerializer implements PrimitiveSerializer<MonetaryDto> {
  @override
  final Iterable<Type> types = const [MonetaryDto, _$MonetaryDto];

  @override
  final String wireName = r'MonetaryDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MonetaryDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(int),
    );
    yield r'currency';
    yield serializers.serialize(
      object.currency,
      specifiedType: const FullType(Currency),
    );
    yield r'precision';
    yield serializers.serialize(
      object.precision,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MonetaryDto object, {
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
    required MonetaryDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'amount':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int;
          result.amount = valueDes;
          break;
        case r'currency':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(Currency),
                  )
                  as Currency;
          result.currency = valueDes;
          break;
        case r'precision':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int;
          result.precision = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MonetaryDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MonetaryDtoBuilder();
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
