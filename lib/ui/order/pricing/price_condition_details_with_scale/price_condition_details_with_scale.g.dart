// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_condition_details_with_scale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceConditionDetailsWithScale _$PriceConditionDetailsWithScaleFromJson(
    Map<String, dynamic> json) {
  return PriceConditionDetailsWithScale(
    priceConditionDetail: json['priceConditionDetail'] == null
        ? null
        : PriceConditionDetail.fromJson(
        json['priceConditionDetail'] as Map<String, dynamic>),
    priceConditionScaleList: (json['priceConditionScaleList'] as List)
        .map((e) => e == null
        ? null
        : PriceConditionScale.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PriceConditionDetailsWithScaleToJson(
    PriceConditionDetailsWithScale instance) =>
    <String, dynamic>{
      'priceConditionDetail': instance.priceConditionDetail?.toJson(),
      'priceConditionScaleList':
      instance.priceConditionScaleList?.map((e) => e?.toJson()).toList(),
    };
