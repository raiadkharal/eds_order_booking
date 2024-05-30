part of 'free_good_masters.dart';

FreeGoodMasters _$FreeGoodMastersFromJson(Map<String, dynamic> json) {
  return FreeGoodMasters(
    freeGoodMasterId: json['freeGoodMasterId'] as int?,
    name: json['name'] as String?,
    isActive:  boolFromInt(json['isActive'] as int?),
    isDeleted:  boolFromInt(json['isDeleted'] as int?),
    isBundle: boolFromInt(json['isBundle'] as int?),
    accessSequenceId: json['accessSequenceId'] as int?,
    accessSequenceText: json['accessSequenceText'] as String?,
    freeGoodGroups: (jsonDecode(json['freeGoodGroups']) as List<dynamic>?)
        ?.map((e) => FreeGoodGroups.fromJson(e as Map<String, dynamic>))
        .toList(),
    freeGoodDetails: (jsonDecode(json['freeGoodDetails']) as List<dynamic>?)
        ?.map((e) => FreeGoodDetails.fromJson(e as Map<String, dynamic>))
        .toList(),
    freeGoodEntityDetails: (jsonDecode(json['freeGoodEntityDetails']) as List<dynamic>?)
        ?.map((e) => FreeGoodEntityDetails.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FreeGoodMastersToJson(FreeGoodMasters instance) => <String, dynamic>{
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
