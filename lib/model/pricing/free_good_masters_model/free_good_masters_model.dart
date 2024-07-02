import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/model/pricing/free_good_groups_model/free_good_groups_model.dart';
import 'package:order_booking/model/pricing/free_goods_detail_model/free_goods_detail_model.dart';
import 'package:order_booking/utils/utils.dart';

import '../../../db/entities/pricing/free_goods_entity_details/free_good_entity_details.dart';


part 'free_good_masters_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FreeGoodMastersModel {
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
  List<FreeGoodGroupsModel>? freeGoodGroups;

  @JsonKey(name: 'freeGoodDetails')
  List<FreeGoodDetailsModel>? freeGoodDetails;

  @JsonKey(name: 'freeGoodEntityDetails')
  List<FreeGoodEntityDetails>? freeGoodEntityDetails;

  FreeGoodMastersModel({
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

  factory FreeGoodMastersModel.fromJson(Map<String, dynamic> json) => _$FreeGoodMastersFromJson(json);

  Map<String, dynamic> toJson() => _$FreeGoodMastersToJson(this);
}
