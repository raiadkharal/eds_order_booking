import 'package:json_annotation/json_annotation.dart';

part 'target_vs_achievement.g.dart';

@JsonSerializable()
class TargetVsAchievement {
  @JsonKey(name: 'targetQuantity')
  final int? targetQuantity;

  @JsonKey(name: 'targetAmount')
  final int? targetAmount;

  @JsonKey(name: 'achievedQuantityPercentage')
  final double? achievedQuantityPercentage;

  @JsonKey(name: 'mtdSaleQuantiy')
  final int? mtdSaleQuantity;

  @JsonKey(name: 'achievedAmountPercentage')
  final double? achievedAmountPercentage;

  @JsonKey(name: 'perDayRequiredSaleQuantiy')
  final double? perDayRequiredSaleQuantity;

  @JsonKey(name: 'perDayRequiredSaleAmount')
  final double? perDayRequiredSaleAmount;

  TargetVsAchievement({
    this.targetQuantity,
    this.targetAmount,
    this.achievedQuantityPercentage,
    this.mtdSaleQuantity,
    this.achievedAmountPercentage,
    this.perDayRequiredSaleQuantity,
    this.perDayRequiredSaleAmount,
  });

  // A factory method for creating a new instance from a map.
  factory TargetVsAchievement.fromJson(Map<String, dynamic> json) => _$TargetVsAchievementFromJson(json);

  // A method for converting an instance into a map.
  Map<String, dynamic> toJson() => _$TargetVsAchievementToJson(this);
}
