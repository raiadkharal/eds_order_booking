import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../utils/util.dart';
import '../../../pricing_model/group_free_good_details/group_free_good_details.dart';
import '../free_good_exclusives/free_goods_exclusives.dart';

part 'free_good_groups.g.dart';

@JsonSerializable()
class FreeGoodGroups {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'freeGoodMasterId')
  final int freeGoodMasterId;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'typeId')
  final int typeId;

  @JsonKey(name: 'minimumQuantity')
  final int minimumQuantity;

  @JsonKey(name: 'forEachQuantity')
  final int forEachQuantity;

  @JsonKey(name: 'maximumQuantity')
  final int maximumQuantity;

  @JsonKey(name: 'isActive',toJson: boolToInt,fromJson: boolFromInt)
  final bool isActive;

  @JsonKey(name: 'isDeleted',toJson: boolToInt,fromJson: boolFromInt)
  final bool isDeleted;

  @JsonKey(name: 'isDifferentProduct',toJson: boolToInt,fromJson: boolFromInt)
  final bool isDifferentProduct;

  @JsonKey(name: 'freeQuantity')
  final int freeQuantity;

  @JsonKey(name: 'freeQuantityTypeId')
  final int freeQuantityTypeId;

  @JsonKey(name: 'groupFreeGoodDetails')
  final List<GroupFreeGoodDetails> groupFreeGoodDetails;

  @JsonKey(name: 'freeGoodExclusives')
  final List<FreeGoodExclusives> freeGoodExclusives;

  @JsonKey(ignore: true)
  final int outletChannelAttributeCount;

  @JsonKey(ignore: true)
  final int channelAttributeCount;

  @JsonKey(ignore: true)
  final int outletGroupAttributeCount;

  @JsonKey(ignore: true)
  final int groupAttributeCount;

  @JsonKey(ignore: true)
  final int outletVPOAttributeCount;

  @JsonKey(ignore: true)
  final int vpoAttributeCount;

  FreeGoodGroups({
    required this.id,
    required this.freeGoodMasterId,
    required this.name,
    required this.typeId,
    required this.minimumQuantity,
    required this.forEachQuantity,
    required this.maximumQuantity,
    required this.isActive,
    required this.isDeleted,
    required this.isDifferentProduct,
    required this.freeQuantity,
    required this.freeQuantityTypeId,
    required this.groupFreeGoodDetails,
    required this.freeGoodExclusives,
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
