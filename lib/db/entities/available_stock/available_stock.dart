import 'package:json_annotation/json_annotation.dart';

part 'available_stock.g.dart';

@JsonSerializable()
class AvailableStock {
  @JsonKey(name: 'mobileAvlStockDetailId')
  final int? avlStockId;

  @JsonKey(name: 'productId')
  final int? productId;

  @JsonKey(name: 'packageId', includeIfNull: false)
  final int? packageId;

  @JsonKey(name: 'unitProductDefinitionId')
  final int? unitProductDefinitionId;

  @JsonKey(name: 'cartonProductDefinitionId')
  final int? cartonProductDefinitionId;

  @JsonKey(name: 'orderId', includeIfNull: false)
  final int? mOrderId;

  @JsonKey(name: 'outletId', includeIfNull: false)
  final int? outletId;

  @JsonKey(name: 'cartonQuantity')
  final int? cartonQuantity;

  @JsonKey(name: 'unitQuantity')
  final int? unitQuantity;

  AvailableStock({
    required this.avlStockId,
    required this.productId,
    required this.packageId,
    required this.unitProductDefinitionId,
    required this.cartonProductDefinitionId,
    required this.mOrderId,
    required this.outletId,
    required this.cartonQuantity,
    required this.unitQuantity,
  });

  factory AvailableStock.fromJson(Map<String, dynamic> json) => _$AvailableStockFromJson(json);
  Map<String, dynamic> toJson() => _$AvailableStockToJson(this);
}
