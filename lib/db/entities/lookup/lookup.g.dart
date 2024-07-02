// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lookup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LookUp _$LookUpFromJson(Map<String, dynamic> json) {
  return LookUp(
    lookUpId: json['lookUpId'] as int?,
    assetStatus: (jsonDecode(json['assetStatus']) as List<dynamic>?)
        ?.map((e) => AssetStatus.fromJson(e as Map<String, dynamic>))
        .toList(),
    marketReturnReasons: (jsonDecode(json['marketReturnReasons']) as List<dynamic>?)
        ?.map((e) => MarketReturnReason.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LookUpToJson(LookUp instance) => <String, dynamic>{
      'lookUpId': instance.lookUpId,
      'assetStatus': jsonEncode(instance.assetStatus),
      'marketReturnReasons': jsonEncode(instance.marketReturnReasons),
    };
