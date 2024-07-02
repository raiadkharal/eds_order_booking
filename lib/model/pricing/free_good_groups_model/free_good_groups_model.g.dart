part of 'free_good_groups_model.dart';

FreeGoodGroupsModel _$FreeGoodGroupsFromJson(Map<String, dynamic> json) {
  return FreeGoodGroupsModel(
    id: json['id'] as int?,
    freeGoodMasterId: json['freeGoodMasterId'] as int?,
    name: json['name'] as String?,
    typeId: json['typeId'] as int?,
    minimumQuantity: json['minimumQuantity'] as int?,
    forEachQuantity: json['forEachQuantity'] as int?,
    maximumQuantity: json['maximumQuantity'] as int?,
    isActive: (json['isActive'] as bool?),
    isDeleted: (json['isDeleted'] as bool?),
    isDifferentProduct: (json['isDifferentProduct'] as bool?),
    freeQuantity: json['freeQuantity'] as int?,
    freeQuantityTypeId: json['freeQuantityTypeId'] as int?,
    groupFreeGoodDetails: (jsonDecode(json['groupFreeGoodDetails']) as List<dynamic>?)
        ?.map((e) => GroupFreeGoodDetailsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    freeGoodExclusives: (jsonDecode(json['freeGoodExclusives']) as List<dynamic>?)
        ?.map((e) => FreeGoodExclusivesModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FreeGoodGroupsToJson(FreeGoodGroupsModel instance) =>
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
