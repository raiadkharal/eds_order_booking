part of 'free_good_masters_model.dart';

FreeGoodMastersModel _$FreeGoodMastersFromJson(Map<String, dynamic> json) {
  return FreeGoodMastersModel(
    freeGoodMasterId: json['freeGoodMasterId'] as int?,
    name: json['name'] as String?,
    isActive:  (json['isActive'] as bool?),
    isDeleted:  (json['isDeleted'] as bool?),
    isBundle: (json['isBundle'] as bool?),
    accessSequenceId: json['accessSequenceId'] as int?,
    accessSequenceText: json['accessSequenceText'] as String?,
    freeGoodGroups: ((json['freeGoodGroups']) as List<dynamic>?)
        ?.map((e) => FreeGoodGroupsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    freeGoodDetails: ((json['freeGoodDetails']) as List<dynamic>?)
        ?.map((e) => FreeGoodDetailsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    freeGoodEntityDetails: ((json['freeGoodEntityDetails']) as List<dynamic>?)
        ?.map((e) => FreeGoodEntityDetails.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FreeGoodMastersToJson(FreeGoodMastersModel instance) => <String, dynamic>{
  'freeGoodMasterId': instance.freeGoodMasterId,
  'name': instance.name,
  'isActive': boolToInt(instance.isActive),
  'isDeleted': boolToInt(instance.isDeleted),
  'isBundle': boolToInt(instance.isBundle),
  'accessSequenceId': instance.accessSequenceId,
  'accessSequenceText': instance.accessSequenceText,
  'freeGoodGroups': jsonEncode(instance.freeGoodGroups),
  'freeGoodDetails': jsonEncode(instance.freeGoodDetails),
  'freeGoodEntityDetails': jsonEncode(instance.freeGoodEntityDetails),
};
