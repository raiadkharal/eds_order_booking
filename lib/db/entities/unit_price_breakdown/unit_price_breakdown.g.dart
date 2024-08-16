// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_price_breakdown.dart';

UnitPriceBreakDown _$UnitPriceBreakDownFromJson(Map<String, dynamic> json) {
  return UnitPriceBreakDown(
    id: json['pk_upbd'] as int?,
    orderId: json['orderId'] as int?,
    orderDetailId: json['mobileOrderDetailId'] as int?,
    priceCondition: json['priceCondition'] as String?,
    priceConditionType: json['priceConditionType'] as String?,
    priceConditionClass: json['priceConditionClass'] as String?,
    priceConditionClassOrder: json['priceConditionClassOrder'] as int?,
    priceConditionClassId: json['priceConditionClassId'] as int?,
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
    isMaxLimitReached: (json['isMaxLimitReached'] is int)? boolFromInt(json['isMaxLimitReached'] as int?): (json['isMaxLimitReached'] as bool?),
    maximumLimit: (json['maximumLimit'] as num?)?.toDouble(),
    alreadyAvailed: (json['alreadyAvailed'] as num?)?.toDouble(),
    limitBy: json['limitBy'] as int?,
  );
}

Map<String, dynamic> _$UnitPriceBreakDownToJson(UnitPriceBreakDown instance) =>
    <String, dynamic>{
      'pk_upbd': instance.id,
      'orderId': instance.orderId,
      'mobileOrderDetailId': instance.orderDetailId,
      'priceCondition': instance.priceCondition,
      'priceConditionType': instance.priceConditionType,
      'priceConditionClass': instance.priceConditionClass,
      'priceConditionClassOrder': instance.priceConditionClassOrder,
      'priceConditionClassId': instance.priceConditionClassId,
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
