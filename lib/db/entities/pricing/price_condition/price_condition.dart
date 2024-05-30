import 'package:json_annotation/json_annotation.dart';

import '../price_condition_detail/price_condition_detail.dart';
import '../price_condition_entities/price_condition_entities.dart';

part 'price_condition.g.dart';

@JsonSerializable()
class PriceCondition {

  final int priceConditionId;

  final String name;

  final bool? isBundle;
  final int? pricingType;
  final String? validFrom;
  final String? validTo;
  final int? entityGroupById;
  final int? organizationId;
  final int? distributionId;
  final double? combinedMaxValueLimit;
  final double? combinedMaxCaseLimit;
  final int? combinedLimitBy;
  final int? customerRegistrationTypeId;
  final int priceConditionTypeId;
  final int accessSequenceId;

  @JsonKey(ignore: true)
  final List<PriceConditionEntities>? priceConditionEntities;

  @JsonKey(ignore: true)
  final List<PriceConditionDetail>? priceConditionDetails;


  PriceCondition({
    required this.priceConditionTypeId,
    required this.accessSequenceId,
    required this.priceConditionId,
    required this.name,
    this.isBundle,
    this.pricingType,
    this.validFrom,
    this.validTo,
    this.entityGroupById,
    this.organizationId,
    this.distributionId,
    this.combinedMaxValueLimit,
    this.combinedMaxCaseLimit,
    this.combinedLimitBy,
    this.customerRegistrationTypeId,
    this.priceConditionEntities,
    this.priceConditionDetails,
  });

  factory PriceCondition.fromJson(Map<String, dynamic> json) =>
      _$PriceConditionFromJson(json);

  Map<String, dynamic> toJson() => _$PriceConditionToJson(this);
}
