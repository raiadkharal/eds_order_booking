import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/model/pricing/price_condition_detail_model/price_condition_detail_model.dart';
import 'package:order_booking/model/pricing/price_condition_entities_model/price_condition_entities_model.dart';
import 'package:order_booking/utils/utils.dart';
part 'price_condition_model.g.dart';

@JsonSerializable()
class PriceConditionModel {

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
  final List<PriceConditionEntitiesModel>? priceConditionEntities;

  @JsonKey(ignore: true)
  final List<PriceConditionDetailModel>? priceConditionDetails;


  PriceConditionModel({
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

  factory PriceConditionModel.fromJson(Map<String, dynamic> json) =>
      _$PriceConditionFromJson(json);

  Map<String, dynamic> toJson() => _$PriceConditionToJson(this);
}
