import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/utils/utils.dart';

part 'asset_status.g.dart';

@JsonSerializable()
class AssetStatus {
  @JsonKey(name: 'key')
  final int? key;
  @JsonKey(name: 'value')
  final String? value;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'firstIntExtraField')
  final int? firstIntExtraField;
  @JsonKey(name: 'firstStringExtraField')
  final String? firstStringExtraField;
  @JsonKey(name: 'defaultFlag',toJson: boolToInt,fromJson: boolFromInt)
  final bool? defaultFlag;
  @JsonKey(name: 'secondIntExtraField')
  final int? secondIntExtraField;
  @JsonKey(name: 'secondStringExtraField')
  final String? secondStringExtraField;
  @JsonKey(name: 'hasError',toJson: boolToInt,fromJson: boolFromInt)
  final bool? hasError;
  @JsonKey(name: 'errorMessage')
  final String? errorMessage;

  AssetStatus({
    this.key,
    this.value,
    this.description,
    this.firstIntExtraField,
    this.firstStringExtraField,
    this.defaultFlag,
    this.secondIntExtraField,
    this.secondStringExtraField,
    this.hasError,
    this.errorMessage,
  });

  factory AssetStatus.fromJson(Map<String, dynamic> json) =>
      _$AssetStatusFromJson(json);

  Map<String, dynamic> toJson() => _$AssetStatusToJson(this);

  @override
  String toString() => value ?? '';
}
