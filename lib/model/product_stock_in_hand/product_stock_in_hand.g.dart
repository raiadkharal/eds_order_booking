// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_stock_in_hand.dart';

ProductStockInHand _$ProductStockInHandFromJson(Map<String, dynamic> json) {
  return ProductStockInHand(
    pkPid: json['pk_pid'] as int,
    unitStockInHand: json['unitStockInHand'] as int,
    cartonStockInHand: json['cartonStockInHand'] as int,
  );
}

Map<String, dynamic> _$ProductStockInHandToJson(ProductStockInHand instance) => <String, dynamic>{
  'pk_pid': instance.pkPid,
  'unitStockInHand': instance.unitStockInHand,
  'cartonStockInHand': instance.cartonStockInHand,
};
