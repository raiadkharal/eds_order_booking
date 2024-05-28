import 'package:json_annotation/json_annotation.dart';

part 'market_return_detail.g.dart';

@JsonSerializable()
class MarketReturnDetail {
  @JsonKey(name: 'return_id')
  final int? returnId;

  @JsonKey(name: 'outletId')
  final int? outletId;

  @JsonKey(name: 'productId')
  final int? productId;

  @JsonKey(name: 'unitDefinitionId')
  final int? unitDefinitionId;

  @JsonKey(name: 'cartonDefinitionId')
  final int? cartonDefinitionId;

  @JsonKey(name: 'replacementProductId')
  final int? replacementProductId;

  @JsonKey(name: 'replacementUnitDefinitionId')
  final int? replacementUnitDefinitionId;

  @JsonKey(name: 'replacementCartonDefinitionId')
  final int? replacementCartonDefinitionId;

  @JsonKey(name: 'marketReturnReasonId')
  final int? marketReturnReasonId;

  @JsonKey(name: 'invoiceId')
  final int? invoiceId;

  @JsonKey(name: 'cartonQuantity')
  final int? cartonQuantity;

  @JsonKey(name: 'unitQuantity')
  final int? unitQuantity;

  @JsonKey(name: 'replaceWith')
  final String? replaceWith;

  @JsonKey(name: 'replacementCartonQuantity')
  final int? replacementCartonQuantity;

  @JsonKey(name: 'replacementUnitQuantity')
  final int? replacementUnitQuantity;

  @JsonKey(name: 'cartonSize')
  final int? cartonSize;

  @JsonKey(name: 'replacementCartonSize')
  final int? replacementCartonSize;

  MarketReturnDetail({
    this.returnId,
    this.outletId,
    this.productId,
    this.unitDefinitionId,
    this.cartonDefinitionId,
    this.replacementProductId,
    this.replacementUnitDefinitionId,
    this.replacementCartonDefinitionId,
    this.marketReturnReasonId,
    this.invoiceId,
    this.cartonQuantity,
    this.unitQuantity,
    this.replaceWith,
    this.replacementCartonQuantity,
    this.replacementUnitQuantity,
    this.cartonSize,
    this.replacementCartonSize,
  });

  factory MarketReturnDetail.fromJson(Map<String, dynamic> json) =>
      _$MarketReturnDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MarketReturnDetailToJson(this);
}
