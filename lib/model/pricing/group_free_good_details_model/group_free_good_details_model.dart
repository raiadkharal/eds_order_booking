import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/utils/utils.dart';

import '../key_value/key_value.dart';

part 'group_free_good_details_model.g.dart';

@JsonSerializable()
class GroupFreeGoodDetailsModel {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'freeGoodGroupId')
  final int? freeGoodGroupId;

  @JsonKey(name: 'productId')
  final int? productId;

  @JsonKey(name: 'productName')
  final String? productName;

  @JsonKey(name: 'productDefinitionId')
  final int? productDefinitionId;

  @JsonKey(name: 'productCode')
  final String? productCode;

  @JsonKey(name: 'productSize')
  final String? productSize;

  @JsonKey(name: 'freeGoodQuantity')
  final int? freeGoodQuantity;

  @JsonKey(name: 'minimumQuantity')
  final int? minimumQuantity;

  @JsonKey(name: 'maximumQuantity')
  final int? maximumQuantity;

  @JsonKey(name: 'isActive')
  final bool? isActive;

  @JsonKey(name: 'isDeleted')
  final bool? isDeleted;

  @JsonKey(name: 'productDefinitions')
  final List<KeyValue>? productDefinitions;

  GroupFreeGoodDetailsModel({
    required this.id,
    required this.freeGoodGroupId,
    required this.productId,
    required this.productName,
    required this.productDefinitionId,
    required this.productCode,
    required this.productSize,
    required this.freeGoodQuantity,
    required this.minimumQuantity,
    required this.maximumQuantity,
    required this.isActive,
    required this.isDeleted,
    required this.productDefinitions,
  });

  factory GroupFreeGoodDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$GroupFreeGoodDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$GroupFreeGoodDetailsToJson(this);
}
