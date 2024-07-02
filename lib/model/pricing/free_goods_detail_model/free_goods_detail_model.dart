import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/model/pricing/free_good_exclusives_model/free_goods_exclusives_model.dart';
import 'package:order_booking/utils/utils.dart';

part 'free_goods_detail_model.g.dart';

@JsonSerializable()
class FreeGoodDetailsModel {
  @JsonKey(name: 'freeGoodDetailId')
  final int? freeGoodDetailId;

  @JsonKey(name: 'freeGoodMasterId')
  final int? freeGoodMasterId;

  @JsonKey(name: 'productId')
  final int? productId;

  @JsonKey(name: 'productCode')
  final String? productCode;

  @JsonKey(name: 'productName')
  final String? productName;

  @JsonKey(name: 'productDefinitionId')
  final int? productDefinitionId;

  @JsonKey(name: 'typeId')
  final int? typeId;

  @JsonKey(name: 'typeText')
  final String? typeText;

  @JsonKey(name: 'minimimQuantity')
  final int? minimumQuantity;

  @JsonKey(name: 'forEachQuantity')
  final int? forEachQuantity;

  @JsonKey(name: 'freeGoodQuantity')
  final int? freeGoodQuantity;

  @JsonKey(name: 'freeGoodGroupId')
  final int? freeGoodGroupId;

  @JsonKey(name: 'maximumFreeGoodQuantity')
  final int? maximumFreeGoodQuantity;

  @JsonKey(name: 'startDate')
  final String? startDate;

  @JsonKey(name: 'endDate')
  final String? endDate;

  @JsonKey(name: 'isActive')
  final bool? isActive;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'isDifferentProduct')
  final bool? isDifferentProduct;

  @JsonKey(name: 'freeGoodExclusives')
  final List<FreeGoodExclusivesModel>? freeGoodExclusives;

  FreeGoodDetailsModel({
    this.freeGoodDetailId,
    this.freeGoodMasterId,
    this.productId,
    this.productCode,
    this.productName,
    this.productDefinitionId,
    this.typeId,
    this.typeText,
    this.minimumQuantity,
    this.forEachQuantity,
    this.freeGoodQuantity,
    this.freeGoodGroupId,
    this.maximumFreeGoodQuantity,
    this.startDate,
    this.endDate,
    this.isActive,
    this.status,
    this.isDifferentProduct,
    this.freeGoodExclusives,
  });

  factory FreeGoodDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$FreeGoodDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$FreeGoodDetailsToJson(this);
}
