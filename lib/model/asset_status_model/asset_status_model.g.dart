// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetStatusModel _$AssetStatusFromJson(Map<String, dynamic> json) {
  return AssetStatusModel(
    key: json['key'] as int?,
    value: json['value'] as String?,
    description: json['description'] as String?,
    firstIntExtraField: json['firstIntExtraField'] as int?,
    firstStringExtraField: json['firstStringExtraField'] as String?,
    defaultFlag: json['defaultFlag'] as bool?,
    secondIntExtraField: json['secondIntExtraField'] as int?,
    secondStringExtraField: json['secondStringExtraField'] as String?,
    hasError: json['hasError'] as bool?,
    errorMessage: json['errorMessage'] as String?,
  );
}

Map<String, dynamic> _$AssetStatusToJson(AssetStatusModel instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'description': instance.description,
      'firstIntExtraField': instance.firstIntExtraField,
      'firstStringExtraField': instance.firstStringExtraField,
      'defaultFlag': boolToInt(instance.defaultFlag),
      'secondIntExtraField': instance.secondIntExtraField,
      'secondStringExtraField': instance.secondStringExtraField,
      'hasError': boolToInt(instance.hasError),
      'errorMessage': instance.errorMessage,
    };