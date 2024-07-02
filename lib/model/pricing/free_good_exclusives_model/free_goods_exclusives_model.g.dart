// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'free_goods_exclusives_model.dart';

FreeGoodExclusivesModel _$FreeGoodExclusivesFromJson(Map<String, dynamic> json) {
  return FreeGoodExclusivesModel(
    freeGoodExclusiveId: json['freeGoodExclusiveId'] as int?,
    freeGoodGroupId: json['freeGoodGroupId'] as int?,
    productId: json['productId'] as int?,
    productCode: json['productCode'] as String?,
    productName: json['productName'] as String?,
    productDefinitionId: json['productDefinitionId'] as int?,
    quantity: json['quantity'] as int?,
    maximumFreeGoodQuantity: json['maximumFreeGoodQuantity'] as int?,
    offerType: json['offerType'] as String?,
    status: json['status'] as String?,
    productDefinitions: (jsonDecode(json['productDefinitions']) as List<dynamic>?)
        ?.map((e) => KeyValue.fromJson(e as Map<String, dynamic>))
        .toList(),
    isDeleted: json['isDeleted'] as bool?,
  );
}

Map<String, dynamic> _$FreeGoodExclusivesToJson(
    FreeGoodExclusivesModel instance) =>
    <String, dynamic>{
      'freeGoodExclusiveId': instance.freeGoodExclusiveId,
      'freeGoodGroupId': instance.freeGoodGroupId,
      'productId': instance.productId,
      'productCode': instance.productCode,
      'productName': instance.productName,
      'productDefinitionId': instance.productDefinitionId,
      'quantity': instance.quantity,
      'maximumFreeGoodQuantity': instance.maximumFreeGoodQuantity,
      'offerType': instance.offerType,
      'status': instance.status,
      'productDefinitions': jsonEncode(instance.productDefinitions),
      'isDeleted':boolToInt (instance.isDeleted),
    };
