import 'package:json_annotation/json_annotation.dart';

part 'configurations_model.g.dart';

@JsonSerializable()
class ConfigurationModel {
  @JsonKey(name: 'endDayOnPjpCompletion')
  bool? _endDayOnPjpCompletion;

  @JsonKey(name: 'geoFenceMinRadius')
  int? _geoFenceMinRadius;

  @JsonKey(name: 'geoFenceRequired')
  bool? _geoFenceRequired;

  @JsonKey(name: 'tenantId')
  int? _tenantId;

  @JsonKey(name: 'taskExists')
  bool? _taskExists;

  ConfigurationModel();

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

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);
}
