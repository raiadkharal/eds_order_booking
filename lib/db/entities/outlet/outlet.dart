import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/utils/utils.dart';

import '../../models/last_order/last_order.dart';
import '../../models/outlet_visit/outlet_visit.dart';
import '../available_stock/available_stock.dart';

part 'outlet.g.dart';

@JsonSerializable(explicitToJson: true)
class Outlet {
  @JsonKey(name: 'outletId')
  int? outletId;

  @JsonKey(name: 'routeId')
  int? routeId;

  @JsonKey(name: 'outletCode')
  String? outletCode;

  @JsonKey(name: 'outletName')
  String? outletName;

  @JsonKey(name: 'channelName')
  String? channelName;

  @JsonKey(name: 'location')
  String? location;

  @JsonKey(name: 'visitFrequency')
  int? visitFrequency;

  @JsonKey(name: 'visitDay')
  int? visitDay;

  int? planned;
  int? sequenceNumber;

  @JsonKey(name: 'address')
  String? address;

  @JsonKey(name: 'latitude')
  double? latitude;

  @JsonKey(name: 'longitude')
  double? longitude;

  double? visitTimeLat;
  double? visitTimeLng;

  @JsonKey(name: 'lastSaleDate')
  int? lastSaleDate;

  @JsonKey(name: 'pricingGroupId')
  int? pricingGroupId;

  @JsonKey(name: 'vpoClassificationId')
  int? vpoClassificationId;

  @JsonKey(name: 'channelId')
  int? channelId;

  @JsonKey(name: 'lastSaleQuantity')
  String? lastSaleQuantity;

  @JsonKey(name: 'availableCreditLimit')
  double? availableCreditLimit;

  @JsonKey(name: 'outstandingCreditLimit')
  double? outstandingCredit;

  @JsonKey(name: 'lastSale')
  double? lastSale;

  @JsonKey(name: 'visitStatus')
  int? visitStatus;

  String? cnic;
  String? strn;

  @JsonKey(name: 'mtdSale')
  double? mtdSale;

  @JsonKey(name: 'mobileNumber')
  String? mobileNumber;

  @JsonKey(name: 'hasHTHDiscount',toJson: boolToInt,fromJson: boolFromInt)
  bool? hasHTHDiscount;

  @JsonKey(name: 'hasRentalDiscount',toJson: boolToInt,fromJson: boolFromInt)
  bool? hasRentalDiscount;

  @JsonKey(name: 'hasExclusivityFee',toJson: boolToInt,fromJson: boolFromInt)
  bool? hasExclusivityFee;

  @JsonKey(name: 'lastOrder')
  LastOrder? lastOrder;

  @JsonKey(name: 'isAssetsScennedInTheLastMonth',toJson: boolToInt,fromJson: boolFromInt)
  bool? isAssetsScennedInTheLastMonth;

  @JsonKey(name: "synced",toJson: boolToInt,fromJson: boolFromInt)
  bool? synced;

  @JsonKey(name: 'statusId')
  int? statusId;

  @JsonKey(name: 'isZeroSaleOutlet',toJson: boolToInt,fromJson: boolFromInt)
  bool? isZeroSaleOutlet;

  @JsonKey(name: 'promoTypeId')
  int? promoTypeId;

  @JsonKey(name: 'customerRegistrationTypeId')
  int? customerRegistrationTypeId;

  @JsonKey(name: 'digitalAccount')
  String? digitalAccount;

  @JsonKey(name: 'disburseAmount')
  double? disburseAmount;

  String? remarks;

  @JsonKey(name: 'organizationId')
  int? organizationId;

  @JsonKey(name: 'outletPromoConfigId')
  int? outletPromoConfigId;

  @JsonKey(name: 'outletVisits')
  List<OutletVisit>? outletVisits;

  @JsonKey(name: 'avlStockDetail')
  List<AvailableStock>? avlStockDetail;

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
