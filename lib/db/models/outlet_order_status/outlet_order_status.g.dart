// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outlet_order_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutletOrderStatus _$OutletOrderStatusFromJson(Map<String, dynamic> json) {
  return OutletOrderStatus(
    orderStatus: json['orderStatus'] == null
        ? null
        : OrderStatus.fromJson(jsonDecode(json['orderStatus']) as Map<String, dynamic>),
    outlet: json['outlet'] == null
        ? null
        : Outlet.fromJson(jsonDecode(json['outlet']) as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OutletOrderStatusToJson(OutletOrderStatus instance) =>
    <String, dynamic>{
      'orderStatus': jsonEncode(instance.orderStatus),
      'outlet': jsonEncode(instance.outlet),
    };
