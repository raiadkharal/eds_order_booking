import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/utils/utils.dart';

part 'price_bundle.g.dart';

@JsonSerializable()
class PriceBundle {
  @JsonKey(name: 'bundleId')
  final int bundleId;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'validFrom')
  final String? validFrom;

  @JsonKey(name: 'validTo')
  final String? validTo;

  @JsonKey(name: 'entityGroupById')
  final int? entityGroupById;

  @JsonKey(name: 'bundleMinimumQuantity')
  final int? bundleMinimumQuantity;

  @JsonKey(name: 'isDeleted',toJson: boolToInt,fromJson: boolFromInt)
  final bool? isDeleted;

  @JsonKey(name: 'priceConditionId')
  final int priceConditionId;

  PriceBundle({
    required this.bundleId,
    this.name,
    this.validFrom,
    this.validTo,
    this.entityGroupById,
    this.bundleMinimumQuantity,
    this.isDeleted,
    required this.priceConditionId,
  });

  factory PriceBundle.fromJson(Map<String, dynamic> json) =>
      _$PriceBundleFromJson(json);

  Map<String, dynamic> toJson() => _$PriceBundleToJson(this);
}
