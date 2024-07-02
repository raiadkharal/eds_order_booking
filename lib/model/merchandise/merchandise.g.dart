// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchandise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Merchandise _$MerchandiseFromJson(Map<String, dynamic> json) {
  return Merchandise(
    outletId: json['outletId'] as int?,
    remarks: json['remarks'] as String?,
    merchandiseImages: ((json['merchandiseImages']) as List<dynamic>?)
        ?.map((e) => MerchandiseImage.fromJson(e as Map<String, dynamic>))
        .toList(),
    assetList: ((json['assets']) as List<dynamic>?)
        ?.map((e) => AssetModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MerchandiseToJson(Merchandise instance) =>
    <String, dynamic>{
      'outletId': instance.outletId,
      'remarks': instance.remarks,
      'merchandiseImages':( instance.merchandiseImages),
      'assets': (instance.assetList),
    };
