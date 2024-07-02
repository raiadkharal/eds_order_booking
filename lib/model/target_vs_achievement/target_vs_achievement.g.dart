// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target_vs_achievement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TargetVsAchievement _$TargetVsAchievementFromJson(Map<String, dynamic> json) {
  return TargetVsAchievement(
    targetQuantity: json['targetQuantity'] as int?,
    targetAmount: json['targetAmount'] as int?,
    achievedQuantityPercentage: (json['achievedQuantityPercentage'] as num?)?.toDouble(),
    mtdSaleQuantity: json['mtdSaleQuantiy'] as int?,
    achievedAmountPercentage: (json['achievedAmountPercentage'] as num?)?.toDouble(),
    perDayRequiredSaleQuantity: (json['perDayRequiredSaleQuantiy'] as num?)?.toDouble(),
    perDayRequiredSaleAmount: (json['perDayRequiredSaleAmount'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$TargetVsAchievementToJson(TargetVsAchievement instance) => <String, dynamic>{
  'targetQuantity': instance.targetQuantity,
  'targetAmount': instance.targetAmount,
  'achievedQuantityPercentage': instance.achievedQuantityPercentage,
  'mtdSaleQuantiy': instance.mtdSaleQuantity,
  'achievedAmountPercentage': instance.achievedAmountPercentage,
  'perDayRequiredSaleQuantiy': instance.perDayRequiredSaleQuantity,
  'perDayRequiredSaleAmount': instance.perDayRequiredSaleAmount,
};
