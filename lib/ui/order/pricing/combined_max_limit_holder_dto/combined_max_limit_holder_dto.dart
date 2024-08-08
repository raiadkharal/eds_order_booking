import 'package:json_annotation/json_annotation.dart';

part 'combined_max_limit_holder_dto.g.dart';

@JsonSerializable()
class CombinedMaxLimitHolderDTO {
  int? priceConditionId;
  int? packageId;
  double? availedAmount;
  int? availedQuantity;
  bool? isPriceConditionAppliedForTheFirstItem;

  CombinedMaxLimitHolderDTO({
    this.priceConditionId,
    this.packageId,
    this.availedAmount,
    this.availedQuantity,
    this.isPriceConditionAppliedForTheFirstItem,
  });

  factory CombinedMaxLimitHolderDTO.fromJson(Map<String, dynamic> json) => _$CombinedMaxLimitHolderDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CombinedMaxLimitHolderDTOToJson(this);
}
