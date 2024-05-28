// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outlet_availed_promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutletAvailedPromotion _$OutletAvailedPromotionFromJson(
    Map<String, dynamic> json) {
  return OutletAvailedPromotion(
    id: json['id'] as int?,
    outletId: json['outletId'] as int?,
    priceConditionId: json['priceConditionId'] as int?,
    priceConditionDetailId: json['priceConditionDetailId'] as int?,
    quantity: json['quantity'] as int?,
    amount: (json['amount'] as num?)?.toDouble(),
    productId: json['productId'] as int?,
    productDefinitionId: json['productDefinitionId'] as int?,
    packageId: json['packageId'] as int?,
  );
}

Map<String, dynamic> _$OutletAvailedPromotionToJson(
    OutletAvailedPromotion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'outletId': instance.outletId,
      'priceConditionId': instance.priceConditionId,
      'priceConditionDetailId': instance.priceConditionDetailId,
      'quantity': instance.quantity,
      'amount': instance.amount,
      'productId': instance.productId,
      'productDefinitionId': instance.productDefinitionId,
      'packageId': instance.packageId,
    };
