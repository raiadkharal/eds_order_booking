import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/db/entities/available_stock/available_stock.dart';
import 'package:order_booking/db/models/outlet_visit/outlet_visit.dart';
import 'package:order_booking/utils/utils.dart';

import '../last_order/last_order_model.dart';


part 'outlet_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OutletModel {
  @JsonKey(name: 'mOutletId')
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

  @JsonKey(name: 'hasHTHDiscount',toJson: boolToInt)
  bool? hasHTHDiscount;

  @JsonKey(name: 'hasRentalDiscount',toJson: boolToInt)
  bool? hasRentalDiscount;

  @JsonKey(name: 'hasExclusivityFee',toJson: boolToInt)
  bool? hasExclusivityFee;

  @JsonKey(name: 'lastOrder')
  LastOrderModel? lastOrder;

  @JsonKey(name: 'isAssetsScennedInTheLastMonth',toJson: boolToInt)
  bool? isAssetsScennedInTheLastMonth;

  @JsonKey(name: "synced",toJson: boolToInt)
  bool? synced;

  @JsonKey(name: 'statusId')
  int? statusId;

  @JsonKey(name: 'isZeroSaleOutlet',toJson: boolToInt)
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

  OutletModel({
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

  factory OutletModel.fromJson(Map<String, dynamic> json) => _$OutletFromJson(json);
  Map<String, dynamic> toJson() => _$OutletToJson(this);
}
