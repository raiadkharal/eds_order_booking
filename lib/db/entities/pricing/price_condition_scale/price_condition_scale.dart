import 'package:json_annotation/json_annotation.dart';

part 'price_condition_scale.g.dart';

@JsonSerializable()
class PriceConditionScale {
  @JsonKey(name: 'priceConditionScaleId')
  final int priceConditionScaleId;
  final int? from;
  @JsonKey(name: "amount")
  final double amount;
  final int priceConditionDetailId;
  final double? cartonAmount;

  PriceConditionScale({
    required this.priceConditionScaleId,
    this.from,
    required this.amount,
    required this.priceConditionDetailId,
    this.cartonAmount,
  });

  factory PriceConditionScale.fromJson(Map<String, dynamic> json) =>
      _$PriceConditionScaleFromJson(json);

  Map<String, dynamic> toJson() => _$PriceConditionScaleToJson(this);

}
