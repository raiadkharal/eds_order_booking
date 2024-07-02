import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/db/entities/order_detail/order_detail.dart';
import 'package:order_booking/db/entities/order_status/order_status.dart';
import 'package:order_booking/model/order_detail_model/order_detail_model.dart';
import 'package:order_booking/model/order_model/order_model.dart';
import 'package:order_booking/model/outlet_model/outlet_model.dart';

import '../../db/entities/available_stock/available_stock.dart';
import '../../db/entities/order/order.dart';
import '../../db/entities/outlet/outlet.dart';

part 'order_model_response.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderEntityModel {
  Order? order;
  Outlet? outlet;
  OrderStatus? orderStatus;

  @JsonKey(ignore: true)
  bool? success;

  @JsonKey(ignore: true)
  List<OrderDetail>? orderDetails;

  @JsonKey(ignore: true)
  List<AvailableStock>? availableStockDetails;

  @JsonKey(ignore: true)
  List<OrderDetail>? freeGoods;

  @JsonKey(ignore: true)
  double? freeAvailableQty;

  List<OrderDetail>? orderDetailAndCPriceBreakdowns;

  OrderEntityModel({
    this.order,
    this.outlet,
    this.orderStatus,
    this.success,
    this.orderDetails,
    this.availableStockDetails,
    this.freeGoods,
    this.freeAvailableQty,
    this.orderDetailAndCPriceBreakdowns,
  });

  // Factory method to create an instance from JSON
  factory OrderEntityModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
