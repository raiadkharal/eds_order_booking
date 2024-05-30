import 'package:json_annotation/json_annotation.dart';

import 'dart:convert';

part 'price_condtition_availed.g.dart';

@JsonSerializable()
class PriceConditionAvailed {

  @JsonKey(name: 'priceConditionAvailedId')
  final int priceConditionAvailedId;

  @JsonKey(name: 'outletId')
  final int outletId;

  @JsonKey(name: 'productDefinitionId')
  final int productDefinitionId;

  @JsonKey(name: 'productId')
  final int productId;

  @JsonKey(name: 'amount')
  final double? amount;

  @JsonKey(name: 'quantity')
  final int? quantity;

  PriceConditionAvailed({
    required this.priceConditionAvailedId,
    required this.outletId,
    required this.productDefinitionId,
    required this.productId,
    this.amount,
    this.quantity,
  });

  factory PriceConditionAvailed.fromJson(Map<String, dynamic> json) =>
      _$PriceConditionAvailedFromJson(json);

  Map<String, dynamic> toJson() => _$PriceConditionAvailedToJson(this);
}
