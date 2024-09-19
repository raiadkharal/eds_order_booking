import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/model/carton_price_breakdown/carton_price_breakdown_model.dart';
import 'package:order_booking/model/unit_price_breakdown_model/unit_price_breakdown_model.dart';
part 'order_detail_model.g.dart';

@JsonSerializable()
class OrderDetailModel {
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

  @JsonKey(name: 'unitFreeGoodExclusiveId')
  int? unitFreeGoodExclusiveId;

  @JsonKey(name: 'cartonFreeGoodExclusiveId')
  int? cartonFreeGoodExclusiveId;

  int? unitFreeGoodQuantity;

  int? cartonFreeGoodQuantity;

  int? unitSelectedFreeGoodQuantity;

  int? cartonSelectedFreeGoodQuantity;

  int? parentId;

  List<CartonPriceBreakDownModel>? cartonPriceBreakDown;

  List<UnitPriceBreakDownModel>? unitPriceBreakDown;

  List<OrderDetailModel>? cartonFreeGoods;

  List<OrderDetailModel>? unitFreeGoods;

  OrderDetailModel(
      {this.mOrderId,
        this.mProductId,
        this.mCartonQuantity,
        this.mUnitQuantity}
      );


  void setAvlQty(int avlCartonQuantity, int avlUnitQuantity) {
    this.avlCartonQuantity = avlCartonQuantity;
    this.avlUnitQuantity = avlUnitQuantity;
  }

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);
  Map<String, dynamic> serialize() => _$SerializeToJsonWithExcludedFields(this);
}


