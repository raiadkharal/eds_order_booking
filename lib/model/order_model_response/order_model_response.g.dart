// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEntityModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return OrderEntityModel(
    order: json['order'] == null
        ? null
        : Order.fromJson(json['order'] as Map<String, dynamic>),
    outlet: json['outlet'] == null
        ? null
        : Outlet.fromJson(json['outlet'] as Map<String, dynamic>),
    orderStatus: json['orderStatus'] == null
        ? null
        : OrderStatus.fromJson(json['orderStatus'] as Map<String, dynamic>),
    success: json['success'] as bool?,
    orderDetails: (json['orderDetails'] as List<dynamic>?)
        ?.map((e) => OrderDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
    availableStockDetails: (json['availableStockDetails'] as List<dynamic>?)
        ?.map((e) => AvailableStock.fromJson(e as Map<String, dynamic>))
        .toList(),
    freeGoods: (json['freeGoods'] as List<dynamic>?)
        ?.map((e) => OrderDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
    freeAvailableQty: (json['freeAvailableQty'] as num?)?.toDouble(),
    orderDetailAndCPriceBreakdowns: (json['orderDetailAndCPriceBreakdowns'] as List<dynamic>?)
        ?.map((e) => OrderDetailAndPriceBreakdown.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OrderModelToJson(OrderEntityModel instance) =>
    <String, dynamic>{
      'order': instance.order?.toJson(),
      'outlet': instance.outlet?.toJson(),
      'orderStatus': instance.orderStatus?.toJson(),
      'orderDetailAndCPriceBreakdowns':
      instance.orderDetailAndCPriceBreakdowns?.map((e) => e.toJson()).toList(),
    };
