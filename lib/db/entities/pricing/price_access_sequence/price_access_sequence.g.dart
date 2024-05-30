// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_access_sequence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceAccessSequence _$PriceAccessSequenceFromJson(
    Map<String, dynamic> json) =>
    PriceAccessSequence(
      priceAccessSequenceId: json['priceAccessSequenceId'] as int,
      sequenceCode: json['sequenceCode'] as String?,
      sequenceName: json['sequenceName'] as String?,
      order: json['order'] as int,
      pricingLevelId: json['pricingLevelId'] as int?,
      pricingTypeId: json['pricingTypeId'] as int?,
    );

Map<String, dynamic> _$PriceAccessSequenceToJson(
    PriceAccessSequence instance) =>
    <String, dynamic>{
      'priceAccessSequenceId': instance.priceAccessSequenceId,
      'sequenceCode': instance.sequenceCode,
      'sequenceName': instance.sequenceName,
      'order': instance.order,
      'pricingLevelId': instance.pricingLevelId,
      'pricingTypeId': instance.pricingTypeId,
    };
