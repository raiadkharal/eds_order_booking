// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_amount_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemAmountDTO _$ItemAmountDTOFromJson(Map<String, dynamic> json) => ItemAmountDTO(
  isMaxLimitReached: json['isMaxLimitReached'] as bool,
  totalPrice: (json['totalPrice'] as num).toDouble(),
  blockPrice: (json['blockPrice'] as num).toDouble(),
  actualQuantity: json['actualQuantity'] as int,
);

Map<String, dynamic> _$ItemAmountDTOToJson(ItemAmountDTO instance) => <String, dynamic>{
  'isMaxLimitReached': instance.isMaxLimitReached,
  'totalPrice': instance.totalPrice,
  'blockPrice': instance.blockPrice,
  'actualQuantity': instance.actualQuantity,
};
