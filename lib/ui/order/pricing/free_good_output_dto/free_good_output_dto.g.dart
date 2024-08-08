part of 'free_good_output_dto.dart';

FreeGoodOutputDTO _$FreeGoodOutputDTOFromJson(Map<String, dynamic> json) {
  return FreeGoodOutputDTO(
    freeGoodGroupId: json['freeGoodGroupId'] as int?,
    freeGoodDetailId: json['freeGoodDetailId'] as int?,
    freeGoodExclusiveId: json['freeGoodExclusiveId'] as int?,
    productId: json['productId'] as int?,
    productName: json['productName'] as String?,
    productCode: json['productCode'] as String?,
    productDefinitionId: json['productDefinitionId'] as int?,
    productSize: json['productSize'] as String?,
    isDefault: json['isDefault'] as bool?,
    definitionCode: json['definitionCode'] as String?,
    stockInHand: json['stockInHand'] as int?,
    maximumFreeGoodQuantity: json['maximumFreeGoodQuantity'] as int?,
    freeGoodQuantity: json['freeGoodQuantity'] as int?,
    freeGoodTypeId: json['freeGoodTypeId'] as int?,
    finalFreeGoodsQuantity: json['finalFreeGoodsQuantity'] as int?,
    qualifiedFreeGoodQuantity: json['qualifiedFreeGoodQuantity'] as int?,
    messages: (json['messages'] as List<dynamic>?)
        ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
        .toList(),
    parentId: json['parentId'] as int?,
    forEachQuantity: json['forEachQuantity'] as int?,
    isBundle: json['isBundle'] as bool?,
    freeQuantityTypeId: json['freeQuantityTypeId'] as int?,
  );
}

Map<String, dynamic> _$FreeGoodOutputDTOToJson(FreeGoodOutputDTO instance) => <String, dynamic>{
  'freeGoodGroupId': instance.freeGoodGroupId,
  'freeGoodDetailId': instance.freeGoodDetailId,
  'freeGoodExclusiveId': instance.freeGoodExclusiveId,
  'productId': instance.productId,
  'productName': instance.productName,
  'productCode': instance.productCode,
  'productDefinitionId': instance.productDefinitionId,
  'productSize': instance.productSize,
  'isDefault': instance.isDefault,
  'definitionCode': instance.definitionCode,
  'stockInHand': instance.stockInHand,
  'maximumFreeGoodQuantity': instance.maximumFreeGoodQuantity,
  'freeGoodQuantity': instance.freeGoodQuantity,
  'freeGoodTypeId': instance.freeGoodTypeId,
  'finalFreeGoodsQuantity': instance.finalFreeGoodsQuantity,
  'qualifiedFreeGoodQuantity': instance.qualifiedFreeGoodQuantity,
  'messages': instance.messages?.map((e) => e.toJson()).toList(),
  'parentId': instance.parentId,
  'forEachQuantity': instance.forEachQuantity,
  'isBundle': instance.isBundle,
  'freeQuantityTypeId': instance.freeQuantityTypeId,
};
