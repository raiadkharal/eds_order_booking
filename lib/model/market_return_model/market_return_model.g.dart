// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_return_model.dart';

MarketReturnsModel _$MarketReturnsModelFromJson(Map<String, dynamic> json) {
  return MarketReturnsModel(
    organizationId: json['organizationId'] as int,
    routeId: json['routeId'] as int?,
    distributionId: json['distributionId'] as int,
    warehouseId: json['warehouseId'] as int,
    salesmanId: json['salesmanId'] as int,
    invoiceId: json['invoiceId'] as int,
    outletId: json['outletId'] as int?,
    orderDate: json['orderDate'] as int,
    deliveryDate: json['deliveryDate'] as int,
    marketReturnDetails: (json['marketReturnDetails'] as List<dynamic>?)
        ?.map((e) => MarketReturnDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MarketReturnsModelToJson(MarketReturnsModel instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'routeId': instance.routeId,
      'distributionId': instance.distributionId,
      'warehouseId': instance.warehouseId,
      'salesmanId': instance.salesmanId,
      'invoiceId': instance.invoiceId,
      'outletId': instance.outletId,
      'orderDate': instance.orderDate,
      'deliveryDate': instance.deliveryDate,
      'marketReturnDetails':
      instance.marketReturnDetails?.map((e) => e.toJson()).toList(),
    };
