part of 'price_condition_type.dart';

PriceConditionType _$PriceConditionTypeFromJson(Map<String, dynamic> json) {
  return PriceConditionType(
    priceConditionTypeId: json['priceConditionTypeId'] as int,
    name: json['name'] as String?,
    priceConditionClassId: json['priceConditionClassId'] as int,
    operationType: json['operationType'] as int,
    calculationType: json['calculationType'] as int,
    roundingRule: json['roundingRule'] as int,
    priceScaleBasisId: json['priceScaleBasisId'] as int?,
    code: json['code'] as String?,
    conditionClassId: json['conditionClassId'] as int?,
    pricingType: json['pricingType'] as int?,
    processingOrder: json['processingOrder'] as int?,
    pcDefinitionLevelId: json['pcDefinitionLevelId'] as int?,
    isPromo: boolFromInt(json['isPromo'] as int?),
    isLRB: boolFromInt(json['isLRB'] as int?),
  );
}

Map<String, dynamic> _$PriceConditionTypeToJson(PriceConditionType instance) =>
    <String, dynamic>{
      'priceConditionTypeId': instance.priceConditionTypeId,
      'name': instance.name,
      'priceConditionClassId': instance.conditionClassId,
      'operationType': instance.operationType,
      'calculationType': instance.calculationType,
      'roundingRule': instance.roundingRule,
      'priceScaleBasisId': instance.priceScaleBasisId,
      'code': instance.code,
      'conditionClassId': instance.conditionClassId,
      'pricingType': instance.pricingType,
      'processingOrder': instance.processingOrder,
      'pcDefinitionLevelId': instance.pcDefinitionLevelId,
      'isPromo': boolToInt(instance.isPromo),
      'isLRB': boolToInt(instance.isLRB),
    };
