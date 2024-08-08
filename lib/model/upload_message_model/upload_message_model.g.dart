// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadMessageModel _$UploadMessageModelFromJson(Map<String, dynamic> json) => UploadMessageModel(
  message: json['message'] as String?,
  title: json['title'] as String?,
  subMessage: json['subMessage'] as String?,
  maxValue: json['maxValue'] as int?,
  value: json['value'] as int?,
  visible: json['visible'] as bool?,
  isMessageRead: json['isMessageRead'] as bool? ?? false,
);

Map<String, dynamic> _$UploadMessageModelToJson(UploadMessageModel instance) => <String, dynamic>{
  'message': instance.message,
  'title': instance.title,
  'subMessage': instance.subMessage,
  'maxValue': instance.maxValue,
  'value': instance.value,
  'visible': instance.visible,
  'isMessageRead': instance.isMessageRead,
};
