// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'free_price_condition_outlet_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreePriceConditionOutletAttributes _$FreePriceConditionOutletAttributesFromJson(
    Map<String, dynamic> json) =>
    FreePriceConditionOutletAttributes(
      priceConditionOutletAttributeId:
      json['priceConditionOutletAttributeId'] as int?,
      priceConditionId: json['priceConditionId'] as int?,
      channelId: json['channelId'] as int?,
      vpoClassificationId: json['vpoClassificationId'] as int?,
      outletGroupId: json['outletGroupId'] as int?,
      outletGroup2Id: json['outletGroup2Id'] as int?,
      outletGroup3Id: json['outletGroup3Id'] as int?,
      bundleId: json['bundleId'] as int?,
      freeGoodId: json['freeGoodId'] as int?,
    );

Map<String, dynamic> _$FreePriceConditionOutletAttributesToJson(
    FreePriceConditionOutletAttributes instance) =>
    <String, dynamic>{
      'priceConditionOutletAttributeId': instance.priceConditionOutletAttributeId,
      'priceConditionId': instance.priceConditionId,
      'channelId': instance.channelId,
      'vpoClassificationId': instance.vpoClassificationId,
      'outletGroupId': instance.outletGroupId,
      'outletGroup2Id': instance.outletGroup2Id,
      'outletGroup3Id': instance.outletGroup3Id,
      'bundleId': instance.bundleId,
      'freeGoodId': instance.freeGoodId,
    };
