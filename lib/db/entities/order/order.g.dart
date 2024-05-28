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
  priceBreakDown: (jsonDecode(json['priceBreakDown']) as List<dynamic>?)
      ?.map((e) => UnitPriceBreakDown.fromJson(e as Map<String, dynamic>))
      .toList(),
  orderDetails: (jsonDecode(json['orderDetails']) as List<dynamic>?)
      ?.map((e) => OrderDetail.fromJson(e as Map<String, dynamic>))
      .toList(),
)
  ..code = json['code'] as String?
  ..subTotal = (json['subtotal'] as num?)?.toDouble()
  ..payable = (json['payable'] as num?)?.toDouble();

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
  'mobileOrderId': instance.id,
  'orderId': instance.serverOrderId,
  'outletId': instance.outletId,
  'routeId': instance.routeId,
  'orderStatusId': instance.orderStatus,
  'visitDayId': instance.visitDayId,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'orderDate': instance.orderDate,
  'deliveryDate': instance.deliveryDate,
  'distributionId': instance.distributionId,
  'priceBreakDown': jsonEncode(instance.priceBreakDown),
  'orderDetails': jsonEncode(instance.orderDetails),
};
