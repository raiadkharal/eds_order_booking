import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/utils/utils.dart';

part 'price_condition_class.g.dart';

@JsonSerializable()
class PriceConditionClass {
  @JsonKey(name: 'priceConditionClassId')
  final int? priceConditionClassId;
  final String? name;
  final int? order;
  final int? severityLevel;
  @JsonKey(name: 'severityLevelMessage')
  final String? severityLevelMessage;
  @JsonKey(name: 'pricingAreaId')
  final int? pricingAreaId;
  @JsonKey(name: 'distributionId')
  final int? distributionId;
  @JsonKey(name: 'organizationId')
  final int? organizationId;
  @JsonKey(name: 'canLimit',toJson: boolToInt,fromJson: boolFromInt)
  final bool? canLimit;
  final String? code;
  @JsonKey(name: 'deriveFromConditionClassId')
  final int? deriveFromConditionClassId;

  PriceConditionClass({
    required this.priceConditionClassId,
    required this.name,
    required this.order,
    required this.severityLevel,
    required this.severityLevelMessage,
    required this.pricingAreaId,
    required this.distributionId,
    required this.organizationId,
    required this.canLimit,
    required this.code,
    required this.deriveFromConditionClassId,
  });

  factory PriceConditionClass.fromJson(Map<String, dynamic> json) =>
      _$PriceConditionClassFromJson(json);

  Map<String, dynamic> toJson() => _$PriceConditionClassToJson(this);
}
