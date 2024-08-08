// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['pk_pid'] as int?,
    productName: json['productName'] as String?,
    description: json['productDescription'] as String?,
    code: json['productCode'] as String?,
    groupId: json['productGroupId'] as int?,
    groupName: json['productGroupName'] as String?,
    packageId: json['productPackageId'] as int?,
    packageName: json['packageName'] as String?,
    brandId: json['productBrandId'] as int?,
    brandName: json['brandName'] as String?,
    flavorId: json['productFlavorId'] as int?,
    flavorName: json['flavorName'] as String?,
    unitCode: json['unitCode'] as String?,
    cartonCode: json['cartonCode'] as String?,
    unitQuantity: json['unitQuantity'] as int?,
    cartonQuantity: json['cartonQuantity'] as int?,
    unitSizeForDisplay: json['unitSizeForDisplay'] as String?,
    cartonSizeForDisplay: json['cartonSizeForDisplay'] as String?,
    unitStockInHand: json['unitStockInHand'] as int?,
    cartonStockInHand: json['cartonStockInHand'] as int?,
    unitDefinitionId: json['unitDefinitionId'] as int?,
    cartonDefinitionId: json['cartonDefinitionId'] as int?,
    actualUnitStock: json['actualUnitStock'] as int?,
    actualCartonStock: json['actualCartonStock'] as int?,
    organizationId: json['organizationId'] as int?,
    qtyCarton: json['qtyCarton'] as int?,
    qtyUnit: json['qtyUnit'] as int?,
    avlStockCarton: json['avlStockCarton'] as int?,
    avlStockUnit: json['avlStockUnit'] as int?,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'pk_pid': instance.id,
  'productName': instance.productName,
  'productDescription': instance.description,
  'productCode': instance.code,
  'productGroupId': instance.groupId,
  'productGroupName': instance.groupName,
  'productPackageId': instance.packageId,
  'packageName': instance.packageName,
  'productBrandId': instance.brandId,
  'brandName': instance.brandName,
  'productFlavorId': instance.flavorId,
  'flavorName': instance.flavorName,
  'unitCode': instance.unitCode,
  'cartonCode': instance.cartonCode,
  'unitQuantity': instance.unitQuantity,
  'cartonQuantity': instance.cartonQuantity,
  'unitSizeForDisplay': instance.unitSizeForDisplay,
  'cartonSizeForDisplay': instance.cartonSizeForDisplay,
  'unitStockInHand': instance.unitStockInHand,
  'cartonStockInHand': instance.cartonStockInHand,
  'unitDefinitionId': instance.unitDefinitionId,
  'cartonDefinitionId': instance.cartonDefinitionId,
  'actualUnitStock': instance.actualUnitStock,
  'actualCartonStock': instance.actualCartonStock,
  'organizationId': instance.organizationId,
  'qtyCarton':instance.qtyCarton,
  'qtyUnit':instance.qtyUnit,
  'avlStockCarton':instance.avlStockCarton,
  'avlStockUnit':instance.avlStockUnit,
};
