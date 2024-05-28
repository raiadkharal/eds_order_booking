// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Asset _$AssetFromJson(Map<String, dynamic> json) => Asset(
  assetId: json['assetId'] as int?,
  outletId: json['outletId'] as int?,
  organizationId: json['organizationId'] as int?,
  assetTypeMainId: json['assetTypeMainId'] as int?,
  longitude: (json['longitude'] as num?)?.toDouble(),
  latitude: (json['latitude'] as num?)?.toDouble(),
  assetModel: json['assetModel'] as String?,
  assetModelId: json['assetModelId'] as int?,
  assetName: json['assetName'] as String?,
  assetNumber: json['assetNumber'] as String?,
  assetType: json['assetType'] as String?,
  assetTypeId: json['assetTypeId'] as int?,
  assignedDate: json['assignedDate'] as int?,
  assignmentCode: json['assignmentCode'] as String?,
  cost: (json['cost'] as num?)?.toDouble(),
  deposit: (json['deposit'] as num?)?.toDouble(),
  documentNumber: json['documentNumber'] as String?,
  statusid: json['statusid'] as int?,
  expiryDate: json['expiryDate'] as int?,
  returnDate: json['returnDate'] as int?,
  serialNumber: json['barcode'] as String?,
  transactionType: json['TransactionType'] as String?,
  reason: json['reason'] as String?,
  verified: boolFromInt(json['verified'] as int?),
);

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
  'assetId': instance.assetId,
  'outletId': instance.outletId,
  'organizationId': instance.organizationId,
  'assetTypeMainId': instance.assetTypeMainId,
  'longitude': instance.longitude,
  'latitude': instance.latitude,
  'assetModel': instance.assetModel,
  'assetModelId': instance.assetModelId,
  'assetName': instance.assetName,
  'assetNumber': instance.assetNumber,
  'assetType': instance.assetType,
  'assetTypeId': instance.assetTypeId,
  'assignedDate': instance.assignedDate,
  'assignmentCode': instance.assignmentCode,
  'cost': instance.cost,
  'deposit': instance.deposit,
  'documentNumber': instance.documentNumber,
  'statusid': instance.statusid,
  'expiryDate': instance.expiryDate,
  'returnDate': instance.returnDate,
  'barcode': instance.serialNumber,
  'TransactionType': instance.transactionType,
  'reason': instance.reason,
  'verified': boolToInt(instance.verified),
};
