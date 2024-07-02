// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_groups.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricingGroups _$PricingGroupsFromJson(Map<String, dynamic> json) => PricingGroups(
  pricingGroupId: json['pricingGroupId'] as int?,
  pricingGroupName: json['pricingGroupName'] as String?,
  status: boolFromInt(json['status'] as int?),
);

Map<String, dynamic> _$PricingGroupsToJson(PricingGroups instance) =>
    <String, dynamic>{
      'pricingGroupId': instance.pricingGroupId,
      'pricingGroupName': instance.pricingGroupName,
      'status': boolToInt(instance.status),
    };
