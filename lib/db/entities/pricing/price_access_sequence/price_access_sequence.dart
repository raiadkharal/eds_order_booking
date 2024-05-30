import 'package:json_annotation/json_annotation.dart';

part 'price_access_sequence.g.dart';

@JsonSerializable()
class PriceAccessSequence {
  @JsonKey(name: 'priceAccessSequenceId')
  final int priceAccessSequenceId;

  @JsonKey(name: 'sequenceCode')
  final String? sequenceCode;

  @JsonKey(name: 'sequenceName')
  final String? sequenceName;

  @JsonKey(name: 'order')
  final int order;

  @JsonKey(name: 'pricingLevelId')
  final int? pricingLevelId;

  @JsonKey(name: 'pricingTypeId')
  final int? pricingTypeId;

  PriceAccessSequence({
    required this.priceAccessSequenceId,
    this.sequenceCode,
    this.sequenceName,
    required this.order,
    this.pricingLevelId,
    this.pricingTypeId,
  });

  factory PriceAccessSequence.fromJson(Map<String, dynamic> json) =>
      _$PriceAccessSequenceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceAccessSequenceToJson(this);
}
