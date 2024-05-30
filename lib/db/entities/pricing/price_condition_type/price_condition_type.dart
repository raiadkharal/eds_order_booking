import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/utils/util.dart';

part 'price_condition_type.g.dart';

@JsonSerializable()
class PriceConditionType {
  @JsonKey(name: 'priceConditionTypeId')
  final int priceConditionTypeId;
  final String? name;
  @JsonKey(name: 'priceConditionClassId')
  final int priceConditionClassId;
  final int operationType;
  final int calculationType;
  final int roundingRule;
  @JsonKey(name: 'priceScaleBasisId')
  final int? priceScaleBasisId;
  final String? code;
  final int? conditionClassId;
  final int? pricingType;
  final int? processingOrder;
  final int? pcDefinitionLevelId;
  @JsonKey(name: 'isPromo',toJson: boolToInt,fromJson: boolFromInt)
  final bool? isPromo;
  @JsonKey(name: 'isLRB',toJson: boolToInt,fromJson: boolFromInt)
  final bool? isLRB;

  PriceConditionType({
    required this.priceConditionTypeId,
    this.name,
    required this.priceConditionClassId,
    required this.operationType,
    required this.calculationType,
    required this.roundingRule,
    this.priceScaleBasisId,
    this.code,
    this.conditionClassId,
    this.pricingType,
    this.processingOrder,
    this.pcDefinitionLevelId,
    this.isPromo,
    this.isLRB,
  });

  factory PriceConditionType.fromJson(Map<String, dynamic> json) =>
      _$PriceConditionTypeFromJson(json);

  Map<String, dynamic> toJson() => _$PriceConditionTypeToJson(this);
}
