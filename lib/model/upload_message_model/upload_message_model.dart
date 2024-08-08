import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'upload_message_model.g.dart';

@JsonSerializable()
class UploadMessageModel {
  String? message;
  String? title;
  String? subMessage;
  int? maxValue;
  int? value;
  bool? visible;
  bool? isMessageRead;

  UploadMessageModel({
    this.message,
    this.title,
    this.subMessage,
    this.maxValue,
    this.value,
    this.visible,
    this.isMessageRead = false,
  });

  factory UploadMessageModel.fromJson(Map<String, dynamic> json) => _$UploadMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$UploadMessageModelToJson(this);
}
