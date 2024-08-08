// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail.dart';

OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) {
  return OrderDetail(
    productId: json['productId'] as int?,
    quantity: (json['quantity'] as num?)?.toDouble(),
    productTotal: (json['productTotal'] as num?)?.toDouble(),
    productName: json['productName'] as String?,
  );
}

Map<String, dynamic> _$OrderDetailToJson(OrderDetail instance) => <String, dynamic>{
  'productId': instance.productId,
  'quantity': instance.quantity,
  'productTotal': instance.productTotal,
  'productName': instance.productName,
};
