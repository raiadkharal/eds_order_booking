// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_and_price_breakdown.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailAndPriceBreakdown _$OrderDetailAndPriceBreakdownFromJson(
    Map<String, dynamic> json) {
  return OrderDetailAndPriceBreakdown(
    orderDetail: OrderDetail.fromJson(json['orderDetail'] as Map<String, dynamic>),
    cartonPriceBreakDownList: (json['cartonPriceBreakDownList'] as List<dynamic>)
        .map((e) => CartonPriceBreakDown.fromJson(e as Map<String, dynamic>))
        .toList(),
    unitPriceBreakDownList: (json['unitPriceBreakDownList'] as List<dynamic>)
        .map((e) => UnitPriceBreakDown.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OrderDetailAndPriceBreakdownToJson(
    OrderDetailAndPriceBreakdown instance) =>
    <String, dynamic>{
      'orderDetail': instance.orderDetail.toJson(),
      'cartonPriceBreakDownList':
      instance.cartonPriceBreakDownList?.map((e) => e.toJson()).toList(),
      'unitPriceBreakDownList':
      instance.unitPriceBreakDownList?.map((e) => e.toJson()).toList(),
    };
