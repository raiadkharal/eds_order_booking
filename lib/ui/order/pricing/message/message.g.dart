// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';


Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    MessageSeverityLevel: json['MessageSeverityLevel'] as int?,
    MessageText: json['MessageText'] as String?,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) =>
    <String, dynamic>{
      'MessageSeverityLevel': instance.MessageSeverityLevel,
      'MessageText': instance.MessageText,
    };
