import 'package:json_annotation/json_annotation.dart';

import '../../../utils/utils.dart';

part 'configurations.g.dart';

@JsonSerializable()
class Configuration {
  @JsonKey(name: 'endDayOnPjpCompletion',toJson:boolToInt)
  bool? _endDayOnPjpCompletion;

  @JsonKey(name: 'geoFenceMinRadius')
  int? _geoFenceMinRadius;

  @JsonKey(name: 'geoFenceRequired',toJson:boolToInt)
  bool? _geoFenceRequired;

  @JsonKey(name: 'tenantId')
  int? _tenantId;

  @JsonKey(name: 'taskExists',toJson:boolToInt)
  bool? _taskExists;

  Configuration();

  bool? get endDayOnPjpCompletion => _endDayOnPjpCompletion ?? true;

  set endDayOnPjpCompletion(bool? value) {
    _endDayOnPjpCompletion = value;
  }

  int get geoFenceMinRadius => _geoFenceMinRadius ?? 50;

  set geoFenceMinRadius(int? value) {
    _geoFenceMinRadius = value;
  }

  bool get geoFenceRequired => _geoFenceRequired ?? false;

  set geoFenceRequired(bool? value) {
    _geoFenceRequired = value;
  }

  bool get taskExists => _taskExists ?? false;

  set taskExists(bool? value) {
    _taskExists = value;
  }

  int get tenantId => _tenantId ?? 1;

  set tenantId(int? value) {
    _tenantId = value;
  }

  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);
}
