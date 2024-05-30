part of 'group_free_good_details.dart';

GroupFreeGoodDetails _$GroupFreeGoodDetailsFromJson(Map<String, dynamic> json) {
  return GroupFreeGoodDetails(
    id: json['id'] as int,
    freeGoodGroupId: json['freeGoodGroupId'] as int,
    productId: json['productId'] as int,
    productName: json['productName'] as String,
    productDefinitionId: json['productDefinitionId'] as int,
    productCode: json['productCode'] as String,
    productSize: json['productSize'] as String,
    freeGoodQuantity: json['freeGoodQuantity'] as int,
    minimumQuantity: json['minimumQuantity'] as int,
    maximumQuantity: json['maximumQuantity'] as int,
    isActive: boolFromInt(json['isActive'] as int),
    isDeleted: boolFromInt(json['isDeleted'] as int),
    productDefinitions: (jsonDecode(json['productDefinitions']) as List<dynamic>)
        .map((e) => KeyValue.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$GroupFreeGoodDetailsToJson(GroupFreeGoodDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'freeGoodGroupId': instance.freeGoodGroupId,
      'productId': instance.productId,
      'productName': instance.productName,
      'productDefinitionId': instance.productDefinitionId,
      'productCode': instance.productCode,
      'productSize': instance.productSize,
      'freeGoodQuantity': instance.freeGoodQuantity,
      'minimumQuantity': instance.minimumQuantity,
      'maximumQuantity': instance.maximumQuantity,
      'isActive': boolToInt(instance.isActive),
      'isDeleted': boolToInt(instance.isDeleted),
      'productDefinitions': jsonEncode(instance.productDefinitions),
    };
