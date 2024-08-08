
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_condtition_with_access_sequence.dart';

PriceConditionWithAccessSequence _$PriceConditionWithAccessSequenceFromJson(
    Map<String, dynamic> json) {
  return PriceConditionWithAccessSequence(
    priceConditionTypeId: json['priceConditionTypeId'] as int?,
    accessSequenceId: json['accessSequenceId'] as int?,
    priceConditionId: json['priceConditionId'] as int?,
    name: json['name'] as String?,
    sequenceCode: json['sequenceCode'] as String?,
    sequenceName: json['sequenceName'] as String?,
    priceAccessSequenceId: json['priceAccessSequenceId'] as int?,
    order: json['order'] as int?,
    pricingLevelId: json['pricingLevelId'] as int?,
    accessSequenceName: json['accessSequenceName'] as String?,
    accessSequenceCode: json['accessSequenceCode'] as String?,
    accessSequenceOrder: json['accessSequenceOrder'] as int?,
    conditionTypeId: json['conditionTypeId'] as int?,
    ChannelAttributeCount: json['ChannelAttributeCount'] as int? ?? 0,
    OutletChannelAttribute: json['OutletChannelAttribute'] as int? ?? 0,
    GroupAttributeCount: json['GroupAttributeCount'] as int? ?? 0,
    OutletGroupAttribute: json['OutletGroupAttribute'] as int? ?? 0,
    VPOClassificationAttributeCount:
    json['VPOClassificationAttributeCount'] as int? ?? 0,
    OutletVPOClassificationAttributeCount:
    json['OutletVPOClassificationAttributeCount'] as int? ?? 0,
    bundleId: json['bundleId'] as int?,
  );
}

Map<String, dynamic> _$PriceConditionWithAccessSequenceToJson(
    PriceConditionWithAccessSequence instance) =>
    <String, dynamic>{
      'priceConditionTypeId': instance.priceConditionTypeId,
      'accessSequenceId': instance.accessSequenceId,
      'priceConditionId': instance.priceConditionId,
      'name': instance.name,
      'sequenceCode': instance.sequenceCode,
      'sequenceName': instance.sequenceName,
      'priceAccessSequenceId': instance.priceAccessSequenceId,
      'order': instance.order,
      'pricingLevelId': instance.pricingLevelId,
      'accessSequenceName': instance.accessSequenceName,
      'accessSequenceCode': instance.accessSequenceCode,
      'accessSequenceOrder': instance.accessSequenceOrder,
      'conditionTypeId': instance.conditionTypeId,
      'ChannelAttributeCount': instance.ChannelAttributeCount,
      'OutletChannelAttribute': instance.OutletChannelAttribute,
      'GroupAttributeCount': instance.GroupAttributeCount,
      'OutletGroupAttribute': instance.OutletGroupAttribute,
      'VPOClassificationAttributeCount':
      instance.VPOClassificationAttributeCount,
      'OutletVPOClassificationAttributeCount':
      instance.OutletVPOClassificationAttributeCount,
      'bundleId': instance.bundleId,
    };
