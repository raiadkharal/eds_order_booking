import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/utils/utils.dart';

part 'order_status.g.dart';

@JsonSerializable()
class OrderStatus {
  @JsonKey(name: 'outletId')
  int? outletId;

  @JsonKey(name: 'orderId')
  int? orderId;

  @JsonKey(name: 'outletVisitEndTime')
  int? outletVisitEndTime;

  @JsonKey(name: 'outletVisitStartTime')
  int? outletVisitStartTime;

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'orderAmount')
  double? orderAmount;

  @JsonKey(name: 'sync',toJson: boolToInt,fromJson: boolFromInt)
  bool? synced;

  @JsonKey(name: 'data')
  String? data;

  @JsonKey(name: 'imageStatus')
  int? imageStatus;

  @JsonKey(name: 'requestStatus')
  int? requestStatus;

  @JsonKey(name: 'outletLatitude')
  double? outletLatitude;

  @JsonKey(name: 'outletLongitude')
  double? outletLongitude;

  @JsonKey(name: 'outletDistance')
  int? outletDistance;

  OrderStatus({
    this.outletId,
    this.orderId,
    this.outletVisitEndTime,
    this.outletVisitStartTime,
    this.status,
    this.orderAmount,
    this.synced,
    this.data,
    this.imageStatus,
    this.requestStatus=0,
    this.outletLatitude,
    this.outletLongitude,
    this.outletDistance,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusToJson(this);
}
