import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/utils/util.dart';

import '../../models/last_order/last_order.dart';
import '../../models/outlet_visit/outlet_visit.dart';
import '../available_stock/available_stock.dart';

part 'outlet.g.dart';

@JsonSerializable(explicitToJson: true)
class Outlet {
  @JsonKey(name: 'mOutletId')
  final int? outletId;

  @JsonKey(name: 'routeId')
  final int? routeId;

  @JsonKey(name: 'outletCode')
  final String? outletCode;

  @JsonKey(name: 'outletName')
  final String? outletName;

  @JsonKey(name: 'channelName')
  final String? channelName;

  @JsonKey(name: 'location')
  final String? location;

  @JsonKey(name: 'visitFrequency')
  final int? visitFrequency;

  @JsonKey(name: 'visitDay')
  final int? visitDay;

  final int? planned;
  final int? sequenceNumber;

  @JsonKey(name: 'address')
  final String? address;

  @JsonKey(name: 'latitude')
  final double? latitude;

  @JsonKey(name: 'longitude')
  final double? longitude;

  final double? visitTimeLat;
  final double? visitTimeLng;

  @JsonKey(name: 'lastSaleDate')
  final int? lastSaleDate;

  @JsonKey(name: 'pricingGroupId')
  final int? pricingGroupId;

  @JsonKey(name: 'vpoClassificationId')
  final int? vpoClassificationId;

  @JsonKey(name: 'channelId')
  final int? channelId;

  @JsonKey(name: 'lastSaleQuantity')
  final String? lastSaleQuantity;

  @JsonKey(name: 'availableCreditLimit')
  final double? availableCreditLimit;

  @JsonKey(name: 'outstandingCreditLimit')
  final double? outstandingCredit;

  @JsonKey(name: 'lastSale')
  final double? lastSale;

  @JsonKey(name: 'visitStatus')
  final int? visitStatus;

  final String? cnic;
  final String? strn;

  @JsonKey(name: 'mtdSale')
  final double? mtdSale;

  @JsonKey(name: 'mobileNumber')
  final String? mobileNumber;

  @JsonKey(name: 'hasHTHDiscount',toJson: boolToInt,fromJson: boolFromInt)
  final bool? hasHTHDiscount;

  @JsonKey(name: 'hasRentalDiscount',toJson: boolToInt,fromJson: boolFromInt)
  final bool? hasRentalDiscount;

  @JsonKey(name: 'hasExclusivityFee',toJson: boolToInt,fromJson: boolFromInt)
  final bool? hasExclusivityFee;

  @JsonKey(name: 'lastOrder')
  final LastOrder? lastOrder;

  @JsonKey(name: 'isAssetsScennedInTheLastMonth',toJson: boolToInt,fromJson: boolFromInt)
  final bool? isAssetsScennedInTheLastMonth;

  @JsonKey(name: "synced",toJson: boolToInt,fromJson: boolFromInt)
  final bool? synced;

  @JsonKey(name: 'statusId')
  final int? statusId;

  @JsonKey(name: 'isZeroSaleOutlet',toJson: boolToInt,fromJson: boolFromInt)
  final bool? isZeroSaleOutlet;

  @JsonKey(name: 'promoTypeId')
  final int? promoTypeId;

  @JsonKey(name: 'customerRegistrationTypeId')
  final int? customerRegistrationTypeId;

  @JsonKey(name: 'digitalAccount')
  final String? digitalAccount;

  @JsonKey(name: 'disburseAmount')
  final double? disburseAmount;

  final String? remarks;

  @JsonKey(name: 'organizationId')
  final int? organizationId;

  @JsonKey(name: 'outletPromoConfigId')
  final int? outletPromoConfigId;

  @JsonKey(name: 'outletVisits')
  final List<OutletVisit>? outletVisits;

  @JsonKey(name: 'avlStockDetail')
  final List<AvailableStock>? avlStockDetail;

  Outlet({
    this.outletId,
    this.routeId,
    this.outletCode,
    this.outletName,
    this.channelName,
    this.location,
    this.visitFrequency,
    this.visitDay,
    this.planned,
    this.sequenceNumber,
    this.address,
    this.latitude,
    this.longitude,
    this.visitTimeLat,
    this.visitTimeLng,
    this.lastSaleDate,
    this.pricingGroupId,
    this.vpoClassificationId,
    this.channelId,
    this.lastSaleQuantity,
    this.availableCreditLimit,
    this.outstandingCredit,
    this.lastSale,
    this.visitStatus,
    this.cnic,
    this.strn,
    this.mtdSale,
    this.mobileNumber,
    this.hasHTHDiscount,
    this.hasRentalDiscount,
    this.hasExclusivityFee,
    this.lastOrder,
    this.isAssetsScennedInTheLastMonth,
    this.synced,
    this.statusId,
    this.isZeroSaleOutlet,
    this.promoTypeId,
    this.customerRegistrationTypeId,
    this.digitalAccount,
    this.disburseAmount,
    this.remarks,
    this.organizationId,
    this.outletPromoConfigId,
    this.outletVisits,
    this.avlStockDetail,
  });

  factory Outlet.fromJson(Map<String, dynamic> json) => _$OutletFromJson(json);
  Map<String, dynamic> toJson() => _$OutletToJson(this);
}
