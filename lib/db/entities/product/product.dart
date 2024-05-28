import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'productId')

  int id;

  String name;
  @JsonKey(name: 'productDescription')

  String description;
  @JsonKey(name: 'productCode')

  String code;
  @JsonKey(name: 'productGroupId')

  int groupId;
  @JsonKey(name: 'productGroupName')

  String groupName;
  @JsonKey(name: 'productPackageId')

  int packageId;
  @JsonKey(name: 'packageName')

  String packageName;
  @JsonKey(name: 'productBrandId')

  int brandId;
  @JsonKey(name: 'brandName')

  String brandName;
  @JsonKey(name: 'productFlavorId')

  int flavorId;
  @JsonKey(name: 'flavorName')

  String flavorName;
  @JsonKey(name: 'unitCode')

  String unitCode;
  @JsonKey(name: 'cartonCode')

  String cartonCode;
  @JsonKey(name: 'unitQuantity')

  int unitQuantity;
  @JsonKey(name: 'cartonQuantity')

  int cartonQuantity;
  @JsonKey(name: 'unitSizeForDisplay')

  String unitSizeForDisplay;
  @JsonKey(name: 'cartonSizeForDisplay')

  String cartonSizeForDisplay;
  @JsonKey(name: 'unitStockInHand')

  int unitStockInHand;
  @JsonKey(name: 'cartonStockInHand')

  int cartonStockInHand;
  @JsonKey(name: 'unitDefinitionId')

  int unitDefinitionId;
  @JsonKey(name: 'cartonDefinitionId')

  int cartonDefinitionId;
  @JsonKey(name: 'actualUnitStock')

  int actualUnitStock;
  @JsonKey(name: 'actualCartonStock')

  int actualCartonStock;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.code,
    required this.groupId,
    required this.groupName,
    required this.packageId,
    required this.packageName,
    required this.brandId,
    required this.brandName,
    required this.flavorId,
    required this.flavorName,
    required this.unitCode,
    required this.cartonCode,
    required this.unitQuantity,
    required this.cartonQuantity,
    required this.unitSizeForDisplay,
    required this.cartonSizeForDisplay,
    required this.unitStockInHand,
    required this.cartonStockInHand,
    required this.unitDefinitionId,
    required this.cartonDefinitionId,
    required this.actualUnitStock,
    required this.actualCartonStock,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
