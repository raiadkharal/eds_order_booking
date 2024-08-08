import 'package:json_annotation/json_annotation.dart';

part 'available_stock.g.dart';

@JsonSerializable()
class AvailableStock {
  @JsonKey(name: 'mobileAvlStockDetailId')
  int? avlStockId;

  @JsonKey(name: 'productId')
  int? productId;

  @JsonKey(name: 'packageId', includeIfNull: false)
  int? packageId;

  @JsonKey(name: 'unitProductDefinitionId')
  int? unitProductDefinitionId;

  @JsonKey(name: 'cartonProductDefinitionId')
  int? cartonProductDefinitionId;

  @JsonKey(name: 'orderId', includeIfNull: false)
  int? mOrderId;

  @JsonKey(name: 'outletId', includeIfNull: false)
  int? outletId;

  @JsonKey(name: 'cartonQuantity')
  int? cartonQuantity;

  @JsonKey(name: 'unitQuantity')
  int? unitQuantity;

  AvailableStock({
    this.avlStockId,
    this.productId,
    this.packageId,
    this.unitProductDefinitionId,
    this.cartonProductDefinitionId,
    this.mOrderId,
    this.outletId,
    this.cartonQuantity,
    this.unitQuantity,
  });

  factory AvailableStock.fromJson(Map<String, dynamic> json) => _$AvailableStockFromJson(json);
  Map<String, dynamic> toJson() => _$AvailableStockToJson(this);
}
