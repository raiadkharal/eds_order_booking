import 'package:json_annotation/json_annotation.dart';

import '../../entities/order_detail/order_detail.dart';

part 'last_order.g.dart';

@JsonSerializable()
class LastOrder {
  final int? routeId;
  final int? outletId;
  final int? orderId;
  final double? orderTotal;
  final int? lastSaleDate;
  final double? orderQuantity;
  final List<OrderDetail>? orderDetails;

  LastOrder({
    this.routeId,
    this.outletId,
    this.orderId,
    this.orderTotal,
    this.lastSaleDate,
    this.orderQuantity,
    this.orderDetails,
  });

  factory LastOrder.fromJson(Map<String, dynamic> json) => _$LastOrderFromJson(json);
  Map<String, dynamic> toJson() => _$LastOrderToJson(this);
}
