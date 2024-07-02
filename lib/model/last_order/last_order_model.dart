import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/model/order_detail_model/order_detail_model.dart';


part 'last_order_model.g.dart';

@JsonSerializable()
class LastOrderModel {
  final int? routeId;
  final int? outletId;
  final int? orderId;
  final double? orderTotal;
  final int? lastSaleDate;
  final double? orderQuantity;
  final List<OrderDetailModel>? orderDetails;

  LastOrderModel({
    this.routeId,
    this.outletId,
    this.orderId,
    this.orderTotal,
    this.lastSaleDate,
    this.orderQuantity,
    this.orderDetails,
  });

  factory LastOrderModel.fromJson(Map<String, dynamic> json) => _$LastOrderFromJson(json);
  Map<String, dynamic> toJson() => _$LastOrderToJson(this);
}
