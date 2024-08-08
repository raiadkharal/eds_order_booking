import 'package:json_annotation/json_annotation.dart';

part 'product_stock_in_hand.g.dart';

@JsonSerializable()
class ProductStockInHand {
  @JsonKey(name: 'pk_pid')
  final int pkPid;

  @JsonKey(name: 'unitStockInHand')
  final int unitStockInHand;

  @JsonKey(name: 'cartonStockInHand')
  final int cartonStockInHand;

  ProductStockInHand({
    required this.pkPid,
    required this.unitStockInHand,
    required this.cartonStockInHand,
  });

  // Factory constructor for creating a new instance from a map.
  factory ProductStockInHand.fromJson(Map<String, dynamic> json) => _$ProductStockInHandFromJson(json);

  // Method for converting an instance to a map.
  Map<String, dynamic> toJson() => _$ProductStockInHandToJson(this);
}
