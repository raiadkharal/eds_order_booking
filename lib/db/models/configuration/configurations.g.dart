// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configurations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Configuration _$ConfigurationFromJson(Map<String, dynamic> json) =>
    Configuration()
      ..endDayOnPjpCompletion = json['endDayOnPjpCompletion'] as bool?
      ..geoFenceMinRadius = json['geoFenceMinRadius'] as int?
      ..geoFenceRequired = json['geoFenceRequired'] as bool?
      ..taskExists = json['taskExists'] as bool?
      ..tenantId = json['tenantId'] as int?;

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) =>
    <String, dynamic>{
      'endDayOnPjpCompletion': instance.endDayOnPjpCompletion,
      'geoFenceMinRadius': instance.geoFenceMinRadius,
      'geoFenceRequired': instance.geoFenceRequired,
      'taskExists': instance.taskExists,
      'tenantId': instance.tenantId,
    };
