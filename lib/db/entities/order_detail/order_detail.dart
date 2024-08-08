import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../carton_price_breakdown/carton_price_breakdown.dart';
import '../unit_price_breakdown/unit_price_breakdown.dart';

part 'order_detail.g.dart';

@JsonSerializable()
class OrderDetail {
  @JsonKey(name: 'pk_modid')
  int? orderDetailId;

  @JsonKey(name: 'mobileOrderId')
  int? mLocalOrderId;

  @JsonKey(name: 'orderId')
  int? mOrderId;

  @JsonKey(name: 'productId')
  int? mProductId;

  @JsonKey(name: 'packageId')
  int? packageId;

  @JsonKey(name: 'unitOrderDetailId')
  int? mUnitOrderDetailId;

  @JsonKey(name: 'cartonOrderDetailId')
  int? mCartonOrderDetailId;

  @JsonKey(name: 'productGroupId')
  int? mProductGroupId;

  @JsonKey(name: 'unitFreeGoodGroupId')
  int? unitFreeGoodGroupId;

  @JsonKey(name: 'cartonFreeGoodGroupId')
  int? cartonFreeGoodGroupId;

  @JsonKey(name: 'unitFreeGoodDetailId')
  int? unitFreeGoodDetailId;

  @JsonKey(name: 'cartonFreeGoodDetailId')
  int? cartonFreeGoodDetailId;

  @JsonKey(name: 'unitFreeGoodExclusiveId')
  int? unitFreeGoodExclusiveId;

  @JsonKey(name: 'cartonFreeGoodExclusiveId')
  int? cartonFreeGoodExclusiveId;


  String? mProductName;

  @JsonKey(name: 'cartonQuantity')
  int? mCartonQuantity;

  @JsonKey(name: 'unitQuantity')
  int? mUnitQuantity;

  @JsonKey(name: 'avlUnitQuantity')
  int? avlUnitQuantity;

  @JsonKey(name: 'avlCartonQuantity')
  int? avlCartonQuantity;

  @JsonKey(name: 'unitDefinitionId')
  int? unitDefinitionId;

  @JsonKey(name: 'cartonDefinitionId')
  int? cartonDefinitionId;

  @JsonKey(name: 'actualUnitStock')
  int? actualUnitStock;

  @JsonKey(name: 'actualCartonStock')
  int? actualCartonStock;

  int? cartonSize;

  String? mCartonCode;

  String? mUnitCode;

  double? unitPrice;

  double? cartonPrice;

  double? unitTotalPrice;

  double? cartonTotalPrice;

  double? total;

  double? subtotal;

  String? type;

  @JsonKey(name: 'unitFreeQuantityTypeId')
  int? unitFreeQuantityTypeId;

  @JsonKey(name: 'cartonFreeQuantityTypeId')
  int? cartonFreeQuantityTypeId;

  int? unitFreeGoodQuantity;

  int? cartonFreeGoodQuantity;

  int? unitSelectedFreeGoodQuantity;

  int? cartonSelectedFreeGoodQuantity;

  int? parentId;

  List<CartonPriceBreakDown>? cartonPriceBreakDown;

  List<UnitPriceBreakDown>? unitPriceBreakDown;

  List<OrderDetail>? cartonFreeGoods;

  List<OrderDetail>? unitFreeGoods;


 int? productTempDefinitionId; // this definitionId sets on PriceCalculation


 int ?productTempQuantity;


  OrderDetail(
      {this.mLocalOrderId,
      this.mProductId,
      this.mCartonQuantity,
      this.mUnitQuantity});


  void setAvlQty(int avlCartonQuantity, int avlUnitQuantity) {
    this.avlCartonQuantity = avlCartonQuantity;
    this.avlUnitQuantity = avlUnitQuantity;
  }

  String getQuantity(){
    return "${mCartonQuantity??0}/${mUnitQuantity??0}";
  }

  String getWithoutUnitQuantity(){
    return "${mCartonQuantity??0}";
  }


  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);

}
