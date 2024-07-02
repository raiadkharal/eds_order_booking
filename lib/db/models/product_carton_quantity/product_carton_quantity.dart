import 'package:json_annotation/json_annotation.dart';

part 'product_carton_quantity.g.dart';

@JsonSerializable()
class ProductCartonQty {
  @JsonKey(name: 'pk_pid')
  final int? pkPid;

  @JsonKey(name: 'cartonQuantity')
  final int? cartonQuantity;

  ProductCartonQty({this.pkPid, this.cartonQuantity});

  // Factory method to create an instance from JSON
  factory ProductCartonQty.fromJson(Map<String, dynamic> json) =>
      _$ProductCartonQtyFromJson(json);

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() => _$ProductCartonQtyToJson(this);
}
