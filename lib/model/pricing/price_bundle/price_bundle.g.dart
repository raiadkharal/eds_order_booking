// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_bundle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceBundle _$PriceBundleFromJson(Map<String, dynamic> json) {
  return PriceBundle(
    bundleId: json['bundleId'] as int,
    name: json['name'] as String?,
    validFrom: json['validFrom'] as String?,
    validTo: json['validTo'] as String?,
    entityGroupById: json['entityGroupById'] as int?,
    bundleMinimumQuantity: json['bundleMinimumQuantity'] as int?,
    isDeleted: json['isDeleted'] as bool?,
    priceConditionId: json['priceConditionId'] as int?,
  );
}

Map<String, dynamic> _$PriceBundleToJson(PriceBundle instance) =>
    <String, dynamic>{
      'bundleId': instance.bundleId,
      'name': instance.name,
      'validFrom': instance.validFrom,
      'validTo': instance.validTo,
      'entityGroupById': instance.entityGroupById,
      'bundleMinimumQuantity': instance.bundleMinimumQuantity,
      'isDeleted':boolToInt(instance.isDeleted),
      'priceConditionId': instance.priceConditionId,
    };
