// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lookup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LookUpModel _$LookUpFromJson(Map<String, dynamic> json) {
  return LookUpModel(
    lookUpId: json['lookUpId'] as int?,
    assetStatus: (json['assetStatus'] as List<dynamic>?)
        ?.map((e) => AssetStatusModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    marketReturnReasons: (json['marketReturnReasons'] as List<dynamic>?)
        ?.map((e) => MarketReturnReason.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LookUpToJson(LookUpModel instance) => <String, dynamic>{
      'lookUpId': instance.lookUpId,
      'assetStatus': jsonEncode(instance.assetStatus),
      'marketReturnReasons':jsonEncode(instance.marketReturnReasons),
    };
