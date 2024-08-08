import 'package:json_annotation/json_annotation.dart';

import '../../../../db/entities/pricing/price_condition_detail/price_condition_detail.dart';
import '../../../../db/entities/pricing/price_condition_scale/price_condition_scale.dart';

part 'price_condition_details_with_scale.g.dart';

@JsonSerializable()
class PriceConditionDetailsWithScale {
  @JsonKey(name: 'priceConditionDetail')
  PriceConditionDetail? priceConditionDetail;

  @JsonKey(name: 'priceConditionScaleList')
  List<PriceConditionScale?>? priceConditionScaleList;

  PriceConditionDetailsWithScale({
    this.priceConditionDetail,
    this.priceConditionScaleList,
  });

  factory PriceConditionDetailsWithScale.fromJson(Map<String, dynamic> json) =>
      _$PriceConditionDetailsWithScaleFromJson(json);

  Map<String, dynamic> toJson() => _$PriceConditionDetailsWithScaleToJson(this);
}

// To generate code for JSON serialization
// Run the command: flutter pub run build_runner build

