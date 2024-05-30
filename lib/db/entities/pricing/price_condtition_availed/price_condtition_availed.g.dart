// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_condtition_availed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceConditionAvailed _$PriceConditionAvailedFromJson(
    Map<String, dynamic> json) {
  return PriceConditionAvailed(
    priceConditionAvailedId: json['priceConditionAvailedId'] as int,
    outletId: json['outletId'] as int,
    productDefinitionId: json['productDefinitionId'] as int,
    productId: json['productId'] as int,
    amount: (json['amount'] as num?)?.toDouble(),
    quantity: json['quantity'] as int?,
  );
}

Map<String, dynamic> _$PriceConditionAvailedToJson(
    PriceConditionAvailed instance) =>
    <String, dynamic>{
      'priceConditionAvailedId': instance.priceConditionAvailedId,
      'outletId': instance.outletId,
      'productDefinitionId': instance.productDefinitionId,
      'productId': instance.productId,
      'amount': instance.amount,
      'quantity': instance.quantity,
    };
