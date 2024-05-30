import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../entities/pricing/free_good_exclusives/free_goods_exclusives.dart';
import '../../entities/pricing/free_good_groups/free_good_groups.dart';
import '../../entities/pricing/free_good_masters/free_good_masters.dart';
import '../../entities/pricing/free_goods_detail/free_goods_detail.dart';
import '../../entities/pricing/free_goods_entity_details/free_good_entity_details.dart';
import '../../entities/pricing/free_price_condition_outlet_attributes/free_price_condition_outlet_attributes.dart';
import '../../entities/pricing/outlet_availed_free_goods/outlet_availed_free_goods.dart';

part 'free_goods_wrapper.g.dart';

@JsonSerializable(explicitToJson: true)
class FreeGoodsWrapper {
  @JsonKey(name: 'freeGoodMasters', nullable: true)
  final List<FreeGoodMasters>? freeGoodMasters;

  @JsonKey(name: 'freeGoodGroups', nullable: true)
  final List<FreeGoodGroups>? freeGoodGroups;

  @JsonKey(name: 'priceConditionOutletAttributes', nullable: true)
  final List<FreePriceConditionOutletAttributes>? priceConditionOutletAttributes;

  @JsonKey(name: 'freeGoodDetails', nullable: true)
  final List<FreeGoodDetails>? freeGoodDetails;

  @JsonKey(name: 'freeGoodExclusives', nullable: true)
  final List<FreeGoodExclusives>? freeGoodExclusives;

  @JsonKey(name: 'freeGoodEntityDetails', nullable: true)
  final List<FreeGoodEntityDetails>? freeGoodEntityDetails;

  @JsonKey(name: 'outletAvailedFreeGoods', nullable: true)
  final List<OutletAvailedFreeGoods>? outletAvailedFreeGoods;

  FreeGoodsWrapper({
    this.freeGoodMasters,
    this.freeGoodGroups,
    this.priceConditionOutletAttributes,
    this.freeGoodDetails,
    this.freeGoodExclusives,
    this.freeGoodEntityDetails,
    this.outletAvailedFreeGoods,
  });

  factory FreeGoodsWrapper.fromJson(Map<String, dynamic> json) => _$FreeGoodsWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$FreeGoodsWrapperToJson(this);
}
