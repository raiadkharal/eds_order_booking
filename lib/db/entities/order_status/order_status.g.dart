// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderStatus _$OrderStatusFromJson(Map<String, dynamic> json) {
  return OrderStatus(
    outletId: json['outletId'] as int?,
    orderId: json['orderId'] as int?,
    outletVisitEndTime: json['outletVisitEndTime'] as int?,
    outletVisitStartTime: json['outletVisitStartTime'] as int?,
    status: json['status'] as int?,
    orderAmount: (json['orderAmount'] as num?)?.toDouble(),
    synced: boolFromInt(json['sync'] as int?),
    data: json['data'] as String?,
    imageStatus: json['imageStatus'] as int?,
    requestStatus: json['requestStatus'] as int?,
    outletLatitude: (json['outletLatitude'] as num?)?.toDouble(),
    outletLongitude: (json['outletLongitude'] as num?)?.toDouble(),
    outletDistance: json['outletDistance'] as int?,
  );
}

Map<String, dynamic> _$OrderStatusToJson(OrderStatus instance) =>
    <String, dynamic>{
      'outletId': instance.outletId,
      'orderId': instance.orderId,
      'outletVisitEndTime': instance.outletVisitEndTime,
      'outletVisitStartTime': instance.outletVisitStartTime,
      'status': instance.status,
      'orderAmount': instance.orderAmount,
      'sync': boolToInt(instance.synced),
      'data': instance.data,
      'imageStatus': instance.imageStatus,
      'requestStatus': instance.requestStatus,
      'outletLatitude': instance.outletLatitude,
      'outletLongitude': instance.outletLongitude,
      'outletDistance': instance.outletDistance,
    };
