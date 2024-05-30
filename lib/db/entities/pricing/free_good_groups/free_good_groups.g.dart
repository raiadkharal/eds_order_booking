part of 'free_good_groups.dart';

FreeGoodGroups _$FreeGoodGroupsFromJson(Map<String, dynamic> json) {
  return FreeGoodGroups(
    id: json['id'] as int,
    freeGoodMasterId: json['freeGoodMasterId'] as int,
    name: json['name'] as String,
    typeId: json['typeId'] as int,
    minimumQuantity: json['minimumQuantity'] as int,
    forEachQuantity: json['forEachQuantity'] as int,
    maximumQuantity: json['maximumQuantity'] as int,
    isActive: boolFromInt(json['isActive'] as int),
    isDeleted: boolFromInt(json['isDeleted'] as int),
    isDifferentProduct: boolFromInt(json['isDifferentProduct'] as int),
    freeQuantity: json['freeQuantity'] as int,
    freeQuantityTypeId: json['freeQuantityTypeId'] as int,
    groupFreeGoodDetails: (jsonDecode(json['groupFreeGoodDetails']) as List<dynamic>)
        .map((e) => GroupFreeGoodDetails.fromJson(e as Map<String, dynamic>))
        .toList(),
    freeGoodExclusives: (jsonDecode(json['freeGoodExclusives']) as List<dynamic>)
        .map((e) => FreeGoodExclusives.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FreeGoodGroupsToJson(FreeGoodGroups instance) =>
    <String, dynamic>{
      'id': instance.id,
      'freeGoodMasterId': instance.freeGoodMasterId,
      'name': instance.name,
      'typeId': instance.typeId,
      'minimumQuantity': instance.minimumQuantity,
      'forEachQuantity': instance.forEachQuantity,
      'maximumQuantity': instance.maximumQuantity,
      'isActive': boolToInt(instance.isActive),
      'isDeleted': boolToInt(instance.isDeleted),
      'isDifferentProduct': boolToInt(instance.isDifferentProduct),
      'freeQuantity': instance.freeQuantity,
      'freeQuantityTypeId': instance.freeQuantityTypeId,
      'groupFreeGoodDetails':
      jsonEncode(instance.groupFreeGoodDetails),
      'freeGoodExclusives':
     jsonEncode(instance.freeGoodExclusives),
    };
