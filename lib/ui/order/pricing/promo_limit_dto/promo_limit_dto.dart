import 'package:json_annotation/json_annotation.dart';

part 'promo_limit_dto.g.dart';

@JsonSerializable()
class PromoLimitDTO {
  @JsonKey(name: 'PriceConditionDetailId')
  int? priceConditionDetailId;

  @JsonKey(name: 'LimitBy')
  int? limitBy;

  @JsonKey(name: 'MaximumLimit')
  double? maximumLimit;

  @JsonKey(name: 'UnitPrice')
  double? unitPrice;

  // Default constructor with an optional UnitPrice
  PromoLimitDTO({
    this.priceConditionDetailId,
    this.limitBy,
    this.maximumLimit,
    double? unitPrice,
  }) : unitPrice = unitPrice ?? -1.0; // Default to -1

  // Named constructor for initializing with default UnitPrice
  PromoLimitDTO.withDefaultUnitPrice({
    required this.priceConditionDetailId,
    this.limitBy,
    required this.maximumLimit,
  }) : unitPrice = -1.0; // Default UnitPrice to -1

  // Factory method to create an instance from JSON
  factory PromoLimitDTO.fromJson(Map<String, dynamic> json) => _$PromoLimitDTOFromJson(json);

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() => _$PromoLimitDTOToJson(this);
}
