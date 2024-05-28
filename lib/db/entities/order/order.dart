import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../order_detail/order_detail.dart';
import '../unit_price_breakdown/unit_price_breakdown.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  @JsonKey(name: 'mobileOrderId')
  int? id;

  @JsonKey(name: 'orderId')
  int? serverOrderId;

  @JsonKey(name: 'outletId')
  int? outletId;

  @JsonKey(name: 'routeId')
  int? routeId;

  @JsonKey(ignore: true)
  String? code;

  @JsonKey(name: 'orderStatusId')
  int? orderStatus;

  @JsonKey(name: 'visitDayId')
  int? visitDayId;

  @JsonKey(name: 'latitude')
  double? latitude;

  @JsonKey(name: 'longitude')
  double? longitude;

  @JsonKey(ignore: true)
  double? subTotal;

  @JsonKey(ignore: true)
  double? payable;

  @JsonKey(name: 'orderDate')
  int? orderDate;

  @JsonKey(name: 'deliveryDate')
  int? deliveryDate;

  @JsonKey(name: 'distributionId')
  int? distributionId;

  @JsonKey(name: 'priceBreakDown')
  List<UnitPriceBreakDown>? priceBreakDown;

  @JsonKey(name: 'orderDetails')
  List<OrderDetail>? orderDetails;

  Order({
    this.id,
    this.serverOrderId,
    this.outletId,
    this.routeId,
    this.code,
    this.orderStatus,
    this.visitDayId,
    this.latitude,
    this.longitude,
    this.subTotal,
    this.payable,
    this.orderDate,
    this.deliveryDate,
    this.distributionId,
    this.priceBreakDown,
    this.orderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
