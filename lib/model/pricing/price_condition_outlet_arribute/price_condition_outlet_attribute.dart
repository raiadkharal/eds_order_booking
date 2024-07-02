import 'package:json_annotation/json_annotation.dart';

part 'price_condition_outlet_attribute.g.dart';

@JsonSerializable()
class PriceConditionOutletAttribute {
  @JsonKey(name: 'priceConditionOutletAttributeId')
  final int? priceConditionOutletAttributeId;
  final int? priceConditionId;
  final int? channelId;
  final int? vpoClassificationId;
  final int? outletGroupId;
  final int? outletGroup2Id;
  final int? outletGroup3Id;
  final int? bundleId;
  final int? freeGoodId;

  PriceConditionOutletAttribute({
    this.priceConditionOutletAttributeId,
    this.priceConditionId,
    this.channelId,
    this.vpoClassificationId,
    this.outletGroupId,
    this.outletGroup2Id,
    this.outletGroup3Id,
    this.bundleId,
    this.freeGoodId,
  });

  factory PriceConditionOutletAttribute.fromJson(Map<String, dynamic> json) =>
      _$PriceConditionOutletAttributeFromJson(json);

  Map<String, dynamic> toJson() => _$PriceConditionOutletAttributeToJson(this);
}
