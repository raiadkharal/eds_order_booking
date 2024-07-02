import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/utils/utils.dart';

import '../key_value/key_value.dart';

part 'group_free_good_details.g.dart';

@JsonSerializable()
class GroupFreeGoodDetails {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'freeGoodGroupId')
  final int freeGoodGroupId;

  @JsonKey(name: 'productId')
  final int productId;

  @JsonKey(name: 'productName')
  final String productName;

  @JsonKey(name: 'productDefinitionId')
  final int productDefinitionId;

  @JsonKey(name: 'productCode')
  final String productCode;

  @JsonKey(name: 'productSize')
  final String productSize;

  @JsonKey(name: 'freeGoodQuantity')
  final int freeGoodQuantity;

  @JsonKey(name: 'minimumQuantity')
  final int minimumQuantity;

  @JsonKey(name: 'maximumQuantity')
  final int maximumQuantity;

  @JsonKey(name: 'isActive',toJson: boolToInt,fromJson: boolFromInt)
  final bool isActive;

  @JsonKey(name: 'isDeleted',toJson: boolToInt,fromJson: boolFromInt)
  final bool isDeleted;

  @JsonKey(name: 'productDefinitions')
  final List<KeyValue> productDefinitions;

  GroupFreeGoodDetails({
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

  factory GroupFreeGoodDetails.fromJson(Map<String, dynamic> json) =>
      _$GroupFreeGoodDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$GroupFreeGoodDetailsToJson(this);
}
