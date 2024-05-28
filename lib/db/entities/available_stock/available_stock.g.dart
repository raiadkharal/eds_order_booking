// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableStock _$AvailableStockFromJson(Map<String, dynamic> json) =>
    AvailableStock(
      avlStockId: json['mobileAvlStockDetailId'] as int,
      productId: json['productId'] as int?,
      packageId: json['packageId'] as int?,
      unitProductDefinitionId: json['unitProductDefinitionId'] as int?,
      cartonProductDefinitionId: json['cartonProductDefinitionId'] as int?,
      mOrderId: json['orderId'] as int?,
      outletId: json['outletId'] as int?,
      cartonQuantity: json['cartonQuantity'] as int,
      unitQuantity: json['unitQuantity'] as int,
    );

Map<String, dynamic> _$AvailableStockToJson(AvailableStock instance) =>
    <String, dynamic>{
      'mobileAvlStockDetailId': instance.avlStockId,
      'productId': instance.productId,
      'packageId': instance.packageId,
      'unitProductDefinitionId': instance.unitProductDefinitionId,
      'cartonProductDefinitionId': instance.cartonProductDefinitionId,
      'orderId': instance.mOrderId,
      'outletId': instance.outletId,
      'cartonQuantity': instance.cartonQuantity,
      'unitQuantity': instance.unitQuantity,
    };
