import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../utils/utils.dart';
import '../../../pricing_model/group_free_good_details/group_free_good_details.dart';
import '../free_good_exclusives/free_goods_exclusives.dart';

part 'free_good_groups.g.dart';

@JsonSerializable()
class FreeGoodGroups {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'freeGoodMasterId')
  int? freeGoodMasterId;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'typeId')
  int? typeId;

  @JsonKey(name: 'minimumQuantity')
  int? minimumQuantity;

  @JsonKey(name: 'forEachQuantity')
  int? forEachQuantity;

  @JsonKey(name: 'maximumQuantity')
  int? maximumQuantity;

  @JsonKey(name: 'isActive',toJson: boolToInt,fromJson: boolFromInt)
  bool? isActive;

  @JsonKey(name: 'isDeleted',toJson: boolToInt,fromJson: boolFromInt)
  bool? isDeleted;

  @JsonKey(name: 'isDifferentProduct',toJson: boolToInt,fromJson: boolFromInt)
  bool? isDifferentProduct;

  @JsonKey(name: 'freeQuantity')
  int? freeQuantity;

  @JsonKey(name: 'freeQuantityTypeId')
  int? freeQuantityTypeId;

  @JsonKey(name: 'groupFreeGoodDetails')
  List<GroupFreeGoodDetails>? groupFreeGoodDetails;

  @JsonKey(name: 'freeGoodExclusives')
  List<FreeGoodExclusives>? freeGoodExclusives;

  @JsonKey(ignore: true)
  int? outletChannelAttributeCount;

  @JsonKey(ignore: true)
  int? channelAttributeCount;

  @JsonKey(ignore: true)
  int? outletGroupAttributeCount;

  @JsonKey(ignore: true)
  int? groupAttributeCount;

  @JsonKey(ignore: true)
  int? outletVPOAttributeCount;

  @JsonKey(ignore: true)
  int? vpoAttributeCount;

  FreeGoodGroups({
    this.id,
    this.freeGoodMasterId,
    this.name,
    this.typeId,
    this.minimumQuantity,
    this.forEachQuantity,
    this.maximumQuantity,
    this.isActive,
    this.isDeleted,
    this.isDifferentProduct,
    this.freeQuantity,
    this.freeQuantityTypeId,
    this.groupFreeGoodDetails,
    this.freeGoodExclusives,
    this.outletChannelAttributeCount = 0,
    this.channelAttributeCount = 0,
    this.outletGroupAttributeCount = 0,
    this.groupAttributeCount = 0,
    this.outletVPOAttributeCount = 0,
    this.vpoAttributeCount = 0,
  });

  factory FreeGoodGroups.fromJson(Map<String, dynamic> json) =>
      _$FreeGoodGroupsFromJson(json);

  Map<String, dynamic> toJson() => _$FreeGoodGroupsToJson(this);
}
