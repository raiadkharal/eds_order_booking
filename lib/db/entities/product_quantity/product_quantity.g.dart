// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_quantity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductQuantity _$ProductQuantityFromJson(Map<String, dynamic> json) => ProductQuantity(
  productDefinitionId: json['ProductDefinitionId'] as int?,
  quantity: json['Quantity'] as int?,
  packageId: json['packageId'] as int?,
);

Map<String, dynamic> _$ProductQuantityToJson(ProductQuantity instance) => <String, dynamic>{
  'ProductDefinitionId': instance.productDefinitionId,
  'Quantity': instance.quantity,
  'packageId': instance.packageId,
};
