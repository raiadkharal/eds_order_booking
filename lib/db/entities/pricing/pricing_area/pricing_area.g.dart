// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricingArea _$PricingAreaFromJson(Map<String, dynamic> json) => PricingArea(
  pricingAreaId: json['PricingAreaId'] as int,
  code: json['Code'] as String,
  order: json['Order'] as int?,
  name: json['Name'] as String?,
  isActive: boolFromInt(json['IsActive'] as int?),
);

Map<String, dynamic> _$PricingAreaToJson(PricingArea instance) =>
    <String, dynamic>{
      'PricingAreaId': instance.pricingAreaId,
      'Code': instance.code,
      'Order': instance.order,
      'Name': instance.name,
      'IsActive': boolToInt(instance.isActive),
    };
