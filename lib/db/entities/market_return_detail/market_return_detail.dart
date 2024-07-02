import 'package:json_annotation/json_annotation.dart';

part 'market_return_detail.g.dart';

@JsonSerializable()
class MarketReturnDetail {
  @JsonKey(name: 'return_id')
  int? returnId;

  @JsonKey(name: 'outletId')
  int? outletId;

  @JsonKey(name: 'productId')
  int? productId;

  @JsonKey(name: 'unitDefinitionId')
  int? unitDefinitionId;

  @JsonKey(name: 'cartonDefinitionId')
  int? cartonDefinitionId;

  @JsonKey(name: 'replacementProductId')
  int? replacementProductId;

  @JsonKey(name: 'replacementUnitDefinitionId')
  int? replacementUnitDefinitionId;

  @JsonKey(name: 'replacementCartonDefinitionId')
  int? replacementCartonDefinitionId;

  @JsonKey(name: 'marketReturnReasonId')
  int? marketReturnReasonId;

  @JsonKey(name: 'invoiceId')
  int? invoiceId;

  @JsonKey(name: 'cartonQuantity')
  int? cartonQuantity;

  @JsonKey(name: 'cartonQuantity')
  int? returnedProductTypeId;

  @JsonKey(name: 'unitQuantity')
  int? unitQuantity;

  @JsonKey(name: 'replaceWith')
  String? replaceWith;

  @JsonKey(name: 'replacementCartonQuantity')
  int? replacementCartonQuantity;

  @JsonKey(name: 'replacementUnitQuantity')
  int? replacementUnitQuantity;

  @JsonKey(name: 'cartonSize')
  int? cartonSize;

  @JsonKey(name: 'replacementCartonSize')
  int? replacementCartonSize;

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
    this.returnedProductTypeId,
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
