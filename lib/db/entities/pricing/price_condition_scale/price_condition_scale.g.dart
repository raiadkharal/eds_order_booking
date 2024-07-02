part of 'price_condition_scale.dart';

PriceConditionScale _$PriceConditionScaleFromJson(Map<String, dynamic> json) {
  return PriceConditionScale(
    priceConditionScaleId: json['priceConditionScaleId'] as int,
    from: json['from'] as double?,
    amount: json['amount'] as double?,
    priceConditionDetailId: json['priceConditionDetailId'] as int?,
    cartonAmount: json['cartonAmount'] as double?,
  );
}

Map<String, dynamic> _$PriceConditionScaleToJson(
    PriceConditionScale instance) =>
    <String, dynamic>{
      'priceConditionScaleId': instance.priceConditionScaleId,
      'from': instance.from,
      'amount': instance.amount,
      'priceConditionDetailId': instance.priceConditionDetailId,
      'cartonAmount': instance.cartonAmount,
    };
