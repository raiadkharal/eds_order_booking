import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../entities/order_status/order_status.dart';
import '../../entities/outlet/outlet.dart';

part 'outlet_order_status.g.dart';

@JsonSerializable()
class OutletOrderStatus {
  @JsonKey(name: 'orderStatus')
  OrderStatus? orderStatus;
  @JsonKey(name: 'outlet')
  Outlet? outlet;

  OutletOrderStatus({
    this.orderStatus,
    this.outlet,
  });

  factory OutletOrderStatus.fromJson(Map<String, dynamic> json) =>
      _$OutletOrderStatusFromJson(json);

  Map<String, dynamic> toJson() => _$OutletOrderStatusToJson(this);
}
