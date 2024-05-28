// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'free_goods_detail.dart';

FreeGoodDetails _$FreeGoodDetailsFromJson(Map<String, dynamic> json) {
  return FreeGoodDetails(
    freeGoodDetailId: json['freeGoodDetailId'] as int?,
    freeGoodMasterId: json['freeGoodMasterId'] as int?,
    productId: json['productId'] as int?,
    productCode: json['productCode'] as String?,
    productName: json['productName'] as String?,
    productDefinitionId: json['productDefinitionId'] as int?,
    typeId: json['typeId'] as int?,
    typeText: json['typeText'] as String?,
    minimimQuantity: json['minimimQuantity'] as int?,
    forEachQuantity: json['forEachQuantity'] as int?,
    freeGoodQuantity: json['freeGoodQuantity'] as int?,
    freeGoodGroupId: json['freeGoodGroupId'] as int?,
    maximumFreeGoodQuantity: json['maximumFreeGoodQuantity'] as int?,
    startDate: json['startDate'] as String?,
    endDate: json['endDate'] as String?,
    isActive: json['isActive'] as bool?,
    status: json['status'] as String?,
    isDifferentProduct: json['isDifferentProduct'] as bool?,
    freeGoodExclusives: (jsonDecode(json['freeGoodExclusives']) as List<dynamic>?)
        ?.map((e) => FreeGoodExclusives.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FreeGoodDetailsToJson(FreeGoodDetails instance) =>
    <String, dynamic>{
      'freeGoodDetailId': instance.freeGoodDetailId,
      'freeGoodMasterId': instance.freeGoodMasterId,
      'productId': instance.productId,
      'productCode': instance.productCode,
      'productName': instance.productName,
      'productDefinitionId': instance.productDefinitionId,
      'typeId': instance.typeId,
      'typeText': instance.typeText,
      'minimimQuantity': instance.minimimQuantity,
      'forEachQuantity': instance.forEachQuantity,
      'freeGoodQuantity': instance.freeGoodQuantity,
      'freeGoodGroupId': instance.freeGoodGroupId,
      'maximumFreeGoodQuantity': instance.maximumFreeGoodQuantity,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'isActive': instance.isActive,
      'status': instance.status,
      'isDifferentProduct': instance.isDifferentProduct,
      'freeGoodExclusives': jsonEncode(instance.freeGoodExclusives),
    };
