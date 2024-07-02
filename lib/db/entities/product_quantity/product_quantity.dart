import 'package:json_annotation/json_annotation.dart';

part 'product_quantity.g.dart';

@JsonSerializable()
class ProductQuantity {
  @JsonKey(name: 'ProductDefinitionId')
  int? productDefinitionId;

  @JsonKey(name: 'Quantity')
  int? quantity;

  @JsonKey(name: 'packageId')
  int? packageId;

  ProductQuantity({this.productDefinitionId, required this.quantity, this.packageId});

  factory ProductQuantity.fromJson(Map<String, dynamic> json) => _$ProductQuantityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductQuantityToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ProductQuantity && runtimeType == other.runtimeType && productDefinitionId == other.productDefinitionId;

  @override
  int get hashCode => productDefinitionId.hashCode;
}
