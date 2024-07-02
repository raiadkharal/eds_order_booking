// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_carton_quantity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCartonQty _$ProductCartonQtyFromJson(Map<String, dynamic> json) {
  return ProductCartonQty(
    pkPid: json['pk_pid'] as int?,
    cartonQuantity: json['cartonQuantity'] as int?,
  );
}

Map<String, dynamic> _$ProductCartonQtyToJson(ProductCartonQty instance) =>
    <String, dynamic>{
      'pk_pid': instance.pkPid,
      'cartonQuantity': instance.cartonQuantity,
    };
