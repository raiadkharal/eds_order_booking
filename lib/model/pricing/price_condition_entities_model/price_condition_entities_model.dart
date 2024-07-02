import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/utils/utils.dart';

part 'price_condition_entities_model.g.dart';

@JsonSerializable()
class PriceConditionEntitiesModel {

  @JsonKey(name: "priceConditionEntityId")
  final int priceConditionEntityId;

  @JsonKey(name: "priceConditionId")
  final int? priceConditionId;

  @JsonKey(name: "outletId")
  final int? outletId;

  @JsonKey(name: "routeId")
  final int? routeId;

  @JsonKey(name: "distributionId")
  final int? distributionId;

  @JsonKey(name: "bundleId")
  final int? bundleId;

  @JsonKey(name: "isDeleted")
  final bool? isDeleted;

  PriceConditionEntitiesModel({
    required this.priceConditionEntityId,
    required this.priceConditionId,
    this.outletId,
    this.routeId,
    this.distributionId,
    this.bundleId,
    this.isDeleted,
  });

  factory PriceConditionEntitiesModel.fromJson(Map<String, dynamic> json) =>
      _$PriceConditionEntitiesFromJson(json);

  Map<String, dynamic> toJson() => _$PriceConditionEntitiesToJson(this);
}
