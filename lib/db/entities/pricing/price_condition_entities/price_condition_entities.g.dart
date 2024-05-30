// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_condition_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceConditionEntities _$PriceConditionEntitiesFromJson(
    Map<String, dynamic> json) {
  return PriceConditionEntities(
    priceConditionEntityId: json['priceConditionEntityId'] as int,
    priceConditionId: json['priceConditionId'] as int,
    outletId: json['outletId'] as int?,
    routeId: json['routeId'] as int?,
    distributionId: json['distributionId'] as int?,
    bundleId: json['bundleId'] as int?,
    isDeleted: boolFromInt(json['isDeleted'] as int?),
  );
}

Map<String, dynamic> _$PriceConditionEntitiesToJson(
    PriceConditionEntities instance) =>
    <String, dynamic>{
      'priceConditionEntityId': instance.priceConditionEntityId,
      'priceConditionId': instance.priceConditionId,
      'outletId': instance.outletId,
      'routeId': instance.routeId,
      'distributionId': instance.distributionId,
      'bundleId': instance.bundleId,
      'isDeleted': boolToInt(instance.isDeleted),
    };
