import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/utils/utils.dart';

part 'price_condition_detail_model.g.dart';

@JsonSerializable()
class PriceConditionDetailModel {
  @JsonKey(name: 'priceConditionDetailId')
  final int? priceConditionDetailId;

  @JsonKey(name: 'amount')
  final double? amount;

  @JsonKey(name: 'isScale')
  final bool? isScale;

  @JsonKey(name: 'validFrom')
  final String? validFrom;

  @JsonKey(name: 'validTo')
  final String? validTo;

  @JsonKey(name: 'type')
  final int? type;

  @JsonKey(name: 'priceConditionId')
  final int? priceConditionId;

  @JsonKey(name: 'isDeleted')
  final bool? isDeleted;

  @JsonKey(name: 'productId')
  final int? productId;

  @JsonKey(name: 'productDefinitionId')
  final int? productDefinitionId;

  @JsonKey(name: 'outletId')
  final int? outletId;

  @JsonKey(name: 'routeId')
  final int? routeId;

  @JsonKey(name: 'distributionId')
  final int? distributionId;

  @JsonKey(name: 'minimumQuantity')
  final int? minimumQuantity;

  @JsonKey(name: 'maximumLimit')
  final double? maximumLimit;

  @JsonKey(name: 'limitBy')
  final int? limitBy;

  @JsonKey(name: 'cartonAmount')
  final double? cartonAmount;

  @JsonKey(name: 'packageId')
  final int? packageId;

  @JsonKey(name: 'bundleId')
  final int? bundleId;

  PriceConditionDetailModel({
    required this.priceConditionDetailId,
    required this.amount,
    required this.isScale,
    this.validFrom,
    this.validTo,
    required this.type,
    required this.priceConditionId,
    this.isDeleted,
    this.productId,
    this.productDefinitionId,
    this.outletId,
    this.routeId,
    this.distributionId,
    this.minimumQuantity,
    this.maximumLimit,
    this.limitBy,
    this.cartonAmount,
    this.packageId,
    this.bundleId,
  });

  factory PriceConditionDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PriceConditionDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PriceConditionDetailToJson(this);
}
