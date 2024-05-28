// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

Promotion _$PromotionFromJson(Map<String, dynamic> json) {
  return Promotion(
    promotionId: json['promotionId'] as int?,
    outletId: json['outletId'] as int?,
    priceConditionId: json['priceConditionId'] as int?,
    detailId: json['detailId'] as int?,
    name: json['name'] as String?,
    amount: (json['amount'] as num?)?.toDouble(),
    calculationType: json['calculationType'] as String?,
    freeGoodId: json['freeGoodId'] as int?,
    freeGoodName: json['freeGoodName'] as String?,
    freeGoodSize: json['freeGoodSize'] as String?,
    size: json['size'] as String?,
    promoOrFreeGoodType: json['promoOrFreeGoodType'] as String?,
    freeGoodQuantity: json['freeGoodQuantity'] as int?,
  );
}

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
  'promotionId': instance.promotionId,
  'outletId': instance.outletId,
  'priceConditionId': instance.priceConditionId,
  'detailId': instance.detailId,
  'name': instance.name,
  'amount': instance.amount,
  'calculationType': instance.calculationType,
  'freeGoodId': instance.freeGoodId,
  'freeGoodName': instance.freeGoodName,
  'freeGoodSize': instance.freeGoodSize,
  'size': instance.size,
  'promoOrFreeGoodType': instance.promoOrFreeGoodType,
  'freeGoodQuantity': instance.freeGoodQuantity,
};
