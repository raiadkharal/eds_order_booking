// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchandise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchandiseModel _$MerchandiseFromJson(Map<String, dynamic> json) {
  return MerchandiseModel(
    outletId: json['outletId'] as int?,
    remarks: json['remarks'] as String?,
    merchandiseImages: ((json['merchandiseImages'] is String)
            ? jsonDecode(json['merchandiseImages'])
            : json['merchandiseImages'] as List<dynamic>?)
        ?.map<MerchandiseImage>((e) => MerchandiseImage.fromJson(e as Map<String, dynamic>))
        .toList(),
    assetList: ((json['assets'] is String)
            ? jsonDecode(json['assets'])
            : json['assets'] as List<dynamic>?)
        ?.map<AssetModel>((e) => AssetModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MerchandiseToJson(MerchandiseModel instance) =>
    <String, dynamic>{
      'outletId': instance.outletId,
      'remarks': instance.remarks,
      'merchandiseImages': instance.merchandiseImages?.map((e) => e.toJson(),).toList(),
      'assets': instance.assetList?.map((e) => e.toJson(),).toList(),
    };

Map<String, dynamic> _$SerializeToJsonWithExcludedFields(MerchandiseModel instance) =>
    <String, dynamic>{
      'outletId': instance.outletId,
      'remarks': instance.remarks,
      'merchandiseImages': instance.merchandiseImages?.map((e) => e.toJson(),).toList(),
      'assets': instance.assetList?.map((e) => e.toJson(),).toList(),
    };
