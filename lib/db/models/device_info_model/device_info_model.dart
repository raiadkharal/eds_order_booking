import 'package:json_annotation/json_annotation.dart';

part 'device_info_model.g.dart';

@JsonSerializable()
class DeviceInfoModel {
  @JsonKey(name: 'key')
  String key;

  @JsonKey(name: 'value')
  String value;

  DeviceInfoModel({required this.key, required this.value});

  factory DeviceInfoModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceInfoModelToJson(this);
}
