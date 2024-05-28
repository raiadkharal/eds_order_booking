import 'package:json_annotation/json_annotation.dart';

part 'outlet_availed_promotion.g.dart';

@JsonSerializable()
class OutletAvailedPromotion {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'outletId')
  final int? outletId;
  @JsonKey(name: 'priceConditionId')
  final int? priceConditionId;
  @JsonKey(name: 'priceConditionDetailId')
  final int? priceConditionDetailId;
  @JsonKey(name: 'quantity')
  final int? quantity;
  @JsonKey(name: 'amount')
  final double? amount;
  @JsonKey(name: 'productId')
  final int? productId;
  @JsonKey(name: 'productDefinitionId')
  final int? productDefinitionId;
  @JsonKey(name: 'packageId')
  final int? packageId;

  OutletAvailedPromotion({
    this.id,
    this.outletId,
    this.priceConditionId,
    this.priceConditionDetailId,
    this.quantity,
    this.amount,
    this.productId,
    this.productDefinitionId,
    this.packageId,
  });

  factory OutletAvailedPromotion.fromJson(Map<String, dynamic> json) =>
      _$OutletAvailedPromotionFromJson(json);

  Map<String, dynamic> toJson() => _$OutletAvailedPromotionToJson(this);
}
