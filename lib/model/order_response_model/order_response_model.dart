import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/db/entities/order_detail/order_detail.dart';
import 'package:order_booking/model/order_detail_model/order_detail_model.dart';
import 'package:order_booking/model/unit_price_breakdown_model/unit_price_breakdown_model.dart';

import '../../db/entities/outlet/outlet.dart';
import '../../db/models/base_response/base_response.dart';
import '../outlet_model/outlet_model.dart';

part 'order_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderResponseModel extends BaseResponse{
  @JsonKey(name: 'code')
  String? code;

  @JsonKey(name: 'deliveryDate')
  int? deliveryDate;

  @JsonKey(name: 'distributionId')
  int? distributionId;

  @JsonKey(name: 'latitude')
  double? latitude;

  @JsonKey(name: 'longitude')
  double? longitude;

  @JsonKey(name: 'mobileOrderId')
  int? mobileOrderId;

  @JsonKey(name: 'orderDate')
  int? orderDate;

  @JsonKey(name: 'orderDetails')
  List<OrderDetailModel>? orderDetails;

  @JsonKey(name: 'priceBreakDown')
  List<UnitPriceBreakDownModel>? priceBreakDown;  //invoice level breakdowns

  @JsonKey(name: 'orderId')
  int? orderId;

  @JsonKey(name: 'orderStatusId')
  int? orderStatusId;

  @JsonKey(name: 'orderStatusText')
  String? orderStatusText;

  @JsonKey(name: 'outletId')
  int? outletId;

  @JsonKey(name: 'payable')
  double? payable;

  @JsonKey(name: 'routeId')
  int? routeId;

  @JsonKey(name: 'salesmanId')
  int? salesmanId;

  @JsonKey(name: 'subtotal')
  double? subtotal;

  @JsonKey(name: 'visitDayId')
  int? visitDayId;

  @JsonKey(name: 'outletStatus')
  int? outletStatus;

  @JsonKey(name: 'startedDate')
  int? startedDate;

  @JsonKey(name: 'outlet')
  Outlet? outlet;

  @JsonKey(name: 'channelId')
  int? channelId;

  @JsonKey(name: 'organizationId')
  int? organizationId;

  OrderResponseModel({
    this.code,
    this.deliveryDate,
    this.distributionId,
    this.latitude,
    this.longitude,
    this.mobileOrderId,
    this.orderDate,
    this.orderDetails,
    this.priceBreakDown,
    this.orderId,
    this.orderStatusId,
    this.orderStatusText,
    this.outletId,
    this.payable,
    this.routeId,
    this.salesmanId,
    this.subtotal,
    this.visitDayId,
    this.outletStatus,
    this.startedDate,
    this.outlet,
    this.channelId,
    this.organizationId,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseModelToJson(this);

  Map<String, dynamic> serialize() => _$SerializeToJsonWithExcludedFields(this);
}
