// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadStatusModel _$UploadStatusModelFromJson(Map<String, dynamic> json) {
  return UploadStatusModel(
    outletId: json['outletId'] as int,
    outletName: json['outletName'] as String,
    synced: json['synced'] as int,
    imageStatus: json['imageStatus'] as int? ?? 0,
    requestStatus: json['requestStatus'] as int? ?? 0,
  );
}

Map<String, dynamic> _$UploadStatusModelToJson(UploadStatusModel instance) => <String, dynamic>{
  'outletId': instance.outletId,
  'outletName': instance.outletName,
  'synced': instance.synced,
  'imageStatus': instance.imageStatus,
  'requestStatus': instance.requestStatus,
};
