// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_condition_entities_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceConditionEntitiesModel _$PriceConditionEntitiesFromJson(
    Map<String, dynamic> json) {
  return PriceConditionEntitiesModel(
    priceConditionEntityId: json['priceConditionEntityId'] as int,
    priceConditionId: json['priceConditionId'] as int,
    outletId: json['outletId'] as int?,
    routeId: json['routeId'] as int?,
    distributionId: json['distributionId'] as int?,
    bundleId: json['bundleId'] as int?,
    isDeleted: json['isDeleted'] as bool?,
  );
}

Map<String, dynamic> _$PriceConditionEntitiesToJson(
    PriceConditionEntitiesModel instance) =>
    <String, dynamic>{
      'priceConditionEntityId': instance.priceConditionEntityId,
      'priceConditionId': instance.priceConditionId,
      'outletId': instance.outletId,
      'routeId': instance.routeId,
      'distributionId': instance.distributionId,
      'bundleId': instance.bundleId,
      'isDeleted': boolToInt(instance.isDeleted),
    };
