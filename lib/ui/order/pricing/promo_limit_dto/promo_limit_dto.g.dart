// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_limit_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoLimitDTO _$PromoLimitDTOFromJson(Map<String, dynamic> json) =>
    PromoLimitDTO(
      priceConditionDetailId: json['PriceConditionDetailId'] as int,
      limitBy: json['LimitBy'] as int?,
      maximumLimit:json['MaximumLimit'] as double?,
      unitPrice: json['UnitPrice'] as double?,
    );

Map<String, dynamic> _$PromoLimitDTOToJson(PromoLimitDTO instance) =>
    <String, dynamic>{
      'PriceConditionDetailId': instance.priceConditionDetailId,
      'LimitBy': instance.limitBy,
      'MaximumLimit': instance.maximumLimit,
      'UnitPrice': instance.unitPrice,
    };
