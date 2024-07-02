// This file is manually generated. You should not edit it directly.
// See price_condition_model.dart for details.

part of 'price_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceCondition _$PriceConditionFromJson(Map<String, dynamic> json) =>
    PriceCondition(
      priceConditionId: json['priceConditionId'] as int,
      name: json['name'] as String,
      priceConditionTypeId: json['priceConditionTypeId'] as int,
      accessSequenceId: json['accessSequenceId'] as int,
      isBundle: boolFromInt(json['isBundle'] as int?),
      pricingType: json['pricingType'] as int?,
      validFrom: json['validFrom'] as String?,
      validTo: json['validTo'] as String?,
      entityGroupById: json['entityGroupById'] as int?,
      organizationId: json['organizationId'] as int?,
      distributionId: json['distributionId'] as int?,
      combinedMaxValueLimit: json['combinedMaxValueLimit'] as double?,
      combinedMaxCaseLimit: json['combinedMaxCaseLimit'] as double?,
      combinedLimitBy: json['combinedLimitBy'] as int?,
      customerRegistrationTypeId: json['customerRegistrationTypeId'] as int?,
    );

Map<String, dynamic> _$PriceConditionToJson(PriceCondition instance) =>
    <String, dynamic>{
      'priceConditionId': instance.priceConditionId,
      'accessSequenceId': instance.accessSequenceId,
      'priceConditionTypeId': instance.priceConditionTypeId,
      'name': instance.name,
      'isBundle': boolToInt(instance.isBundle),
      'pricingType': instance.pricingType,
      'validFrom': instance.validFrom,
      'validTo': instance.validTo,
      'entityGroupById': instance.entityGroupById,
      'organizationId': instance.organizationId,
      'distributionId': instance.distributionId,
      'combinedMaxValueLimit': instance.combinedMaxValueLimit,
      'combinedMaxCaseLimit': instance.combinedMaxCaseLimit,
      'combinedLimitBy': instance.combinedLimitBy,
      'customerRegistrationTypeId': instance.customerRegistrationTypeId,
    };
