import 'package:json_annotation/json_annotation.dart';

import '../../../../db/entities/pricing/price_condition/price_condition.dart';

part 'price_condtition_with_access_sequence.g.dart';

@JsonSerializable()
class PriceConditionWithAccessSequence extends PriceCondition {
  @JsonKey(name: 'sequenceCode')
  final String? sequenceCode;

  @JsonKey(name: 'sequenceName')
  final String? sequenceName;

  @JsonKey(name: 'priceAccessSequenceId')
  final int? priceAccessSequenceId;

  @JsonKey(name: 'order')
  final int? order;

  @JsonKey(name: 'pricingLevelId')
  final int? pricingLevelId;

  @JsonKey(name: 'accessSequenceName')
  final String? accessSequenceName;

  @JsonKey(name: 'accessSequenceCode')
  final String? accessSequenceCode;

  @JsonKey(name: 'accessSequenceOrder')
  final int? accessSequenceOrder;

  @JsonKey(name: 'conditionTypeId')
  final int? conditionTypeId;

  @JsonKey(name: 'channelAttributeCount', defaultValue: 0)
  final int? ChannelAttributeCount;

  @JsonKey(name: 'outletChannelAttribute', defaultValue: 0)
  final int? OutletChannelAttribute;

  @JsonKey(name: 'groupAttributeCount', defaultValue: 0)
  final int? GroupAttributeCount;

  @JsonKey(name: 'outletGroupAttribute', defaultValue: 0)
  final int? OutletGroupAttribute;

  @JsonKey(name: 'vpoClassificationAttributeCount', defaultValue: 0)
  final int? VPOClassificationAttributeCount;

  @JsonKey(name: 'outletVPOClassificationAttributeCount', defaultValue: 0)
  final int? OutletVPOClassificationAttributeCount;

  @JsonKey(name: 'bundleId')
  final int? bundleId;

  PriceConditionWithAccessSequence({
    this.sequenceCode,
    this.sequenceName,
    this.priceAccessSequenceId,
    this.order,
    this.pricingLevelId,
    this.accessSequenceName,
    this.accessSequenceCode,
    this.accessSequenceOrder,
    this.conditionTypeId,
    this.ChannelAttributeCount = 0,
    this.OutletChannelAttribute = 0,
    this.GroupAttributeCount = 0,
    this.OutletGroupAttribute = 0,
    this.VPOClassificationAttributeCount = 0,
    this.OutletVPOClassificationAttributeCount = 0,
    this.bundleId,
    super.priceConditionTypeId,
    super.accessSequenceId,
    super.priceConditionId,
    super.name,
  });

  // Generated factory and toJson methods for JSON serialization
  factory PriceConditionWithAccessSequence.fromJson(
      Map<String, dynamic> json) =>
      _$PriceConditionWithAccessSequenceFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PriceConditionWithAccessSequenceToJson(this);
}