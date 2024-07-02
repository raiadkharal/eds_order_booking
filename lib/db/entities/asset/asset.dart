import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/utils/utils.dart';

part 'asset.g.dart';

@JsonSerializable()
class Asset {
  @JsonKey(name: 'assetId')
  final int? assetId;

  @JsonKey(name: 'outletId')
  final int? outletId;

  @JsonKey(name: 'organizationId')
  final int? organizationId;

  @JsonKey(name: 'assetTypeMainId')
  final int? assetTypeMainId;

  @JsonKey(name: 'longitude')
  final double? longitude;

  @JsonKey(name: 'latitude')
  final double? latitude;

  @JsonKey(name: 'assetModel')
  final String? assetModel;

  @JsonKey(name: 'assetModelId')
  final int? assetModelId;

  @JsonKey(name: 'assetName')
  final String? assetName;

  @JsonKey(name: 'assetNumber')
  final String? assetNumber;

  @JsonKey(name: 'assetType')
  final String? assetType;

  @JsonKey(name: 'assetTypeId')
  final int? assetTypeId;

  @JsonKey(name: 'assignedDate')
  final int? assignedDate;

  @JsonKey(name: 'assignmentCode')
  final String? assignmentCode;

  @JsonKey(name: 'cost')
  final double? cost;

  @JsonKey(name: 'deposit')
  final double? deposit;

  @JsonKey(name: 'documentNumber')
  final String? documentNumber;

  @JsonKey(name: 'statusid')
  final int? statusid;

  @JsonKey(name: 'expiryDate')
  final int? expiryDate;

  @JsonKey(name: 'returnDate')
  final int? returnDate;

  @JsonKey(name: 'barcode')
  final String? serialNumber;

  @JsonKey(name: 'TransactionType')
  final String? transactionType;

  @JsonKey(name: 'reason')
  final String? reason;

  @JsonKey(name: 'verified',fromJson:boolFromInt,toJson: boolToInt)
  final bool? verified;

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

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
  Map<String, dynamic> toJson() => _$AssetToJson(this);
}
