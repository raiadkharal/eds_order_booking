// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_carton_quantity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCartonQty _$ProductCartonQtyFromJson(Map<String, dynamic> json) {
  return ProductCartonQty(
    productId: json['productId'] as int?,
    cartonQuantity: json['cartonQuantity'] as int?,
  );
}

Map<String, dynamic> _$ProductCartonQtyToJson(ProductCartonQty instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'cartonQuantity': instance.cartonQuantity,
    };
