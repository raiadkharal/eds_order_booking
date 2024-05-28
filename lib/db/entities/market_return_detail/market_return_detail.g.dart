// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_return_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketReturnDetail _$MarketReturnDetailFromJson(Map<String, dynamic> json) {
  return MarketReturnDetail(
    returnId: json['return_id'] as int?,
    outletId: json['outletId'] as int?,
    productId: json['productId'] as int?,
    unitDefinitionId: json['unitDefinitionId'] as int?,
    cartonDefinitionId: json['cartonDefinitionId'] as int?,
    replacementProductId: json['replacementProductId'] as int?,
    replacementUnitDefinitionId: json['replacementUnitDefinitionId'] as int?,
    replacementCartonDefinitionId:
    json['replacementCartonDefinitionId'] as int?,
    marketReturnReasonId: json['marketReturnReasonId'] as int?,
    invoiceId: json['invoiceId'] as int?,
    cartonQuantity: json['cartonQuantity'] as int?,
    unitQuantity: json['unitQuantity'] as int?,
    replaceWith: json['replaceWith'] as String?,
    replacementCartonQuantity: json['replacementCartonQuantity'] as int?,
    replacementUnitQuantity: json['replacementUnitQuantity'] as int?,
    cartonSize: json['cartonSize'] as int?,
    replacementCartonSize: json['replacementCartonSize'] as int?,
  );
}

Map<String, dynamic> _$MarketReturnDetailToJson(
    MarketReturnDetail instance) =>
    <String, dynamic>{
      'return_id': instance.returnId,
      'outletId': instance.outletId,
      'productId': instance.productId,
      'unitDefinitionId': instance.unitDefinitionId,
      'cartonDefinitionId': instance.cartonDefinitionId,
      'replacementProductId': instance.replacementProductId,
      'replacementUnitDefinitionId': instance.replacementUnitDefinitionId,
      'replacementCartonDefinitionId': instance.replacementCartonDefinitionId,
      'marketReturnReasonId': instance.marketReturnReasonId,
      'invoiceId': instance.invoiceId,
      'cartonQuantity': instance.cartonQuantity,
      'unitQuantity': instance.unitQuantity,
      'replaceWith': instance.replaceWith,
      'replacementCartonQuantity': instance.replacementCartonQuantity,
      'replacementUnitQuantity': instance.replacementUnitQuantity,
      'cartonSize': instance.cartonSize,
      'replacementCartonSize': instance.replacementCartonSize,
    };
