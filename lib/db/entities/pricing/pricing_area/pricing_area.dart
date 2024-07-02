import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/utils/utils.dart';

part 'pricing_area.g.dart';

@JsonSerializable()
class PricingArea {
  @JsonKey(name: 'PricingAreaId')
  final int pricingAreaId;

  @JsonKey(name: 'Code')
  final String code;

  @JsonKey(name: 'Order')
  final int? order;

  @JsonKey(name: 'Name')
  final String? name;

  @JsonKey(name: 'IsActive',toJson: boolToInt,fromJson: boolFromInt)
  final bool? isActive;

  PricingArea({
    required this.pricingAreaId,
    required this.code,
    this.order,
    this.name,
    this.isActive,
  });

  factory PricingArea.fromJson(Map<String, dynamic> json) => _$PricingAreaFromJson(json);

  Map<String, dynamic> toJson() => _$PricingAreaToJson(this);
}
