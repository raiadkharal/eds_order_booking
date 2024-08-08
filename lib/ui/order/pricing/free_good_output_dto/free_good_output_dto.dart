import 'package:json_annotation/json_annotation.dart';

import '../message/message.dart';

part 'free_good_output_dto.g.dart';

@JsonSerializable()
class FreeGoodOutputDTO {
  int? freeGoodGroupId;
  int? freeGoodDetailId;
  int? freeGoodExclusiveId;
  int? productId;
  String? productName;
  String? productCode;
  int? productDefinitionId;
  String? productSize;
  bool? isDefault;
  String? definitionCode;
  int? stockInHand;
  int? maximumFreeGoodQuantity;
  int? freeGoodQuantity;
  int? freeGoodTypeId; // Inclusive=1/Exclusive=2
  int? finalFreeGoodsQuantity; // FreeGoodsQuantity If StockInHand > FreeGoodsQuantity ELSE StockInHand OR MaxQuantity
  int? qualifiedFreeGoodQuantity; // FreeGood quantity which the order deserves.
  List<Message>? messages;
  int? parentId;
  int? forEachQuantity;
  bool? isBundle;
  int? freeQuantityTypeId; // Primary, Optional

  FreeGoodOutputDTO({
    this.freeGoodGroupId,
    this.freeGoodDetailId,
    this.freeGoodExclusiveId,
    this.productId,
    this.productName,
    this.productCode,
    this.productDefinitionId,
    this.productSize,
    this.isDefault,
    this.definitionCode,
    this.stockInHand,
    this.maximumFreeGoodQuantity,
    this.freeGoodQuantity,
    this.freeGoodTypeId,
    this.finalFreeGoodsQuantity,
    this.qualifiedFreeGoodQuantity,
    this.messages,
    this.parentId,
    this.forEachQuantity,
    this.isBundle,
    this.freeQuantityTypeId,
  });

  factory FreeGoodOutputDTO.fromJson(Map<String, dynamic> json) => _$FreeGoodOutputDTOFromJson(json);
  Map<String, dynamic> toJson() => _$FreeGoodOutputDTOToJson(this);
}
