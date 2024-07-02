import 'package:json_annotation/json_annotation.dart';

part 'outlet_availed_free_goods.g.dart';

@JsonSerializable()
class OutletAvailedFreeGoods {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'outletId')
  final int? outletId;

  @JsonKey(name: 'freeGoodGroupId')
  final int? freeGoodGroupId;

  @JsonKey(name: 'freeGoodDetailId')
  final int? freeGoodDetailId;

  @JsonKey(name: 'freeGoodExclusiveId')
  final int? freeGoodExclusiveId;

  @JsonKey(name: 'quantity')
  final int? quantity;

  @JsonKey(name: 'productId')
  final int? productId;

  @JsonKey(name: 'productDefinitionId')
  final int? productDefinitionId;

  @JsonKey(name: 'orderId')
  final int? orderId;

  @JsonKey(name: 'invoiceId')
  final int? invoiceId;

  OutletAvailedFreeGoods({
    this.id,
    this.outletId,
    this.freeGoodGroupId,
    this.freeGoodDetailId,
    this.freeGoodExclusiveId,
    this.quantity,
    this.productId,
    this.productDefinitionId,
    this.orderId,
    this.invoiceId,
  });

  factory OutletAvailedFreeGoods.fromJson(Map<String, dynamic> json) =>
      _$OutletAvailedFreeGoodsFromJson(json);

  Map<String, dynamic> toJson() => _$OutletAvailedFreeGoodsToJson(this);
}
