import 'package:json_annotation/json_annotation.dart';

part 'item_amount_dto.g.dart';

@JsonSerializable()
class ItemAmountDTO {
  bool? isMaxLimitReached;
  double? totalPrice;
  double? blockPrice;
  int? actualQuantity;

  ItemAmountDTO({
    this.isMaxLimitReached,
    this.totalPrice,
    this.blockPrice,
    this.actualQuantity,
  });

  factory ItemAmountDTO.fromJson(Map<String, dynamic> json) => _$ItemAmountDTOFromJson(json);
  Map<String, dynamic> toJson() => _$ItemAmountDTOToJson(this);
}
