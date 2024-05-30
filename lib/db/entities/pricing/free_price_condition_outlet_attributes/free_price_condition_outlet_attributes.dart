import 'package:json_annotation/json_annotation.dart';

part 'free_price_condition_outlet_attributes.g.dart';

@JsonSerializable()
class FreePriceConditionOutletAttributes {
  @JsonKey(name: 'priceConditionOutletAttributeId')
  final int? priceConditionOutletAttributeId;

  @JsonKey(name: 'priceConditionId')
  final int? priceConditionId;

  @JsonKey(name: 'channelId')
  final int? channelId;

  @JsonKey(name: 'vpoClassificationId')
  final int? vpoClassificationId;

  @JsonKey(name: 'outletGroupId')
  final int? outletGroupId;

  @JsonKey(name: 'outletGroup2Id')
  final int? outletGroup2Id;

  @JsonKey(name: 'outletGroup3Id')
  final int? outletGroup3Id;

  @JsonKey(name: 'bundleId')
  final int? bundleId;

  @JsonKey(name: 'freeGoodId')
  final int? freeGoodId;

  FreePriceConditionOutletAttributes({
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

  factory FreePriceConditionOutletAttributes.fromJson(Map<String, dynamic> json) =>
      _$FreePriceConditionOutletAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$FreePriceConditionOutletAttributesToJson(this);
}
