import 'package:json_annotation/json_annotation.dart';

part 'promotion.g.dart';

@JsonSerializable()
class Promotion {
  @JsonKey(name: 'promotionId')
  int? promotionId;

  int? outletId;
  int? priceConditionId;
  int? detailId;
  String? name;
  double? amount;
  String? calculationType;
  int? freeGoodId;
  String? freeGoodName;
  String? freeGoodSize;
  String? size;
  String? promoOrFreeGoodType;
  int? freeGoodQuantity;

  Promotion({
    this.promotionId,
    this.outletId,
    this.priceConditionId,
    this.detailId,
    this.name,
    this.amount,
    this.calculationType,
    this.freeGoodId,
    this.freeGoodName,
    this.freeGoodSize,
    this.size,
    this.promoOrFreeGoodType,
    this.freeGoodQuantity,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionToJson(this);
}
