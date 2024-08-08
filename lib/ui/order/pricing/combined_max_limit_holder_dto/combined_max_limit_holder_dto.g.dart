// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combined_max_limit_holder_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CombinedMaxLimitHolderDTO _$CombinedMaxLimitHolderDTOFromJson(Map<String, dynamic> json) =>
    CombinedMaxLimitHolderDTO(
      priceConditionId: json['priceConditionId'] as int?,
      packageId: json['packageId'] as int?,
      availedAmount: (json['availedAmount'] as num?)?.toDouble(),
      availedQuantity: json['availedQuantity'] as int?,
      isPriceConditionAppliedForTheFirstItem: json['isPriceConditionAppliedForTheFirstItem'] as bool?,
    );

Map<String, dynamic> _$CombinedMaxLimitHolderDTOToJson(CombinedMaxLimitHolderDTO instance) =>
    <String, dynamic>{
      'priceConditionId': instance.priceConditionId,
      'packageId': instance.packageId,
      'availedAmount': instance.availedAmount,
      'availedQuantity': instance.availedQuantity,
      'isPriceConditionAppliedForTheFirstItem': instance.isPriceConditionAppliedForTheFirstItem,
    };
