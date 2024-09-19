// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
  id: json['mobileOrderId'] as int?,
  serverOrderId: json['orderId'] as int?,
  outletId: json['outletId'] as int?,
  routeId: json['routeId'] as int?,
  orderStatus: json['orderStatusId'] as int?,
  visitDayId: json['visitDayId'] as int?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  orderDate: json['orderDate'] as int?,
  deliveryDate: json['deliveryDate'] as int?,
  distributionId: json['distributionId'] as int?,
  priceBreakDown: ((json['priceBreakDown'] is String)? jsonDecode(json['priceBreakDown']):json['priceBreakDown'] as List<dynamic>?)
      ?.map<UnitPriceBreakDown>((e) => UnitPriceBreakDown.fromJson(e as Map<String, dynamic>))
      .toList(),
  orderDetails: ((json['orderDetails'] is String)? jsonDecode(json['orderDetails']):json['orderDetails'] as List<dynamic>?)
      ?.map<OrderDetail>((e) => OrderDetail.fromJson(e as Map<String, dynamic>))
      .toList(),
)
  ..code = json['code'] as String?
  ..subTotal = (json['subtotal'] as num?)?.toDouble()
  ..payable = (json['payable'] as num?)?.toDouble();

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
  'mobileOrderId': instance.id,
  'outletId': instance.outletId,
  'orderId': instance.serverOrderId,
  'routeId': instance.routeId,
  'code': instance.code,
  'orderStatusId': instance.orderStatus,
  'visitDayId': instance.visitDayId,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'subtotal': instance.subTotal,
  'payable': instance.payable,
  'orderDate': instance.orderDate,
  'deliveryDate': instance.deliveryDate,
  'distributionId': instance.distributionId,
  'priceBreakDown': jsonEncode(instance.priceBreakDown?.map((e) => e.toJson(),).toList()),
  'orderDetails': jsonEncode(instance.orderDetails?.map((e) => e.toJson(),).toList()),
};
