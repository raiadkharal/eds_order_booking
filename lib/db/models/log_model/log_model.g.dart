// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogModel _$LogModelFromJson(Map<String, dynamic> json) => LogModel()
  ..errorMessage = json['errorMessage'] as String?
  ..success = json['success'] as String?
  ..errorCode = json['errorCode'] as int?
  ..distributionId = json['distributionId'] as int?
  ..operationTypeId = json['operationTypeId'] as int?
  ..salesmanId = json['salesmanId'] as int?
  ..startDay = json['startDay'] as int?
  ..appVersion = json['appVersion'] as int?
  ..deviceInfo = (json['deviceInfo'] as List<dynamic>?)
      ?.map((e) => DeviceInfoModel.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$LogModelToJson(LogModel instance) => <String, dynamic>{
  'errorMessage': instance.errorMessage,
  'success': instance.success,
  'errorCode': instance.errorCode,
  'distributionId': instance.distributionId,
  'operationTypeId': instance.operationTypeId,
  'salesmanId': instance.salesmanId,
  'startDay': instance.startDay,
  'appVersion': instance.appVersion,
  'deviceInfo': instance.deviceInfo?.map((e) => e.toJson()).toList(),
};
