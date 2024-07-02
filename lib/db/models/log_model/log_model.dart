import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/db/models/base_response/base_response.dart';

import '../device_info_model/device_info_model.dart';

part 'log_model.g.dart';

@JsonSerializable()
class LogModel extends BaseResponse {
  @JsonKey(name: 'distributionId')
  int? distributionId;

  @JsonKey(name: 'operationTypeId')
  int? operationTypeId;

  @JsonKey(name: 'salesmanId')
  int? salesmanId;

  @JsonKey(name: 'startDay')
  int? startDay;

  @JsonKey(name: 'appVersion')
  int? appVersion;

  @JsonKey(name: 'deviceInfo')
  List<DeviceInfoModel>? deviceInfo;

  LogModel({
    this.distributionId,
    this.operationTypeId,
    this.salesmanId,
    this.startDay,
    this.appVersion,
    this.deviceInfo,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) => _$LogModelFromJson(json);

  Map<String, dynamic> toJson() => _$LogModelToJson(this);
}
