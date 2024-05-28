// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carton_price_breakdown.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartonPriceBreakDown _$CartonPriceBreakDownFromJson(Map<String, dynamic> json) {
  return CartonPriceBreakDown(
    id: json['pk_cpbd'] as int?,
    orderId: json['orderId'] as int?,
    orderDetailId: json['mobileOrderDetailId'] as int?,
    priceCondition: json['priceCondition'] as String?,
    priceConditionType: json['priceConditionType'] as String?,
    priceConditionClass: json['priceConditionClass'] as String?,
    priceConditionClassOrder: json['priceConditionClassOrder'] as int?,
    priceConditionId: json['priceConditionId'] as int?,
    priceConditionDetailId: json['priceConditionDetailId'] as int?,
    accessSequence: json['accessSequence'] as String?,
    unitPrice: (json['unitPrice'] as num?)?.toDouble(),
    blockPrice: (json['blockPrice'] as num?)?.toDouble(),
    totalPrice: (json['totalPrice'] as num?)?.toDouble(),
    calculationType: json['calculationType'] as int?,
    outletId: json['outletId'] as int?,
    productId: json['productId'] as int?,
    productDefinitionId: json['productDefinitionId'] as int?,
    isMaxLimitReached: boolFromInt(json['isMaxLimitReached'] as int?),
    maximumLimit: (json['maximumLimit'] as num?)?.toDouble(),
    alreadyAvailed: (json['alreadyAvailed'] as num?)?.toDouble(),
    limitBy: json['limitBy'] as int?,
  );
}

Map<String, dynamic> _$CartonPriceBreakDownToJson(
    CartonPriceBreakDown instance) =>
    <String, dynamic>{
      'pk_cpbd': instance.id,
      'orderId': instance.orderId,
      'mobileOrderDetailId': instance.orderDetailId,
      'priceCondition': instance.priceCondition,
      'priceConditionType': instance.priceConditionType,
      'priceConditionClass': instance.priceConditionClass,
      'priceConditionClassOrder': instance.priceConditionClassOrder,
      'priceConditionId': instance.priceConditionId,
      'priceConditionDetailId': instance.priceConditionDetailId,
      'accessSequence': instance.accessSequence,
      'unitPrice': instance.unitPrice,
      'blockPrice': instance.blockPrice,
      'totalPrice': instance.totalPrice,
      'calculationType': instance.calculationType,
      'outletId': instance.outletId,
      'productId': instance.productId,
      'productDefinitionId': instance.productDefinitionId,
      'isMaxLimitReached': boolToInt(instance.isMaxLimitReached),
      'maximumLimit': instance.maximumLimit,
      'alreadyAvailed': instance.alreadyAvailed,
      'limitBy': instance.limitBy,
    };
