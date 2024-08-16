import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'productId')
  int? id;

  String? productName;
  @JsonKey(name: 'productDescription')
  String? description;
  @JsonKey(name: 'productCode')
  String? code;
  @JsonKey(name: 'productGroupId')
  int? groupId;
  @JsonKey(name: 'productGroupName')
  String? groupName;
  @JsonKey(name: 'productPackageId')
  int? packageId;
  @JsonKey(name: 'packageName')
  String? packageName;
  @JsonKey(name: 'productBrandId')
  int? brandId;
  @JsonKey(name: 'brandName')
  String? brandName;
  @JsonKey(name: 'productFlavorId')
  int? flavorId;
  @JsonKey(name: 'flavorName')
  String? flavorName;
  @JsonKey(name: 'unitCode')
  String? unitCode;
  @JsonKey(name: 'cartonCode')
  String? cartonCode;
  @JsonKey(name: 'unitQuantity')
  int? unitQuantity;
  @JsonKey(name: 'cartonQuantity')
  int? cartonQuantity;
  @JsonKey(name: 'unitSizeForDisplay')
  String? unitSizeForDisplay;
  @JsonKey(name: 'cartonSizeForDisplay')
  String? cartonSizeForDisplay;
  @JsonKey(name: 'unitStockInHand')
  int? unitStockInHand;
  @JsonKey(name: 'cartonStockInHand')
  int? cartonStockInHand;
  @JsonKey(name: 'unitDefinitionId')
  int? unitDefinitionId;
  @JsonKey(name: 'cartonDefinitionId')
  int? cartonDefinitionId;
  @JsonKey(name: 'actualUnitStock')
  int? actualUnitStock;
  @JsonKey(name: 'actualCartonStock')
  int? actualCartonStock;
  @JsonKey(name: 'organizationId')
  int? organizationId;
  @JsonKey(name: 'qtyCarton')
  int? qtyCarton;
  @JsonKey(name: 'qtyUnit')
  int? qtyUnit;
  @JsonKey(name: 'avlStockUnit')
  int? avlStockUnit;
  @JsonKey(name: 'avlStockCarton')
  int? avlStockCarton;


  Product({
    this.id,
    this.productName,
    this.description,
    this.code,
    this.groupId,
    this.groupName,
    this.packageId,
    this.packageName,
    this.brandId,
    this.brandName,
    this.flavorId,
    this.flavorName,
    this.unitCode,
    this.cartonCode,
    this.unitQuantity,
    this.cartonQuantity,
    this.unitSizeForDisplay,
    this.cartonSizeForDisplay,
    this.unitStockInHand,
    this.cartonStockInHand,
    this.unitDefinitionId,
    this.cartonDefinitionId,
    this.actualUnitStock,
    this.actualCartonStock,
    this.organizationId,
    this.avlStockCarton,
    this.avlStockUnit,
    this.qtyCarton,
    this.qtyUnit
  });

  void setQty(int? cartonQty,int? unitQty){
    qtyCarton=cartonQty;
    qtyUnit=unitQty;
  }

  void setAvlStock(int? avlCartonQty,int? avlUnitQty) {
     avlStockCarton= avlCartonQty;
    avlStockUnit = avlUnitQty;
  }
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
