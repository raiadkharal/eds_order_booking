import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/utils/utils.dart';

part 'carton_price_breakdown.g.dart';

@JsonSerializable()
class CartonPriceBreakDown {
  @JsonKey(name: 'pk_cpbd')
  final int? id;

  @JsonKey(name: 'orderId')
  final int? orderId;

  @JsonKey(name: 'mobileOrderDetailId')
  final int? orderDetailId;

  @JsonKey(name: 'priceCondition')
  final String? priceCondition;

  @JsonKey(name: 'priceConditionType')
  String? priceConditionType;

  @JsonKey(name: 'priceConditionClass')
  final String? priceConditionClass;

  @JsonKey(name: 'priceConditionClassOrder')
  int? priceConditionClassOrder;

  @JsonKey(name: 'priceConditionId')
  final int? priceConditionId;

  @JsonKey(name: 'priceConditionDetailId')
  final int? priceConditionDetailId;

  @JsonKey(name: 'accessSequence')
  final String? accessSequence;

  @JsonKey(name: 'unitPrice')
  final double? unitPrice;

  @JsonKey(name: 'blockPrice')
  final double? blockPrice;

  @JsonKey(name: 'totalPrice')
  final double? totalPrice;

  @JsonKey(name: 'calculationType')
  final int? calculationType;

  @JsonKey(name: 'outletId')
  final int? outletId;

  @JsonKey(name: 'productId')
  final int? productId;

  @JsonKey(name: 'productDefinitionId')
  final int? productDefinitionId;

  @JsonKey(name: 'isMaxLimitReached',toJson: boolToInt,fromJson: boolFromInt)
  final bool? isMaxLimitReached;

  @JsonKey(name: 'maximumLimit')
  final double? maximumLimit;

  @JsonKey(name: 'alreadyAvailed')
  final double? alreadyAvailed;

  @JsonKey(name: 'limitBy')
  final int? limitBy;

  CartonPriceBreakDown({
    this.id,
    this.orderId,
    this.orderDetailId,
    this.priceCondition,
    this.priceConditionType,
    this.priceConditionClass,
    this.priceConditionClassOrder,
    this.priceConditionId,
    this.priceConditionDetailId,
    this.accessSequence,
    this.unitPrice,
    this.blockPrice,
    this.totalPrice,
    this.calculationType,
    this.outletId,
    this.productId,
    this.productDefinitionId,
    this.isMaxLimitReached,
    this.maximumLimit,
    this.alreadyAvailed,
    this.limitBy,
  });

  factory CartonPriceBreakDown.fromJson(Map<String, dynamic> json) =>
      _$CartonPriceBreakDownFromJson(json);
  Map<String, dynamic> toJson() => _$CartonPriceBreakDownToJson(this);
}
