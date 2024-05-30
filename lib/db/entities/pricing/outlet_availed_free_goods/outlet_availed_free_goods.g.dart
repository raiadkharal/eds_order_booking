// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outlet_availed_free_goods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutletAvailedFreeGoods _$OutletAvailedFreeGoodsFromJson(
    Map<String, dynamic> json) =>
    OutletAvailedFreeGoods(
      id: json['id'] as int?,
      outletId: json['outletId'] as int?,
      freeGoodGroupId: json['freeGoodGroupId'] as int?,
      freeGoodDetailId: json['freeGoodDetailId'] as int?,
      freeGoodExclusiveId: json['freeGoodExclusiveId'] as int?,
      quantity: json['quantity'] as int?,
      productId: json['productId'] as int?,
      productDefinitionId: json['productDefinitionId'] as int?,
      orderId: json['orderId'] as int?,
      invoiceId: json['invoiceId'] as int?,
    );

Map<String, dynamic> _$OutletAvailedFreeGoodsToJson(
    OutletAvailedFreeGoods instance) =>
    <String, dynamic>{
      'id': instance.id,
      'outletId': instance.outletId,
      'freeGoodGroupId': instance.freeGoodGroupId,
      'freeGoodDetailId': instance.freeGoodDetailId,
      'freeGoodExclusiveId': instance.freeGoodExclusiveId,
      'quantity': instance.quantity,
      'productId': instance.productId,
      'productDefinitionId': instance.productDefinitionId,
      'orderId': instance.orderId,
      'invoiceId': instance.invoiceId,
    };
