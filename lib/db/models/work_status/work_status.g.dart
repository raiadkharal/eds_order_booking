// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkStatus _$WorkStatusFromJson(Map<String, dynamic> json) => WorkStatus(
      json['dayStarted'] as int,
    )..syncDate = json['syncDate'] as int;

Map<String, dynamic> _$WorkStatusToJson(WorkStatus instance) =>
    <String, dynamic>{
      'syncDate': instance.syncDate,
      'dayStarted': instance.dayStarted,
    };
