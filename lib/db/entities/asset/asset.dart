import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/utils/utils.dart';

part 'asset.g.dart';

@JsonSerializable()
class Asset {
  @JsonKey(name: 'assetId')
  int? assetId;

  @JsonKey(name: 'outletId')
  int? outletId;

  @JsonKey(name: 'organizationId')
  int? organizationId;

  @JsonKey(name: 'assetTypeMainId')
  int? assetTypeMainId;

  @JsonKey(name: 'longitude')
  double? longitude;

  @JsonKey(name: 'latitude')
  double? latitude;

  @JsonKey(name: 'assetModel')
  String? assetModel;

  @JsonKey(name: 'assetModelId')
  int? assetModelId;

  @JsonKey(name: 'assetName')
  String? assetName;

  @JsonKey(name: 'assetNumber')
  String? assetNumber;

  @JsonKey(name: 'assetType')
  String? assetType;

  @JsonKey(name: 'assetTypeId')
  int? assetTypeId;

  @JsonKey(name: 'assignedDate')
  int? assignedDate;

  @JsonKey(name: 'assignmentCode')
  String? assignmentCode;

  @JsonKey(name: 'cost')
  double? cost;

  @JsonKey(name: 'deposit')
  double? deposit;

  @JsonKey(name: 'documentNumber')
  String? documentNumber;

  @JsonKey(name: 'statusid')
  int? statusid;

  @JsonKey(name: 'expiryDate')
  int? expiryDate;

  @JsonKey(name: 'returnDate')
  int? returnDate;

  @JsonKey(name: 'barcode')
  String? serialNumber;

  @JsonKey(name: 'TransactionType')
  String? transactionType;

  @JsonKey(name: 'reason')
  String? reason;

  @JsonKey(name: 'verified',fromJson:boolFromInt,toJson: boolToInt)
  bool? verified;

  Asset({
    this.assetId,
    this.outletId,
    this.organizationId,
    this.assetTypeMainId,
    this.longitude,
    this.latitude,
    this.assetModel,
    this.assetModelId,
    this.assetName,
    this.assetNumber,
    this.assetType,
    this.assetTypeId,
    this.assignedDate,
    this.assignmentCode,
    this.cost,
    this.deposit,
    this.documentNumber,
    this.statusid,
    this.expiryDate,
    this.returnDate,
    this.serialNumber,
    this.transactionType,
    this.reason,
    this.verified,
  });

  bool getVerified(){
    return verified??false;
  }

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
  Map<String, dynamic> toJson() => _$AssetToJson(this);
}
