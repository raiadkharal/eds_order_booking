// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastOrderModel _$LastOrderFromJson(Map<String, dynamic> json) => LastOrderModel(
  routeId: json['routeId'] as int?,
  outletId: json['outletId'] as int?,
  orderId: json['orderId'] as int?,
  orderTotal: (json['orderTotal'] as num?)?.toDouble(),
  lastSaleDate: json['lastSaleDate'] as int?,
  orderQuantity: (json['orderQuantity'] as num?)?.toDouble(),
  orderDetails: (json['orderDetails'] as List<dynamic>?)
      ?.map((e) => OrderDetailModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$LastOrderToJson(LastOrderModel instance) => <String, dynamic>{
  'routeId': instance.routeId,
  'outletId': instance.outletId,
  'orderId': instance.orderId,
  'orderTotal': instance.orderTotal,
  'lastSaleDate': instance.lastSaleDate,
  'orderQuantity': instance.orderQuantity,
  'orderDetails': instance.orderDetails?.map((e) => e.toJson()).toList(),
};
