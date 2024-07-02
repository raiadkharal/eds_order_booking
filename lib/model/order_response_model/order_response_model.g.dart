// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponseModel _$OrderResponseModelFromJson(Map<String, dynamic> json) =>
    OrderResponseModel(
      code: json['code'] as String?,
      deliveryDate: json['deliveryDate'] as int?,
      distributionId: json['distributionId'] as int?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      mobileOrderId: json['mobileOrderId'] as int?,
      orderDate: json['orderDate'] as int?,
      orderDetails: (json['orderDetails'] as List<dynamic>?)
          ?.map((e) => OrderDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      priceBreakDown: (json['priceBreakDown'] as List<dynamic>?)
          ?.map((e) => UnitPriceBreakDownModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderId: json['orderId'] as int?,
      orderStatusId: json['orderStatusId'] as int?,
      orderStatusText: json['orderStatusText'] as String?,
      outletId: json['outletId'] as int?,
      payable: (json['payable'] as num?)?.toDouble(),
      routeId: json['routeId'] as int?,
      salesmanId: json['salesmanId'] as int?,
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      visitDayId: json['visitDayId'] as int?,
      outletStatus: json['outletStatus'] as int?,
      startedDate: json['startedDate'] as int?,
      outlet: json['outlet'] == null
          ? null
          : OutletModel.fromJson(json['outlet'] as Map<String, dynamic>),
      channelId: json['channelId'] as int?,
      organizationId: json['organizationId'] as int?,
    );

Map<String, dynamic> _$OrderResponseModelToJson(OrderResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'deliveryDate': instance.deliveryDate,
      'distributionId': instance.distributionId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'mobileOrderId': instance.mobileOrderId,
      'orderDate': instance.orderDate,
      'orderDetails': instance.orderDetails?.map((e) => e.toJson()).toList(),
      'priceBreakDown':
      instance.priceBreakDown?.map((e) => e.toJson()).toList(),
      'orderId': instance.orderId,
      'orderStatusId': instance.orderStatusId,
      'orderStatusText': instance.orderStatusText,
      'outletId': instance.outletId,
      'payable': instance.payable,
      'routeId': instance.routeId,
      'salesmanId': instance.salesmanId,
      'subtotal': instance.subtotal,
      'visitDayId': instance.visitDayId,
      'outletStatus': instance.outletStatus,
      'startedDate': instance.startedDate,
      'outlet': instance.outlet?.toJson(),
      'channelId': instance.channelId,
      'organizationId': instance.organizationId,
    };
