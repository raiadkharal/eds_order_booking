// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUpdateModel _$AppUpdateModelFromJson(Map<String, dynamic> json) =>
    AppUpdateModel(
      file: json['file'] as String?,
      version: json['version'] as int?,
      date: json['date'] as int?,
      msg: json['error_msg'] as String?,
    );

Map<String, dynamic> _$AppUpdateModelToJson(AppUpdateModel instance) =>
    <String, dynamic>{
      'file': instance.file,
      'version': instance.version,
      'date': instance.date,
      'error_msg': instance.msg,
    };
