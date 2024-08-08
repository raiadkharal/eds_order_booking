// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailModel _$OrderDetailFromJson(Map<String, dynamic> json) {
  return OrderDetailModel()
    ..orderDetailId = json['pk_modid'] as int?
    ..mLocalOrderId = json['mobileOrderId'] as int?
    ..mOrderId = json['orderId'] as int?
    ..mProductId = json['productId'] as int?
    ..packageId = json['packageId'] as int?
    ..mUnitOrderDetailId = json['unitOrderDetailId'] as int?
    ..mCartonOrderDetailId = json['cartonOrderDetailId'] as int?
    ..mProductGroupId = json['productGroupId'] as int?
    ..unitFreeGoodGroupId = json['unitFreeGoodGroupId'] as int?
    ..cartonFreeGoodGroupId = json['cartonFreeGoodGroupId'] as int?
    ..unitFreeGoodDetailId = json['unitFreeGoodDetailId'] as int?
    ..cartonFreeGoodDetailId = json['cartonFreeGoodDetailId'] as int?
    ..mProductName = json['productName'] as String?
    ..mCartonQuantity = json['cartonQuantity'] as int?
    ..mUnitQuantity = json['unitQuantity'] as int?
    ..avlUnitQuantity = json['avlUnitQuantity'] as int?
    ..avlCartonQuantity = json['avlCartonQuantity'] as int?
    ..unitDefinitionId = json['unitDefinitionId'] as int?
    ..cartonDefinitionId = json['cartonDefinitionId'] as int?
    ..actualUnitStock = json['actualUnitStock'] as int?
    ..actualCartonStock = json['actualCartonStock'] as int?
    ..cartonSize = json['cartonSize'] as int?
    ..mCartonCode = json['cartonCode'] as String?
    ..mUnitCode = json['unitCode'] as String?
    ..unitPrice = (json['unitPrice'] as num?)?.toDouble()
    ..cartonPrice = (json['cartonPrice'] as num?)?.toDouble()
    ..unitTotalPrice = (json['unitTotalPrice'] as num?)?.toDouble()
    ..cartonTotalPrice = (json['cartonTotalPrice'] as num?)?.toDouble()
    ..total = (json['payable'] as num?)?.toDouble()
    ..subtotal = (json['subtotal'] as num?)?.toDouble()
    ..type = json['type'] as String?
    ..unitFreeQuantityTypeId = json['unitFreeQuantityTypeId'] as int?
    ..cartonFreeQuantityTypeId = json['cartonFreeQuantityTypeId'] as int?
    ..unitFreeGoodQuantity = json['unitFreeGoodQuantity'] as int?
    ..cartonFreeGoodQuantity = json['cartonFreeGoodQuantity'] as int?
    ..unitSelectedFreeGoodQuantity =
        json['unitSelectedFreeGoodQuantity'] as int?
    ..cartonSelectedFreeGoodQuantity =
        json['cartonSelectedFreeGoodQuantity'] as int?
    ..parentId = json['parentId'] as int?
    ..cartonPriceBreakDown = ((json['cartonPriceBreakDown'] is String)? jsonDecode(json['cartonPriceBreakDown']):json['cartonPriceBreakDown'] as List<dynamic>?)
        ?.map<CartonPriceBreakDownModel>((e) => CartonPriceBreakDownModel.fromJson(e as Map<String, dynamic>))
        .toList()
    ..unitPriceBreakDown =
       ((json['unitPriceBreakDown'] is String)? jsonDecode(json['unitPriceBreakDown']):json['unitPriceBreakDown'] as List<dynamic>?)
            ?.map<UnitPriceBreakDownModel>((e) => UnitPriceBreakDownModel.fromJson(e as Map<String, dynamic>))
            .toList()
    ..cartonFreeGoods = ((json['cartonFreeGoods'] is String)? jsonDecode(json['cartonFreeGoods']):json['cartonFreeGoods'] as List<dynamic>?)
        ?.map<OrderDetailModel>((e) => OrderDetailModel.fromJson(e as Map<String, dynamic>))
        .toList()
    ..unitFreeGoods =((json['unitFreeGoods'] is String)? jsonDecode(json['unitFreeGoods']):json['unitFreeGoods'] as List<dynamic>?)
        ?.map<OrderDetailModel>((e) => OrderDetailModel.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$OrderDetailToJson(OrderDetailModel instance) =>
    <String, dynamic>{
      'pk_modid': instance.orderDetailId,
      'mobileOrderId': instance.mLocalOrderId,
      'orderId': instance.mOrderId,
      'productId': instance.mProductId,
      'packageId': instance.packageId,
      'unitOrderDetailId': instance.mUnitOrderDetailId,
      'cartonOrderDetailId': instance.mCartonOrderDetailId,
      'productGroupId': instance.mProductGroupId,
      'unitFreeGoodGroupId': instance.unitFreeGoodGroupId,
      'cartonFreeGoodGroupId': instance.cartonFreeGoodGroupId,
      'unitFreeGoodDetailId': instance.unitFreeGoodDetailId,
      'cartonFreeGoodDetailId': instance.cartonFreeGoodDetailId,
      'productName': instance.mProductName,
      'cartonQuantity': instance.mCartonQuantity,
      'unitQuantity': instance.mUnitQuantity,
      'avlUnitQuantity': instance.avlUnitQuantity,
      'avlCartonQuantity': instance.avlCartonQuantity,
      'unitDefinitionId': instance.unitDefinitionId,
      'cartonDefinitionId': instance.cartonDefinitionId,
      'actualUnitStock': instance.actualUnitStock,
      'actualCartonStock': instance.actualCartonStock,
      'cartonSize': instance.cartonSize,
      'cartonCode': instance.mCartonCode,
      'unitCode': instance.mUnitCode,
      'unitPrice': instance.unitPrice,
      'cartonPrice': instance.cartonPrice,
      'unitTotalPrice': instance.unitTotalPrice,
      'cartonTotalPrice': instance.cartonTotalPrice,
      'payable': instance.total,
      'subtotal': instance.subtotal,
      'type': instance.type,
      'unitFreeQuantityTypeId': instance.unitFreeQuantityTypeId,
      'cartonFreeQuantityTypeId': instance.cartonFreeQuantityTypeId,
      'unitFreeGoodQuantity': instance.unitFreeGoodQuantity,
      'cartonFreeGoodQuantity': instance.cartonFreeGoodQuantity,
      'unitSelectedFreeGoodQuantity': instance.unitSelectedFreeGoodQuantity,
      'cartonSelectedFreeGoodQuantity': instance.cartonSelectedFreeGoodQuantity,
      'parentId': instance.parentId,
      'cartonPriceBreakDown': (instance.cartonPriceBreakDown),
      'unitPriceBreakDown': (instance.unitPriceBreakDown),
      'cartonFreeGoods': (instance.cartonFreeGoods),
      'unitFreeGoods': (instance.unitFreeGoods),
    };
