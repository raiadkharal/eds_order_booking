import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/utils/utils.dart';

import '../key_value/key_value.dart';


part 'free_goods_exclusives_model.g.dart';

@JsonSerializable()
class FreeGoodExclusivesModel {
  @JsonKey(name: 'freeGoodExclusiveId')
  final int? freeGoodExclusiveId;

  @JsonKey(name: 'freeGoodGroupId')
  final int? freeGoodGroupId;

  @JsonKey(name: 'productId')
  final int? productId;

  @JsonKey(name: 'productCode')
  final String? productCode;

  @JsonKey(name: 'productName')
  final String? productName;

  @JsonKey(name: 'productDefinitionId')
  final int? productDefinitionId;

  @JsonKey(name: 'quantity')
  final int? quantity;

  @JsonKey(name: 'maximumFreeGoodQuantity')
  final int? maximumFreeGoodQuantity;

  @JsonKey(name: 'offerType')
  final String? offerType;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'productDefinitions')
  final List<KeyValue>? productDefinitions;

  @JsonKey(name: 'isDeleted')
  final bool? isDeleted;

  FreeGoodExclusivesModel({
    this.freeGoodExclusiveId,
    this.freeGoodGroupId,
    this.productId,
    this.productCode,
    this.productName,
    this.productDefinitionId,
    this.quantity,
    this.maximumFreeGoodQuantity,
    this.offerType,
    this.status,
    this.productDefinitions,
    this.isDeleted,
  });

  factory FreeGoodExclusivesModel.fromJson(Map<String, dynamic> json) =>
      _$FreeGoodExclusivesFromJson(json);

  Map<String, dynamic> toJson() => _$FreeGoodExclusivesToJson(this);
}
