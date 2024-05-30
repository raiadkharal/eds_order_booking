import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/utils/util.dart';

import '../free_good_groups/free_good_groups.dart';
import '../free_goods_detail/free_goods_detail.dart';
import '../free_goods_entity_details/free_good_entity_details.dart';


part 'free_good_masters.g.dart';

@JsonSerializable(explicitToJson: true)
class FreeGoodMasters {
  @JsonKey(name: 'freeGoodMasterId')
  int?freeGoodMasterId;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'isActive')
  bool? isActive;

  @JsonKey(name: 'isDeleted')
  bool? isDeleted;

  @JsonKey(name: 'isBundle')
  bool? isBundle;

  @JsonKey(name: 'accessSequenceId')
  int?accessSequenceId;

  @JsonKey(name: 'accessSequenceText')
  String? accessSequenceText;

  @JsonKey(name: 'freeGoodGroups')
  List<FreeGoodGroups>? freeGoodGroups;

  @JsonKey(name: 'freeGoodDetails')
  List<FreeGoodDetails>? freeGoodDetails;

  @JsonKey(name: 'freeGoodEntityDetails')
  List<FreeGoodEntityDetails>? freeGoodEntityDetails;

  FreeGoodMasters({
    this.freeGoodMasterId,
    this.name,
    this.isActive,
    this.isDeleted,
    this.isBundle,
    this.accessSequenceId,
    this.accessSequenceText,
    this.freeGoodGroups,
    this.freeGoodDetails,
    this.freeGoodEntityDetails,
  });

  factory FreeGoodMasters.fromJson(Map<String, dynamic> json) => _$FreeGoodMastersFromJson(json);

  Map<String?, dynamic> toJson() => _$FreeGoodMastersToJson(this);
}
