import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/utils/util.dart';

part 'order_status.g.dart';

@JsonSerializable()
class OrderStatus {
  @JsonKey(name: 'outletId')
  final int? outletId;

  @JsonKey(name: 'orderId')
  final int? orderId;

  @JsonKey(name: 'outletVisitEndTime')
  final int? outletVisitEndTime;

  @JsonKey(name: 'outletVisitStartTime')
  final int? outletVisitStartTime;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'orderAmount')
  final double? orderAmount;

  @JsonKey(name: 'sync',toJson: boolToInt,fromJson: boolFromInt)
  final bool? synced;

  @JsonKey(name: 'data')
  final String? data;

  @JsonKey(name: 'imageStatus')
  final int? imageStatus;

  @JsonKey(name: 'requestStatus')
  final int? requestStatus;

  @JsonKey(name: 'outletLatitude')
  final double? outletLatitude;

  @JsonKey(name: 'outletLongitude')
  final double? outletLongitude;

  @JsonKey(name: 'outletDistance')
  final int? outletDistance;

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
    this.requestStatus,
    this.outletLatitude,
    this.outletLongitude,
    this.outletDistance,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusToJson(this);
}
