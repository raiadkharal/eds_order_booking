part of 'price_condition_class.dart';

PriceConditionClassModel _$PriceConditionClassFromJson(Map<String, dynamic> json) {
  return PriceConditionClassModel(
    priceConditionClassId: json['priceConditionClassId'] as int?,
    name: json['name'] as String?,
    order: json['order'] as int?,
    severityLevel: json['severityLevel'] as int?,
    severityLevelMessage: json['severityLevelMessage'] as String?,
    pricingAreaId: json['pricingAreaId'] as int?,
    pricingLevelId: json['pricingLevelId'] as int?,
    distributionId: json['distributionId'] as int?,
    organizationId: json['organizationId'] as int?,
    canLimit:json['canLimit'] as bool?,
    code: json['code'] as String?,
    deriveFromConditionClassId: json['deriveFromConditionClassId'] as int?,
  );
}

Map<String, dynamic> _$PriceConditionClassToJson(PriceConditionClassModel instance) =>
    <String, dynamic>{
      'priceConditionClassId': instance.priceConditionClassId,
      'name': instance.name,
      'order': instance.order,
      'severityLevel': instance.severityLevel,
      'severityLevelMessage': instance.severityLevelMessage,
      'pricingAreaId': instance.pricingAreaId,
      'pricingLevelId': instance.pricingLevelId,
      'distributionId': instance.distributionId,
      'organizationId': instance.organizationId,
      'canLimit':boolToInt(instance.canLimit),
      'code': instance.code,
      'deriveFromConditionClassId': instance.deriveFromConditionClassId,
    };
