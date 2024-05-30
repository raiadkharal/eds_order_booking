import 'package:json_annotation/json_annotation.dart';

part 'pricing_levels.g.dart';

@JsonSerializable()
class PricingLevels {
  @JsonKey(name: 'pricingLevelId')
  final int? pricingLevelId;

  @JsonKey(name: 'value')
  final String? value;

  PricingLevels({
    this.pricingLevelId,
    this.value,
  });

  factory PricingLevels.fromJson(Map<String, dynamic> json) => _$PricingLevelsFromJson(json);

  Map<String, dynamic> toJson() => _$PricingLevelsToJson(this);
}
