import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/model/pricing/free_good_exclusives_model/free_goods_exclusives_model.dart';
import 'package:order_booking/model/pricing/free_good_groups_model/free_good_groups_model.dart';
import 'package:order_booking/model/pricing/free_good_masters_model/free_good_masters_model.dart';
import 'package:order_booking/model/pricing/free_goods_detail_model/free_goods_detail_model.dart';

import '../../../db/entities/pricing/free_goods_entity_details/free_good_entity_details.dart';
import '../free_price_condition_outlet_attributes/free_price_condition_outlet_attributes.dart';
import '../outlet_availed_free_goods/outlet_availed_free_goods.dart';

part 'free_goods_wrapper_model.g.dart';

@JsonSerializable()
class FreeGoodsWrapperModel {
  @JsonKey(name: 'freeGoodMasters')
  final List<FreeGoodMastersModel>? freeGoodMasters;

  @JsonKey(name: 'freeGoodGroups')
  final List<FreeGoodGroupsModel>? freeGoodGroups;

  @JsonKey(name: 'priceConditionOutletAttributes')
  final List<FreePriceConditionOutletAttributes>? priceConditionOutletAttributes;

  @JsonKey(name: 'freeGoodDetails')
  final List<FreeGoodDetailsModel>? freeGoodDetails;

  @JsonKey(name: 'freeGoodExclusives')
  final List<FreeGoodExclusivesModel>? freeGoodExclusives;

  @JsonKey(name: 'freeGoodEntityDetails')
  final List<FreeGoodEntityDetails>? freeGoodEntityDetails;

  @JsonKey(name: 'outletAvailedFreeGoods')
  final List<OutletAvailedFreeGoods>? outletAvailedFreeGoods;

  FreeGoodsWrapperModel({
    this.freeGoodMasters,
    this.freeGoodGroups,
    this.priceConditionOutletAttributes,
    this.freeGoodDetails,
    this.freeGoodExclusives,
    this.freeGoodEntityDetails,
    this.outletAvailedFreeGoods,
  });

  factory FreeGoodsWrapperModel.fromJson(Map<String, dynamic> json) => _$FreeGoodsWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$FreeGoodsWrapperToJson(this);
}
